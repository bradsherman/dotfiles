-- terraform-ls (HashiCorp). Covers terraform + tfvars.
return {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars" },
	root_markers = { ".terraform", "*.tf", ".git" },
}
