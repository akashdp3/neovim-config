local ok_luasnip, luasnip = pcall(require, "luasnip")
if not ok_luasnip then
	return
end

luasnip.config.setup({
	history = true,
	delete_check_events = "TextChanged",
	region_check_events = "CursorMoved,CursorHold,InsertEnter",
})

pcall(function()
	require("luasnip.loaders.from_vscode").lazy_load()
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { desc = "Snippet expand/jump" })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { desc = "Snippet jump back" })
