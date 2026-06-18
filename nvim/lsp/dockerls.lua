return {
    cmd = { "docker-language-server", "start", "--stdio" },
    filetypes = { "dockerfile" },
    settings = {
        languageserver = {
            formatter = {
                ignoreMultilineInstructions = true,
            },
        },
    },
}
