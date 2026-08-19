# PR review thread commands

Read this during phase 5. The awkward part is that `gh pr` has no command for resolving a
review thread — resolution only exists in the GraphQL API, and the thread IDs you need
don't appear in any of the REST responses. So the loop is: list threads via GraphQL,
reply via REST, resolve via GraphQL.

`gh` has jq built in via `-q`, so none of this needs jq installed.

## Repo and PR context

```bash
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
OWNER=${REPO%%/*}; NAME=${REPO##*/}
PR=$(gh pr view --json number -q .number)
```

## List unresolved review threads

Returns thread IDs (for resolving), comment database IDs (for replying), authors and bodies.

```bash
gh api graphql -f query='
query($owner:String!, $name:String!, $pr:Int!) {
  repository(owner:$owner, name:$name) {
    pullRequest(number:$pr) {
      reviewThreads(first:100) {
        nodes {
          id
          isResolved
          isOutdated
          path
          line
          comments(first:20) {
            nodes { databaseId author { login } body }
          }
        }
      }
    }
  }
}' -F owner="$OWNER" -F name="$NAME" -F pr="$PR" \
  -q '.data.repository.pullRequest.reviewThreads.nodes[]
      | select(.isResolved == false)
      | {threadId: .id, path, line,
         comments: [.comments.nodes[] | {id: .databaseId, author: .author.login, body}]}'
```

Filter to the bots you care about by checking `author` against `codex`, `cubic` and their
`-ai` / `[bot]` variants — the exact login differs by installation, so read what's actually
there on the first pass rather than hardcoding a guess.

## Reply to a thread

Replies attach to the *first* comment in the thread (REST, not GraphQL):

```bash
gh api "repos/$OWNER/$NAME/pulls/$PR/comments/<COMMENT_DATABASE_ID>/replies" \
  -f body="Intentional — the retry wrapper already handles this case."
```

## Resolve a thread

```bash
gh api graphql -f query='
mutation($id:ID!) {
  resolveReviewThread(input:{threadId:$id}) { thread { isResolved } }
}' -F id="<THREAD_ID>"
```

## Top-level comments

Bots sometimes post a summary as an ordinary issue comment rather than a review thread.
Those can't be resolved — there's no thread. Read them, act on anything valid, and if a
response is warranted leave one short comment rather than replying to each point:

```bash
gh pr view "$PR" --json comments -q '.comments[] | {author: .author.login, body}'
gh pr comment "$PR" --body "..."
```

## CI status while waiting

```bash
gh pr checks "$PR" --watch --interval 30
gh run view <RUN_ID> --log-failed   # only the failing steps
```

## Notes

- New bot comments arrive as new threads, so re-running the list query each round is enough
  to see what's new; there's no cursor to track.
- A thread marked `isOutdated` refers to a line that has since changed. Usually the fix
  already landed — check before spending time on it.
- If a mutation returns a permissions error, resolving may be restricted to users with write
  access on the repo. Reply to the thread instead and note it in the report; don't retry in a
  loop.
