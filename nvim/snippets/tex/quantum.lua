local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
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
  s({ trig = "ħ", snippetType = "autosnippet", wordTrig = false }, {
    t("\\hbar"),
  }, { condition = tex.in_mathzone }),
  s(
    { trig = "««", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \bra{<>}<>
    ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = tex.in_math }
  ),
  s(
    { trig = "»»", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \ket{<>}<>
    ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = tex.in_math }
  ),
  s(
    { trig = "«»", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \braket{<>}{<>}<>
    ]],
      {
        d(1, get_visual),
        i(2),
        i(0),
      }
    ),
    { condition = tex.in_math }
  ),
}

return M
