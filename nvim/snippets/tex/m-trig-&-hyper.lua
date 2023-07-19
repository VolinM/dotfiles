local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

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

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local M = {
  -------------------------------
  -- TRIGONOMETRIC
  -------------------------------

  -- SINE
  s(
    { trig = "([^%a])sin", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\sin{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- COSINE
  s(
    { trig = "([^%a])cos", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\cos{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TANGENT
  s(
    { trig = "([^%a])tan", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\tan{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- COTANGENT
  s(
    { trig = "([^%a])cot", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\cot{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SECANT
  s(
    { trig = "([^%a])sec", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\sec{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- COSECANT
  s(
    { trig = "([^%a])csc", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\csc{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),

  ----------------------------------
  -- INVERSE TRIGONOMETRIC
  ----------------------------------

  -- ARC-SINE
  s(
    { trig = "([^%a])asin", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, { fmta([[\sin^{-1}{<>}]], i(1)), fmta([[\asin{<>}]], i(1)) }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- ARC-COSINE
  s(
    { trig = "([^%a])acos", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, { fmta([[\cos^{-1}{<>}]], i(1)), fmta([[\acos{<>}]], i(1)) }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- ARC-TANGENT
  s(
    { trig = "([^%a])atan", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, { fmta([[\tan^{-1}{<>}]], i(1)), fmta([[\atan{<>}]], i(1)) }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- ARC-COTANGENT
  s(
    { trig = "([^%a])acot", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, { fmta([[\cot^{-1}{<>}]], i(1)), fmta([[\acot{<>}]], i(1)) }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- ARC-SECANT
  s(
    { trig = "([^%a])asec", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, { fmta([[\sec^{-1}{<>}]], i(1)), fmta([[\asec{<>}]], i(1)) }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- ARC-COSECANT
  s(
    { trig = "([^%a])acsc", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<> <>", {
      c(1, { fmta([[\csc^{-1}{<>}]], i(1)), fmta([[\acsc{<>}]], i(1)) }),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),

  -------------------------------
  -- HYPERBOLIC
  -------------------------------

  -- HYPER-SINE
  s(
    { trig = "([^%a])sinh", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\sinh{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- HYPER-COSINE
  s(
    { trig = "([^%a])cosh", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\cosh{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- HYPER-TANGENT
  s(
    { trig = "([^%a])tanh", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\tanh{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- HYPER-COTANGENT
  s(
    { trig = "([^%a])coth", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\coth{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- HYPER-SECANT
  s(
    { trig = "([^%a])sech", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\sech{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
  -- HYPER-COSECANT
  s(
    { trig = "([^%a])csch", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("\\csch{<>} <>", {
      i(1),
      i(0),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
