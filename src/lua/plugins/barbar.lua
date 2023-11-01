return {
    "romgrk/barbar.nvim",

    enabled = true,
    lazy = false,
    dependencies = {
        "gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    opts = {
        animation = true,
        auto_hide = 1,
        tabpages = true,
        clickable = true,
        icons = {
            buffer_index = false,
            buffer_number = false,
            diagnostics = {
                -- By default, only show errors and warnings.
                [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
                [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
                [vim.diagnostic.severity.HINT] = { enabled = false, icon = " " },
                [vim.diagnostic.severity.INFO] = { enabled = false, icon = " " },
            },
            filetype = { enabled = true }, -- Show filetype icon
        },
        sidebar_filetypes = { NvimTree = true },
    },
    keys = {
        -- Navigate buffers
        {
            "<A-,>",
            "<cmd>BufferPrevious<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-.>",
            "<cmd>BufferNext<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-1>",
            "<cmd>BufferGoto 1<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-2>",
            "<cmd>BufferGoto 2<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-3>",
            "<cmd>BufferGoto 3<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-4>",
            "<cmd>BufferGoto 4<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-5>",
            "<cmd>BufferGoto 5<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-6>",
            "<cmd>BufferGoto 6<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-7>",
            "<cmd>BufferGoto 7<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-8>",
            "<cmd>BufferGoto 8<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-9>",
            "<cmd>BufferGoto 9<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A-0>",
            "<cmd>BufferLast<cr>",
            "n",
            noremap = true,
            silent = true,
        },

        -- Re-order buffers
        {
            "<A-<>",
            "<cmd>BufferMovePrevious<cr>",
            "n",
            noremap = true,
            silent = true,
        },
        {
            "<A->>",
            "<cmd>BufferMoveNext<cr>",
            "n",
            noremap = true,
            silent = true,
        },

        -- More barbar shortcuts
        { "<leader>bp",  "<cmd>BufferPin<cr>",                 "n", desc = "Pin the current buffer" },
        { "<leader>bb",  "<cmd>BufferPick<cr>",                "n", desc = "Enter buffer picking mode" },
        { "<leader>bc",  "<cmd>BufferClose<cr>",               "n", desc = "Close the current buffer" },
        { "<leader>bC",  "<cmd>BufferCloseAllButPinned<cr>",   "n", desc = "Close all unpinned buffers" },
        { "<leader>bon", "<cmd>BufferOrderByBufferNumber<cr>", "n", desc = "Order buffers by buffer number" },
        { "<leader>bod", "<cmd>BufferOrderByDirectory<cr>",    "n", desc = "Order buffers by directory" },
        { "<leader>bol", "<cmd>BufferOrderByLanguage<cr>",     "n", desc = "Order buffers by language" },
        { "<leader>bow", "<cmd>BufferOrderByWindowNumber<cr>", "n", desc = "Order buffers by window number" },
    },
}
