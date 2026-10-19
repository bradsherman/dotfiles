-- Ruff: fast Python linting + code actions. Formatting stays with conform
-- (isort/black), so we let pyright own hover and keep ruff lint-only.
return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
}
