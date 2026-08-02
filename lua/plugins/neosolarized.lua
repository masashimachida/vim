return
{
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("tokyonight").setup({
            comment_italics = true,
            transparent = true,
            -- transparent=trueだけではNormalFloat/NeoTreeNormal等は透過されないため明示指定
            styles = {
                floats = "transparent",
                sidebars = "transparent",
            },
        })
        vim.cmd.colorscheme("tokyonight")
    end,

}

--[[
{
  "svrana/neosolarized.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("neosolarized").setup({
      comment_italics = true,
      background_set = false,
    })
    vim.cmd.colorscheme("neosolarized")
  end,
  dependencies = {
    "tjdevries/colorbuddy.nvim",
  },
}
--]]
