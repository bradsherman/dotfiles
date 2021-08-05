require("neogit").setup {
  disable_context_highlighting = true,
  disable_commit_confirmation = true,
  integrations = {
    diffview = true
  },
  signs = {
    section = { " ", " " },
    item = { " ", " " },
    hunk = { "", "" }
  }
}
