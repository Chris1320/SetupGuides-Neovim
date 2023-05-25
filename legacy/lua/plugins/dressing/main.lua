return {
    setup = function()
        local dressing = require("dressing")
        dressing.setup(
            {
                enabled = true,
                default_prompt = " >>> ",
                prompt_align = "center",
                insert_only = true,
                start_in_insert = true
            }
        )
    end
}
