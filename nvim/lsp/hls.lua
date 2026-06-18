return {
    settings = {
        checkProject = false,
        checkParents = "CheckOnSave",
        formattingProvider = "fourmolu",
        maxCompletions = 10,
        sessionLoading = "multipleComponents",
        plugin = {
            stan = { globalOn = false },
            semanticTokens = { globalOn = true },
        },
    },
}
