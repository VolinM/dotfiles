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

  -- GENERIC ENVIRONMENT
  s(
    { trig = "assignament" },
    fmta(
      [[
      \documentclass{article}
      \usepackage[utf8]{inputenc}
      % Asthetics
      \usepackage{geometry}
      \usepackage{fancyhdr}
      \usepackage{graphicx}
      \usepackage{titling}
      % Math
      \usepackage{amsmath}
      \usepackage{amssymb}
      \usepackage{physics}
      \usepackage{esint}
      % Other
      \usepackage{lipsum}

      % DOCUMENT SETUP
      \geometry{
      a4paper,
      total={170mm,257mm},
      left=20mm,
      top=20mm,
      }

      % ENVIORMENT VARIABLES
      \title{<>}
      \author{\vspace{-15ex}}
      \date{\vspace{-8ex}}
      \def\student{<>}
      \def\tidate{<>}
      \def\profesor{<>}
      \def\course{<>}

      % PAGESTYLE
      \pagestyle{fancy}
      \lhead{\tidate}
      \rhead{\student}
      \lfoot{\course}
      \rfoot{Prof. \profesor}

      % DOCUMENT
      \begin{document}
      \maketitle

      \thispagestyle{fancy}
      \noindent\begin{tabular}{@{}ll}
      Alumno:   & \student  \\
      Profesor: & \profesor \\
      Curso:    & \course   \\
      \end{tabular}
      \vspace{1em}

      %% --- begin here ---- %%
      \section*{Section}
      <>















      \end{document}
      ]],
      {
        i(1, "Title"),
        i(2, "Mark Volin"),
        i(3, "\\today"),
        i(4),
        i(5),
        i(0),
      }
    ),
    { condition = line_begin }
  ),
}

return M
