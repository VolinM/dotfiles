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
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local M = {

  -- LECTURES MAIN
  s(
    { trig = "lec-main" },
    fmta(
      [[
      \makeatletter
      \def\input@path{{~/.config/latex/}}
      \documentclass{lecture-preamble}

      \title{<>}
      \begin{document}
      \maketitle
      \tableofcontents
      \newpage
      % -- begin lectures -- %

      \input{<>}

      % -- end lectures -- %
      \end{document}
      ]],
      { i(1), i(2) }
    ),
    { condition = line_begin }
  ),
  -- LECTURES
  s(
    { trig = "lec" },
    fmta(
      [[

      \lecture{<>}{<>}{<>}

      ]],
      { i(1, "lec number"), i(2, "date"), i(3, "title") }
    ),
    { condition = line_begin }
  ),
}

return M
