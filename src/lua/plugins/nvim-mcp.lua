return {
  "linw1995/nvim-mcp",
  build = function(plugin)
    vim.notify("Building nvim-mcp with cargo...", vim.log.levels.INFO)
    local obj = vim.system({ "cargo", "install", "--path", "." }, { cwd = plugin.dir }):wait()
    if obj.code ~= 0 then
      error("Failed to build nvim-mcp: " .. (obj.stderr or obj.stdout or ""))
    end
  end,
  opts = {},
}
