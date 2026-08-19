---
name: overnight-ship
description: Autonomously take a finished feature branch all the way to a reviewed PR while the user is away — deploy to their dev environment, smoke test it, fix what is fixable, open the PR, work through Codex and Cubic review comments, and leave a report. Use this whenever the user hands off completed work to run unattended — phrases like "take it from here", "ship this overnight", "I am heading to bed, finish this off", "smoke test it and raise the PR", "deploy this and deal with the review comments". Also use it when they ask for that deploy → smoke test → PR → address-comments sequence even partially, or without naming it. Do not use it for work that is not finished yet, since this skill assumes the feature is written and both of you are happy with it.
---

# Overnight Ship

Take a finished feature from "the code is done" to "there's a PR that's been through review, and a report waiting". The user is not at their desk. Nobody is going to answer a question, approve a plan, or unstick you.

## Operating stance

Everything here follows from one fact: **you are the only one awake.** That changes the defaults in three ways.

**Keep moving.** A blocker is not a stopping point, it's a line in the report. If scenario 4 can't run because an org credential expired, run scenarios 5–8 and write down what happened to 4. Stopping early costs the user the whole night; continuing past one broken thing costs them one line of reading.

**Never wait for input.** Don't ask questions, don't present options, don't stop to confirm a plan. The guardrails below are the boundary — inside them, decide and proceed.

**Write it down as it happens.** This run is long, and details from phase 2 need to appear in a report written in phase 6. Keep a scratch log at `/tmp/overnight-<branch-name>.md` and append continuously: scenarios and results, fixes made, blockers hit, test data created. Don't rely on memory or on your context surviving the whole run — the report is a large part of the value here, and one reconstructed at the end from vague recall is worse than useless, because the user will trust it.

## Guardrails

These are the things that would make waking up worse than not having run this at all. Stay inside them; no version of this run justifies crossing one.

- **Dev environment only.** Never apply terraform outside the dev workspace. Verify the workspace before any apply.
- **Third-party orgs: test where you have access, and leave nothing behind.** A Salesforce (or other) org doesn't have to be a sandbox — if you're authenticated to it, testing there is fine. What isn't fine is leftover test data. Check the org alias before every write so you know where your artifacts are, log each one, and remove them all in phase 6. Treat records you didn't create as read-only.
- **Never force-push. Never push to `main`. Never merge the PR. Never `--no-verify`.**
- **Never rewrite shared history** — no rebase-and-force onto a branch that's already been pushed and reviewed.
- **No secrets anywhere public.** PR descriptions, comments and the report are read by other people and by bots. Never paste tokens, keys, connection strings or customer data into them.
- **Destructive dev-DB operations are only for data you created.** Migrating is fine. Dropping or truncating tables you didn't create is not.

If something appears to require crossing one of these, that's a blocker for the report, not a decision to make.

## Phase 0 — Orient

Establish ground truth before deploying. Skipping this is how a run ends up deploying the wrong thing to the wrong place.

1. Confirm the branch and that the working tree is clean. Commit anything outstanding with a sensible message — don't leave the user's work uncommitted.
2. Read the diff against the base branch. This is your source of truth for what to test: the feature description says what was intended, the diff says what actually changed.
3. Check the repo's `CLAUDE.md` and any repo-local skills for deploy, migration and test commands. **Prefer what the repo says over what's written here** — the repo is maintained, this skill is a snapshot.
4. Start the scratch log.

## Phase 1 — Deploy to dev

Choose the deploy path by what kind of change this is:

- **New lambdas, or any new infrastructure resource** → `pnpm run dev:apply`. New resources have to exist before anything else works, so terraform goes first.
- **Changes to existing lambdas only** → `pnpm run dev:lambda:deploy`. Much faster; don't reach for terraform when nothing structural changed.
- **Schema changes** → covered by `pnpm run dev:apply`, which runs the migrations itself. Only run `pnpm run migrate` separately if you took the lambda-deploy path above and the diff also touches the schema.

Decide from the diff: new files under the infra/terraform paths, or new resource blocks, mean the apply path. Edits confined to existing handler code mean the package path.

If AWS SSO has expired, trigger re-auth (`aws sso login`) and continue — it completes in the browser without needing the user, so this is never a blocker.

If the deploy fails, try to fix it; most failures here are ordinary (a missing env var, a stale lock, a mistyped resource name). If it stays broken after a real attempt, **carry on to the PR anyway.** Log what failed and how far it got. A PR that says "couldn't deploy, here's the error" is still worth opening — the review comments are useful regardless, and the user would rather diagnose one clear failure in the morning than find that nothing happened.

## Phase 2 — Smoke test

The goal is to find out whether this works in a real environment, not to demonstrate that it does. Approach it like someone trying to break it.

Derive scenarios from the diff, then aim for coverage along these lines — five to eight is usually about right:

- **Happy path** through each entry point the change touches.
- **Boundaries**: empty input, one item, many items, maximum lengths, unicode.
- **Failure modes it must survive**: the third-party API erroring or timing out, expired or revoked auth, a malformed payload.
- **State edge cases**: re-running the same operation (is it idempotent?), duplicate records, a record deleted mid-flow, a user without the expected permissions.
- **Anything the diff changed that the tests don't cover.** These are the highest-value scenarios in the run — nobody has checked them.

You have real access: run the app, modify the dev database, set up data in third-party systems (`sf` CLI for Salesforce, and so on). Use it. A scenario executed against real data in a real environment is the whole point of this phase; a scenario reasoned about but not run is worth nothing and must never appear as "pass".

For each scenario record what you did, what you expected, what happened, and **the evidence** — the log line, the DB row, the API response. Vague results ("looked fine") are what make morning reports untrustworthy.

**Add every artifact you create to a teardown list as you create it** — rows, records, files, queue messages. Record enough to delete it unattended: object type, ID, and which org or database it's in. You won't remember them all at the end, and leftover fixtures cause confusing failures for other people days later — worse in an org that isn't a throwaway sandbox, where a stray test account can end up in someone's pipeline report.

## Phase 3 — Address what you find

Sort each issue into one of two buckets:

**Fixable now** — a bug in the new code, a missing null check, a wrong field mapping, a bad default. Fix it, commit it, re-run the affected scenario to confirm, log it. Re-running matters: an unverified fix is just a second untested change.

**Needs the user** — a product decision (which behaviour is correct?), a credential or access you can't grant yourself, an issue in someone else's system, or anything that would require crossing a guardrail. Don't guess at these. Write down what you found, the options, and what you'd recommend, then move on.

The distinction is authority, not difficulty. A hard bug with an obvious correct answer is fixable. A trivial change where two behaviours are equally defensible is not yours to pick.

## Phase 4 — Open the PR

Push the branch and open the PR using the repo's default template, filling in every section it asks for.

Write it **terse**. Fragments over sentences, bullets over paragraphs. Reviewers skim descriptions, and padding hides the parts that matter. No throat-clearing, no restating the ticket, no "this PR aims to".

Like this:

```
## Summary
Per-rep OAuth for Salesforce. Replaces the shared integration user.

- New `sf_oauth_tokens` table, one row per user
- Token refresh on 401, single retry
- Existing connections migrated on first use

## Testing
Smoke tested in dev — see table below.
```

Not this:

```
## Summary
This pull request implements a significant change to the way that we handle
authentication for the Salesforce integration. Previously we were using a
shared integration user, but as discussed in the planning session, this
approach has a number of drawbacks...
```

Mark it ready for review — the bots don't comment on drafts, and the review loop is the point. Do this even if the deploy or smoke test was blocked; just be explicit in the description about what wasn't verified.

## Phase 5 — Review loop

Wait for Codex and Cubic, then work through what they say. Poll every ~2 minutes; if a round produces nothing after ~15 minutes, treat it as done. **Loop at most 3 times**, then stop regardless — bots can generate comments indefinitely, and three clean rounds beats an unbounded night of churn.

For each comment, decide whether it's actually right. Review bots produce a mix of real bugs, reasonable style preferences, and confident nonsense about code they've misread. Verify the claim against the code before acting — applying a wrong suggestion is worse than skipping a right one, because the user has to spot it first.

- **Valid** → fix it, then resolve the thread. No reply needed; the commit is the reply.
- **Not valid, or not worth doing** → reply with one terse sentence saying why, then resolve. One sentence, not a paragraph — you're leaving a trail, not winning an argument.

Push a round's fixes together, then wait for the next round.

While waiting, check CI. A failing build wastes the whole window if it sits unnoticed until morning, and CI failures are usually the same kind of fixable-now issue as everything in phase 3.

See `references/pr-review-commands.md` for the `gh` incantations — resolving threads needs GraphQL, which isn't obvious.

## Phase 6 — Report

First, work the teardown list: clean up the test data you created in the dev database and in third-party orgs. Do this even if the run went badly — an aborted run still leaves records behind. Verify each deletion rather than assuming it took, and if anything survives, name it precisely in the report (org, object, ID) so the user can finish the job in one pass.

Then update the PR description with the smoke test results:

| # | Scenario | Result | Notes |
|---|----------|--------|-------|
| 1 | Rep connects SF account, first time | Pass | Token stored, refresh verified |
| 2 | Token expired mid-sync | Pass | Refreshed, retried once |
| 3 | Rep lacks API Enabled perm | **Fail** | 403 surfaces as generic error — needs decision on messaging |
| 4 | 5k-record backfill | Blocked | Sandbox row limit; untested |

Be honest in this table. Reviewers will read "Pass" as verified. Anything you didn't actually execute is Blocked or Untested.

Finally, reply in the chat with the report, most important thing first:

1. **Where it stands** — one line. PR link, and whether it's clean or needs attention.
2. **What needs you** — blockers and decisions, most important first. This is the section they're opening the laptop for; if it's empty, say so plainly.
3. **Smoke test summary** — pass/fail counts, plus detail on anything that didn't pass.
4. **What I fixed** — issues found and resolved, review comments addressed, with commits.
5. **What I skipped** — review comments you pushed back on, and why.
6. **Cleanup** — confirmed clean, or exactly what's still lying around.

Write it to be read with a coffee, by someone with no context loaded. They've forgotten the details of what they handed over; don't assume last night's state of mind. If the run was uneventful, say so in three lines and stop — a long report on a clean run buries the signal for the next one that isn't.
