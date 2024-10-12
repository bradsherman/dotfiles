return {
    haskell = {
        checkProject = false,
        checkParents = "CheckOnSave",
        formattingProvider = "fourmolu",
        plugin = {
            stan = { globalOn = true },
            semanticTokens = { globalOn = true },
        },
    },
}
