return {
	"normen/vim-pio",
	lazy = false,
	dependencies = {
		"neovim/nvim-lspconfig",
		"voldikss/vim-floaterm", -- Reuse your existing float terminal
	},
	config = function()
		-- Create custom commands for PlatformIO
		local function create_pio_command(name, command, desc)
			vim.api.nvim_create_user_command(name, function()
				-- Use floaterm to run PlatformIO commands
				vim.cmd("FloatermNew --title=PlatformIO --width=0.8 --height=0.8 pio " .. command)
			end, { desc = desc })
		end

		-- Create custom PlatformIO commands
		create_pio_command("PioBuild", "run", "Build PlatformIO project")
		create_pio_command("PioUpload", "run --target upload", "Upload to device")
		create_pio_command("PioClean", "run --target clean", "Clean build files")
		create_pio_command("PioTest", "test", "Run tests")
		create_pio_command("PioMonitor", "device monitor", "Open serial monitor")
		create_pio_command("PioDebug", "debug", "Start debugging")
		create_pio_command("PioLibs", "lib list", "List installed libraries")
		create_pio_command("PioBoards", "boards esp32", "List ESP32 boards")
		create_pio_command("PioInit", "project init --board esp32dev", "Initialize new ESP32 project")

		-- Key mappings for Arduino/PlatformIO commands (using <leader>ar prefix)
		vim.keymap.set("n", "<leader>arb", "<cmd>PioBuild<CR>", { desc = "Arduino: Build" })
		vim.keymap.set("n", "<leader>aru", "<cmd>PioUpload<CR>", { desc = "Arduino: Upload" })
		vim.keymap.set("n", "<leader>arc", "<cmd>PioClean<CR>", { desc = "Arduino: Clean" })
		vim.keymap.set("n", "<leader>art", "<cmd>PioTest<CR>", { desc = "Arduino: Test" })
		vim.keymap.set("n", "<leader>arm", "<cmd>PioMonitor<CR>", { desc = "Arduino: Serial Monitor" })
		vim.keymap.set("n", "<leader>ard", "<cmd>PioDebug<CR>", { desc = "Arduino: Debug" })
		vim.keymap.set("n", "<leader>arl", "<cmd>PioLibs<CR>", { desc = "Arduino: Libraries" })
		vim.keymap.set("n", "<leader>arB", "<cmd>PioBoards<CR>", { desc = "Arduino: Boards" })
		vim.keymap.set("n", "<leader>ari", "<cmd>PioInit<CR>", { desc = "Arduino: Init Project" })

		-- Set filetype for Arduino and PlatformIO files
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = { "*.ino", "*.pde", "platformio.ini" },
			callback = function()
				if vim.fn.expand("%:e") == "ino" or vim.fn.expand("%:e") == "pde" then
					vim.bo.filetype = "arduino"
				else
					vim.bo.filetype = "ini"
				end
			end,
		})

		-- Installation instructions for Mac
		-- Add a command to show instructions
		vim.api.nvim_create_user_command("ArduinoSetup", function()
			local instructions = [[
ESP32 Development Setup Instructions for Mac:

1. Install PlatformIO Core:
   $ brew install platformio

2. Create a new project (or use <leader>pi in Neovim):
   $ mkdir my_esp32_project
   $ cd my_esp32_project
   $ pio project init --board esp32dev

3. Create src/main.cpp with your code

4. Additional ESP32 libraries can be added to platformio.ini:
   lib_deps =
     ESP32 BLE Arduino

For more info: https://docs.platformio.org/en/latest/tutorials/espressif32/arduino_debugging_unit_testing.html
      ]]

			-- Create a floating window with instructions
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, true, vim.split(instructions, "\n"))

			local width = math.min(80, vim.o.columns - 4)
			local height = math.min(20, vim.o.lines - 4)
			local row = math.floor((vim.o.lines - height) / 2)
			local col = math.floor((vim.o.columns - width) / 2)

			local opts = {
				relative = "editor",
				width = width,
				height = height,
				row = row,
				col = col,
				style = "minimal",
				border = "rounded",
			}

			local win = vim.api.nvim_open_win(buf, true, opts)
			vim.api.nvim_win_set_option(win, "winblend", 10)

			-- Close the window with q or escape
			vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
			vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { noremap = true, silent = true })

			-- Set buffer options
			vim.api.nvim_buf_set_option(buf, "modifiable", false)
			vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
		end, {})

		vim.keymap.set("n", "<leader>ars", "<cmd>ArduinoSetup<CR>", { desc = "Arduino: Setup Instructions" })
	end,
}
