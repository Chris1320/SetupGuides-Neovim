return {
  "saghen/blink.cmp",
  dependencies = { "saghen/blink.lib" },
  build = function()
    require("blink.cmp").build():pwait()
  end,
  opts = { signature = { enabled = true } },
}
