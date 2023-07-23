local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
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
  -- SUPERSCRIPT
  s(
    { trig = '([%w%)%]%}])"', wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SUBSCRIPT
  s(
    { trig = "([%w%)%]%}])_", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SUBSCRIPT AND SUPERSCRIPT
  s(
    { trig = "([%w%)%]%}])([.])-", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^{<>}_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SQUARED
  s(
    { trig = "(%a?)sqq", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    <>^{2}<>
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
  -- CUBED
  s(
    { trig = "(%a?)cbb", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    <>^{3}<>
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
  -- ZERO SUBSCRIPT SHORTCUT
  s(
    { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("0"),
    }),
    { condition = tex.in_mathzone }
  ),
  -- I SUBSCRIPT SHORTCUT
  s(
    { trig = "([%a%)%]%}])II", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("i"),
    }),
    { condition = tex.in_mathzone }
  ),
  -- J SUBSCRIPT SHORTCUT
  s(
    { trig = "([%a%)%]%}])JJ", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("j"),
    }),
    { condition = tex.in_mathzone }
  ),
  -- COMPLEMENT SUPERSCRIPT
  s(
    { trig = "([%a%)%]%}])CC", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("\\complement"),
    }),
    { condition = tex.in_mathzone }
  ),
  -- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
  s(
    { trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("*"),
    }),
    { condition = tex.in_mathzone }
  ),
  -- DAGGER
  s(
    { trig = "([%a%)%]%}])dag", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t("\\dag"),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
