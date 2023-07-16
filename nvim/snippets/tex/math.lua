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
  -- BASIC OPERATORS
  -------------------------------

  -- NOT EQUALS
  s({ trig = "!=", snippetType = "autosnippet" }, {
    t("\\neq"),
  }, { condition = tex.in_mathzone }),
  -- PLUS MINUS
  s({ trig = "+-", snippetType = "autosnippet" }, {
    t("\\pm"),
  }, { condition = tex.in_mathzone }),
  -- MINUS PLUS
  s({ trig = "-+", snippetType = "autosnippet" }, {
    t("\\mp"),
  }, { condition = tex.in_mathzone }),
  -- LESS OR EQUALS
  s({ trig = "<=", snippetType = "autosnippet" }, {
    t("\\leq"),
  }, { condition = tex.in_mathzone }),
  -- GREATER OR EQUALS
  s({ trig = ">=", snippetType = "autosnippet" }, {
    t("\\geq"),
  }, { condition = tex.in_mathzone }),
  -- EXISTS
  s({ trig = "EE", snippetType = "autosnippet" }, {
    t("\\exists"),
  }, { condition = tex.in_mathzone }),
  -- FOR ALL
  s({ trig = "AA", snippetType = "autosnippet" }, {
    t("\\forall"),
  }, { condition = tex.in_mathzone }),
  -- FRACTION
  s(
    { trig = "([^%a])ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\frac{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SQUARE ROOT
  s(
    { trig = "([^%\\])sq", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sqrt{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- N-th ROOT
  s(
    { trig = "([^%\\])nrt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sqrt[<>]{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      d(2, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- ABSOLUTE VALUE
  s(
    { trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\abs{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- BINOMIAL SYMBOL
  s(
    { trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\binom{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),

  -------------------------------
  -- TRIGONOMETRIC
  -------------------------------

  -- SINE
  s(
    { trig = "([^%\\])sq", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sqrt{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),

  -------------------------------
  -- SUBSCRIPTS AND SUPERSCRIPTS
  -------------------------------

  -- SUPERSCRIPT
  s(
    { trig = "([%w%)%]%}])'", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
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
    { trig = "([%w%)%]%}])._", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^{<>}_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
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

  --------------------------------
  -- EXPONENTIALS AND LOGARITHMS
  --------------------------------

  -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
  s(
    { trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>e^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- EXPONENTIAL OPERATOR with big parenthesis
  s(
    { trig = "([^%a%\\])exp", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\exp\\left(<>\\right)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- NATURAL LOGARITHM
  s(
    { trig = "([^%a%\\])ln", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\ln{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- LOGARITHM WITH BASE SUBSCRIPT
  s(
    { trig = "([^%a%\\])ll", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\log_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),

  -----------------------------
  -- SUMS AND PRODUCTS
  -----------------------------
  -- SUM with lower limit
  s(
    { trig = "([^%a])sM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sum_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SUM with upper and lower limit
  s(
    { trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\sum_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PRODUCT with lower limit
  s(
    { trig = "([^%a])pR", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\prod_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PRODUCT with upper and lower limit
  s(
    { trig = "([^%a])prr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\prod_{<>}^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),

  -----------------------------
  -- MATRICES
  -----------------------------

  -- CDOTS, i.e. \cdots
  s({ trig = "cdd", snippetType = "autosnippet" }, {
    t("\\cdots"),
  }, { condition = tex.in_mathzone }),
  -- VDOTS, i.e. \vdots
  s({ trig = "vdd", snippetType = "autosnippet" }, {
    t("\\vdots"),
  }, { condition = tex.in_mathzone }),
  -- DDOTS, i.e. \ddots
  s({ trig = "ddd", snippetType = "autosnippet" }, {
    t("\\ddots"),
  }, { condition = tex.in_mathzone }),

  -----------------------------
  -- VECTORS AND OPERATORS
  -----------------------------

  -- VECTOR
  s(
    { trig = "([^%a])vv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\vb{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
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
  -- DOT PRODUCT, i.e. \cdot
  s({ trig = ",.", snippetType = "autosnippet" }, {
    t("\\cdot "),
  }, { condition = tex.in_mathzone }),
  -- CROSS PRODUCT, i.e. \times
  s({ trig = "xx", snippetType = "autosnippet" }, {
    t("\\times "),
  }, { condition = tex.in_mathzone }),
  -- DOT PRODUCT with vectors
  s(
    { trig = "([^%a])dpp", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\vb{<>}\\cdot\\vb{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- CROSS PRODUCT with vectors
  s(
    { trig = "([^%a])cpp", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\vb{<>}\\times\\vb{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- GRADIENT
  s(
    { trig = "([^%a%\\])grad", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
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
    { trig = "([^%a%\\])div", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\div{\\vb{<>}}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- CURL
  s(
    { trig = "([^%a%\\])curl", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\curl{\\vb{<>}}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),

  --------------------------------------
  -- DERIVATIVES AND DIFFERENTIALS
  --------------------------------------

  -- DIFFERENTIAL
  s({ trig = "df", priority = 2000, snippetType = "autosnippet" }, {
    t("\\dd "),
  }, { condition = tex.in_mathzone }),
  -- TOTAL DERIVATIVE with denominator only
  s(
    { trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TOTAL DERIVATIVE with numerator and denominator
  s(
    { trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TOTAL DERIVATIVE with numerator, denominator, and higher-order argument
  s(
    { trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\dv[<>]{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with denominator only
  s(
    { trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with numerator and denominator
  s(
    { trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
  s(
    { trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\pdv[<>]{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
    }),
    { condition = tex.in_mathzone }
  ),

  --------------------------------------
  -- INTEGRALS
  --------------------------------------

  -- INTEGRAL with upper and lower limit
  s(
    { trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\int_{<>}^{<>} ", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- INTEGRAL from positive to negative infinity
  s(
    { trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\int_{\\infty}^{\\infty}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex.in_mathzone }
  ),
  -- BASIC INTEGRAL SYMBOL, i.e. \int
  s({ trig = "in1", snippetType = "autosnippet" }, {
    t("\\int"),
  }, { condition = tex.in_mathzone }),
  -- DOUBLE INTEGRAL, i.e. \iint
  s({ trig = "in2", snippetType = "autosnippet" }, {
    t("\\iint"),
  }, { condition = tex.in_mathzone }),
  -- TRIPLE INTEGRAL, i.e. \iiint
  s({ trig = "in3", snippetType = "autosnippet" }, {
    t("\\iiint"),
  }, { condition = tex.in_mathzone }),
  -- CLOSED SINGLE INTEGRAL, i.e. \oint
  s({ trig = "oi1", snippetType = "autosnippet" }, {
    t("\\oint"),
  }, { condition = tex.in_mathzone }),
  -- CLOSED DOUBLE INTEGRAL, i.e. \oiint
  s({ trig = "oi2", snippetType = "autosnippet" }, {
    t("\\oiint"),
  }, { condition = tex.in_mathzone }),

  --------------------------------------
  -- DIRAC NOTATION
  --------------------------------------

  -- DIRAC "BRA"
  s(
    { trig = "([^%a])bra", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\bra{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- DIRAC "KET"
  s(
    { trig = "([^%a])ket", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\ket{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- DIRAC "BRAKET"
  s(
    { trig = "([^%a])bkt", priority = 10000, wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>\\braket{<>}{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),

  -----------------------------
  -- ARROWS
  -----------------------------

  -- RIGHTARROW, i.e. \rightarrow
  s({ trig = "-->", snippetType = "autosnippet" }, {
    t("\\rightarrow"),
  }, { condition = tex.in_mathzone }),
  -- DOUBLE RIGHTARROW, i.e. \Rightarrow
  s({ trig = "==>", snippetType = "autosnippet" }, {
    t("\\Rightarrow"),
  }, { condition = tex.in_mathzone }),
  -- LEFTARROW, i.e. \leftarrow
  s({ trig = "<--", snippetType = "autosnippet" }, {
    t("\\leftarrow"),
  }, { condition = tex.in_mathzone }),
  -- DOUBLE RIGHTARROW, i.e. \rightarrow
  s({ trig = "<==", snippetType = "autosnippet" }, {
    t("\\Leftarrow"),
  }, { condition = tex.in_mathzone }),

  -- ANGLE
  s(
    { trig = "([^%a])gg", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\ang{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
}

return M
