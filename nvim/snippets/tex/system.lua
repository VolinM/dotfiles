local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
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
    { condition = line_begin and tex.in_text }
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
    { condition = line_begin and tex.in_text }
  ),
  -- SECTION
  s(
    { trig = "h1", snippetType = "autosnippet" },
    fmta([[\section{<>}]], {
      d(1, get_visual),
    }),
    { condition = line_begin and tex.in_text }
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
    }),
    { condition = line_begin and tex.in_text }
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
    ),
    { condition = tex.in_text }
  ),
  -- HSPACE
  s(
    { trig = "hss", snippetType = "autosnippet" },
    fmta([[\hspace{<>}]], {
      d(1, get_visual),
    }),
    { condition = line_begin }
  ),
  -- VSPACE
  s(
    { trig = "vss", snippetType = "autosnippet" },
    fmta([[\vspace{<>}]], {
      d(1, get_visual),
    }),
    { condition = line_begin }
  ),
  s(
    { trig = "", snippetType = "autosnippet" },
    fmta([[\textbf{<>} <>]], { d(1, get_visual), i(0) }),
    { condition = tex.in_text }
  ),
  s(
    { trig = "underl", snippetType = "autosnippet" },
    fmta([[\underline{<>} <>]], { d(1, get_visual), i(0) }),
    { condition = tex.in_text }
  ),
  s(
    { trig = "textit", snippetType = "autosnippet" },
    fmta([[\textit{<>} <>]], { d(1, get_visual), i(0) }),
    { condition = tex.in_text }
  ),
}

return M
