local coq = require("coq")
local coq3p = require("coq_3p")

return {
    setup = function()
        coq3p(
            {
                {  -- Requires bc `$ sudo apt install bc`
                    src = "bc",
                    short_name = "MATH",
                    precision = 4
                },
            }
        )
    end
}
