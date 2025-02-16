return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text"
        },
        config = function ()
            local dap = require("dap")
            local dapui = require("dapui")
            local dap_python = require("dap-python")

            -- Dap
            vim.fn.sign_define('DapBreakpoint', {
                text='🔴',
                texthl='DapBreakpoint',
                linehl='DapBreakpoint',
                numhl='DapBreakpoint'
            })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>B", dap.set_breakpoint)
            vim.keymap.set("n", "<leader>dc", dap.continue)
            vim.keymap.set("n", "<leader>dq", dap.terminate)
            vim.keymap.set("n", "<leader>dr", dap.restart)
            vim.keymap.set("n", "<leader>du", dap.up)
            vim.keymap.set("n", "<leader>dU", dap.down)
            vim.keymap.set("n", "<F9>", dap.step_into)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_out)
            vim.keymap.set("n", "<F12>", dap.step_back)

            -- Dapui
            require("dapui").setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            vim.keymap.set("n", "<leader>dt", dapui.toggle)

            -- Dap-virtual-text
            require("nvim-dap-virtual-text").setup({})

            -- Python debugger
            local pydb_path = table.concat { vim.fn.stdpath "data", "/mason/packages/debugpy/venv/bin/python" }
            dap_python.setup(pydb_path)
        end
    },
    {
        -- for dap-ui
        "folke/lazydev.nvim",
        config = true,
        opts = {
            library = { "nvim-dap-ui" }
        }
    }
}
