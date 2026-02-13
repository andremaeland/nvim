local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("LspAttach", {
	callback = require("config.keymaps").setup_lsp_autocmd_keymaps,
})

autocmd("FileType", {
	pattern = { "json" },
	callback = function()
		vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
	end,
})

autocmd({ "VimEnter", "VimResized" }, {
	desc = "Setup LSP hover window",
	callback = function()
		local width = math.floor(vim.o.columns * 0.8)
		local height = math.floor(vim.o.lines * 0.3)

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
			max_width = width,
			max_height = height,
		})
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	callback = function(args)
		local _, treesitter = pcall(require, "nvim-treesitter")
		if _ == nil or not treesitter then
			-- we weren't able to import tree sitter
			return
		end
		if not vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
			-- We don't have a parser for this filetype
			return
		end
		-- Handle auto install?
		-- Handle disablement
		vim.treesitter.start(args.buf)
	end,
})
