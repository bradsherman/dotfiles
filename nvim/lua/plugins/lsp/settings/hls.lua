return {
    haskell = {
        checkProject = false,
        checkParents = "CheckOnSave",
        formattingProvider = "fourmolu",
        plugin = {
            stan = { globalOn = false },
            semanticTokens = { globalOn = true },
        },
    },
}
