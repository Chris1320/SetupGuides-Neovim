local luasnip_vscode_loader = require("luasnip.loaders.from_vscode")

return {
    setup = luasnip_vscode_loader.lazy_load
}
