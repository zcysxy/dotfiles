---@diagnostic disable: undefined-global

local in_mathzone = function()
    local current_node = vim.treesitter.get_node({ ignore_injections = false })
    while current_node do
        vim.print(current_node:type())
        if current_node:type() == "source_file" then
            return true
        end
        current_node = current_node:parent()
    end
    return false
end

local in_codeblock = function()
    local current_node = vim.treesitter.get_node({ ignore_injections = false })
    while current_node do
        if current_node:type() == "fenced_code_block" or current_node:type() == "code_span" then
            return true
        end
        current_node = current_node:parent()
    end
    return false
end

local in_text = function()
    return not in_mathzone() and not in_codeblock()
end

return {
    -- Markdown: Definition comment tag
    s(
        "defn",
        fmt(
            [[
            <!-- Definition: {} -->

            > **{}:** {}
        ]],
            {
                i(1),
                rep(1),
                i(0),
            }
        )
    ),
    -- Markdown: Embed image
    s("img", {
        t("![](./"),
        i(0),
        t(")"),
    }),
    -- -- Markdown: Left arrow
    -- s("<-", t("←")),
    -- s("->", t("→")),
    -- -- Markdown: Left double arrow
    -- s("<=", t("⇐")),
    -- -- Markdown: Right double arrow
    -- s("=>", t("⇒")),
    -- -- Markdown: Less than or equal to
    -- s("<=", t("≤")),
    -- -- Markdown: Greater than or equal to
    -- s(">=", t("≥")),
}, {
    -- Markdown: Headers
    s({ trig = "^%s*h(%d)", regTrig = true }, {
        f(function(_, snip)
            return string.rep("#", snip.captures[1]) .. " "
        end),
    }, { condition = in_text }),
    -- Markdown math
    s("mk", fmt("${}$", i(1)), { condition = in_text }),
    s("dm", {
        t({ "$$", "" }),
        i(0),
        t({ "", "$$" }),
    }, { condition = in_text }),
}
