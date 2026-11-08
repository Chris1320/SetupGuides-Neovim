return {
  "CopilotC-Nvim/CopilotChat.nvim",
  optional = true,
  opts = function()
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      model = "auto",
      auto_insert_mode = true,
      headers = {
        user = "  " .. user .. " ",
        assistant = "  Copilot ",
        tool = "󰊳  Tool ",
      },
      window = {
        width = 0.4,
      },
    }
  end,
}
