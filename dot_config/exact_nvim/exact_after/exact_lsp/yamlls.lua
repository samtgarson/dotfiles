return {
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      schemastore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.yaml"
      },
    },
  },
}
