return {
	"akinsho/flutter-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("flutter")
		vim.keymap.set(
			"n",
			"<leader>fc",
			require("telescope").extensions.flutter.commands,
			{ desc = "Open Flutter commands" }
		)
	end,
}
