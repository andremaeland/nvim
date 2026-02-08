return {
	{
		-- "ellisonleao/gruvbox.nvim",
		"blazkowolf/gruber-darker.nvim",
		-- "EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruber-darker")
			vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "none", bg = "none" })
			vim.api.nvim_set_hl(0, "LineNr", { ctermbg = "none", bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
		end,
	},
}
