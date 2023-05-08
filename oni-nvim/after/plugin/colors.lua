function ColorMyPencils(color)
	color = color or "kanagawa"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
