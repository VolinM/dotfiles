local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
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
  -- VECTOR
  s(
    { trig = "(%a?)(,[.])", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \vb{<>}<>
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([^%a])vec", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\vb{<>}<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- UNIT VECTOR
  s(
    { trig = "([^%a])vu", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\vu{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- DEFAULT UNIT VECTOR WITH SUBSCRIPT
  s(
    { trig = "([^%a])ue", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\vu{e}_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- GRADIENT
  s(
    { trig = "grad", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\grad{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- DIVERGENCE
  s(
    { trig = "div", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\div{<>}<>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- CURL
  s(
    { trig = "curl", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\curl{<>}<>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- CURL
  s(
    { trig = "lapl", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\laplacian<>", {
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
