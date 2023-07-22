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
  -- DOCUMENTCLASS
  s(
    { trig = "dcc", snippetType = "autosnippet" },
    fmta(
      [=[
        \documentclass[<>]{<>}
        ]=],
      {
        i(1, "a4paper"),
        i(2, "article"),
      }
    ),
    { condition = line_begin }
  ),
  -- USE A LATEX PACKAGE
  s(
    { trig = "pack", snippetType = "autosnippet" },
    fmta(
      [[
        \usepackage{<>}
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- SECTION
  s(
    { trig = "h1", snippetType = "autosnippet" },
    fmta([[\section{<>}]], {
      d(1, get_visual),
    })
  ),
  -- SUBSECTION
  s(
    { trig = "h2", snippetType = "autosnippet" },
    fmta([[\subsection{<>}]], {
      d(1, get_visual),
    })
  ),
  -- SUBSUBSECTION
  s(
    { trig = "h3", snippetType = "autosnippet" },
    fmta([[\subsubsection{<>}]], {
      d(1, get_visual),
    })
  ),
  -- LABEL
  s(
    { trig = "lbl", snippetType = "autosnippet" },
    fmta(
      [[
      \label{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- HPHANTOM
  s(
    { trig = "hpp", snippetType = "autosnippet" },
    fmta(
      [[
      \hphantom{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- HSPACE
  s(
    { trig = "hss", snippetType = "autosnippet" },
    fmta([[\hspace{<>}]], {
      d(1, get_visual),
    })
  ),
  -- VSPACE
  s(
    { trig = "vss", snippetType = "autosnippet" },
    fmta([[\vspace{<>}]], {
      d(1, get_visual),
    })
  ),
  s({ trig = "", snippetType = "autosnippet" }, fmta([[\textbf{<>} <>]], { d(1, get_visual), i(0) })),
  s({ trig = "underl", snippetType = "autosnippet" }, fmta([[\underline{<>} <>]], { d(1, get_visual), i(0) })),
  s({ trig = "textit", snippetType = "autosnippet" }, fmta([[\textit{<>} <>]], { d(1, get_visual), i(0) })),
}

return M
