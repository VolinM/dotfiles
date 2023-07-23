local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local helpers = require("utils.luasnip-helper")
local get_visual = helpers.get_visual

-- Math context detection
local tex = {}
tex.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end

local M = {
  s(
    { trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sum<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[_{<>}{<>}]], { i(1), d(2, get_visual) }),
        fmta([[_{<>}^{<>}{<>}]], { i(1), i(2), d(3, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([^%a])prr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\prod<><>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      c(1, {
        fmta([[_{<>}{<>}]], { i(1), d(2, get_visual) }),
        fmta([[_{<>}^{<>}{<>}]], { i(1), i(2), d(3, get_visual) }),
      }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([^%a])lim", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta([[<>\lim_{<> \to <>}{<>}<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
