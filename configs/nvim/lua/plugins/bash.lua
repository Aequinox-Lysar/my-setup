return {
	"mfussenegger/nvim-lint",
	opts = {
		linters_by_ft = {
			sh = { "shellcheck" },
		},
	},

	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "bash", "lua", "c", "python", "markdown","markdown_inline" },
		highlight = { enable = true },
		indent = { enable = true },
	},

	"hrsh7th/nvim-cmp",
	dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" },
	opts = {},

	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
}
