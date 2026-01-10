return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    -- 1. Setup the adapter (Connects Neovim to the codelldb binary)
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        -- Mason installs binaries here by default
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- 2. Setup the configuration (How to run your C code)
	dap.configurations.c = {
      {
	name = "Compile and Debug",
    	type = "codelldb",
    	request = "launch",
    
    	program = function()
      	vim.cmd("write")

      	local file = vim.fn.expand("%:p")
      	local output = vim.fn.expand("%:p:r")

      	print("Compiling " .. vim.fn.expand("%:t") .. "...")

      	local compile_res = vim.fn.system(string.format("gcc -g %s -o %s", file, output))

      	if vim.v.shell_error ~= 0 then
        	print("Compilation Failed: " .. compile_res)
        	return nil
      	end

      		print("Compilation Successful!")
      		return output
    	end,
    
    	cwd = vim.fn.getcwd(),
    	stopOnEntry = false,
      },

	{
        name = "Run Make and Debug",
        type = "codelldb",
        request = "launch",
        program = function()
          print("Running make...")
          vim.fn.system("make")
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = vim.fn.getcwd(),
        stopOnEntry = false,
      },
    }

    -- 3. Open UI automatically
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- 4. Keybindings
    vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Debug: Toggle UI" })

  end,
}



