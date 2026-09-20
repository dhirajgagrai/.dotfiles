return { -- Autoformat
	"stevearc/conform.nvim",
	opts = {
		format_on_save = function(bufnr)
			local path = vim.api.nvim_buf_get_name(bufnr)

			-- Disable autoformat for files in a /linux/ directory
			if path:match("/linux/") then
				return nil
			end

			-- Return the formatting options for all other files
			return {
				timeout_ms = 1000,
				lsp_fallback = true,
			}
		end,

		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			astro = { "prettier" },
			markdown = { "prettier" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
		},
	},
}
