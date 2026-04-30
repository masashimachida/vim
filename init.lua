-- スペースキーをリーダーキーに設定
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    performance = {
        rtp = {
            disabled_plugins = {
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
            },
        },
    },
})

-- keybind

-- jjでINSERTモードを抜ける
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- Ctrl + h/j/k/l だけでペイン間を移動できるようにする
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Esc 2回で検索のハイライトを消す
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { silent = true })

-- ノーマルモード: Ctrl + / でコメントして次の行へ
vim.keymap.set('n', '<C-_>', 'gccj', { remap = true, desc = "Toggle comment and move down" })
-- ビジュアルモード: Ctrl + / で選択範囲をコメントして抜ける (下へ移動)
-- ※ビジュアルモードは 'gc' のあとに自動で選択解除されるため、'j' で一行下へ
vim.keymap.set('v', '<C-_>', 'gcjgv', { remap = true, desc = "Toggle comment and move down" })

-- aaで警告などの詳細を開く
vim.keymap.set('n', 'aa', vim.diagnostic.open_float, {})

-- Ctrl+Alt+lでフォーマット
vim.keymap.set("n", "<C-M-l>", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" })

-- <leader>llでCodeAction
vim.keymap.set('n', '<leader>ll', vim.lsp.buf.code_action, { desc = "Code Action" })

-- ターミナル
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    -- Escでターミナルモードを抜ける
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    -- clear
    vim.keymap.set('t', '<C-l>', [[<C-l>]], { buffer = 0 })
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        set_terminal_keymaps()
    end,
})

-- ----------------------------------------------------------------------------------------------
-- bufdelete.nvim
-- ----------------------------------------------------------------------------------------------
-- バッファを閉じる
vim.keymap.set("n", "<C-w>", "<cmd>Bdelete<cr>", { silent = true, remap = true })

-- ----------------------------------------------------------------------------------------------
-- bufferline.nvim
-- ----------------------------------------------------------------------------------------------
-- エディタ側でのタブ切り替えキーバインド
-- 編集画面にいる時にTabで右のタブ、Shift+Tabで左のタブへ
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")

-- ----------------------------------------------------------------------------------------------
-- claudecode.nvim
-- ----------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Claude Codeを切り替え" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Claudeにフォーカス" })
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "セッションを再開" })
-- vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "選択範囲を送信", mode = "v" })



-- ----------------------------------------------------------------------------------------------
-- neo-tree.nvim
-- ----------------------------------------------------------------------------------------------
-- Neo-treeを「開く」か「フォーカスする」関数
local function open_or_focus_neotree()
    local manager = require("neo-tree.sources.manager")
    local renderer = require("neo-tree.ui.renderer")
    local state = manager.get_state("filesystem")
    local window_exists = renderer.window_exists(state)

    if window_exists then
        -- すでに開いているなら、そのウィンドウにフォーカスを移動
        vim.cmd("Neotree focus")
    else
        -- 閉じていれば、左側に新しく開く
        vim.cmd("Neotree show left")
    end
end
vim.keymap.set("n", "<C-f>", open_or_focus_neotree, { desc = "Focus or Open Neo-tree" })

-- ----------------------------------------------------------------------------------------------
-- telescope.nvim
-- ----------------------------------------------------------------------------------------------
local builtin = require('telescope.builtin')
-- ファイル検索
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "ファイルを検索" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "文字列でgrep検索" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "開いているバッファを検索" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "ヘルプを検索" })
-- LSP関連（定義へジャンプの代わりに使うと便利）
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = "定義へジャンプ" })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "参照一覧" })



-- option

-- 行番号を表示
vim.opt.number = true

-- 折り返しなし
vim.opt.wrap = false
-- 横スクロールが発生した際、カーソル周辺に表示する最小の列数（5文字分余裕を持たせる）
vim.opt.sidescrolloff = 8
-- 行末を越えてカーソルを移動させない
vim.opt.virtualedit = "block"

-- タブ入力をスペースに変換
vim.opt.expandtab = true
-- タブをスペース2つ分として表示
vim.opt.tabstop = 4
-- 自動インデントや「>>」で動くスペースの数
vim.opt.shiftwidth = 4
-- 編集中のタブの挙動をスペース2つ分に合わせる
vim.opt.softtabstop = 4

-- 現在の行をハイライト
vim.opt.cursorline = true
-- 現在の行番号を強調（太字や色変え）
vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })


-- スワップファイルを作成しない
vim.opt.swapfile = false
-- バックアップファイルを作成しない
vim.opt.backup = false
-- アンドゥ履歴をファイルに保存する
vim.opt.undofile = true

-- 常に行番号の左側に領域を確保
vim.opt.signcolumn = "yes"

vim.opt.switchbuf = "useopen"
