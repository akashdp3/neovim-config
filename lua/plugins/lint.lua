local ok, lint = pcall(require, "lint")
if not ok then
	return
end

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	markdown = { "markdownlint" },
	mdx = { "markdownlint" },
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	zsh = { "shellcheck" },
	go = { "golangcilint" },
}

local function try_lint()
	if vim.b.disable_lint or vim.g.disable_lint then
		return
	end
	lint.try_lint()
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
	callback = try_lint,
})

vim.api.nvim_create_user_command("Lint", function()
	lint.try_lint()
end, { desc = "Lint current buffer" })

vim.api.nvim_create_user_command("LintToggle", function()
	vim.b.disable_lint = not vim.b.disable_lint
	vim.notify(vim.b.disable_lint and "Lint disabled for buffer" or "Lint enabled for buffer", vim.log.levels.INFO)
end, { desc = "Toggle linting for current buffer" })

vim.api.nvim_create_user_command("LintToggleGlobal", function()
	vim.g.disable_lint = not vim.g.disable_lint
	vim.notify(vim.g.disable_lint and "Lint disabled globally" or "Lint enabled globally", vim.log.levels.INFO)
end, { desc = "Toggle linting globally" })
