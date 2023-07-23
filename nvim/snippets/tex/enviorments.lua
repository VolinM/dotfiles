local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep
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
  -- GENERIC ENVIRONMENT
  s(
    { trig = "new", snippetType = "autosnippet" },
    fmta(
      [[

        \begin{<>}
            <>
        \end{<>}

        <>
      ]],
      {
        i(1),
        d(2, get_visual),
        rep(1),
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- ENVIRONMENT WITH ONE EXTRA ARGUMENT
  s(
    { trig = "n2", snippetType = "autosnippet" },
    fmta(
      [[

        \begin{<>}{<>}
            <>
        \end{<>}
        
        <>
      ]],
      {
        i(1),
        i(2),
        d(3, get_visual),
        rep(1),
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- ENVIRONMENT WITH TWO EXTRA ARGUMENTS
  s(
    { trig = "n3", snippetType = "autosnippet" },
    fmta(
      [[

        \begin{<>}{<>}{<>}
            <>
        \end{<>}

        <>
      ]],
      {
        i(1),
        i(2),
        i(3),
        d(4, get_visual),
        rep(1),
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- EQUATION
  s(
    { trig = "nn", snippetType = "autosnippet" },
    fmta(
      [[
      <>

      <>
      ]],
      {
        c(1, {
          fmta(
            [[
        \begin{equation*}
            <>
        \end{equation*}
        ]],
            { i(1) }
          ),
          fmta(
            [[
        \begin{equation}
            <>
        \end{equation}
        ]],
            { i(1) }
          ),
        }),
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- SPLIT EQUATION
  s(
    { trig = "ss", snippetType = "autosnippet" },
    fmta(
      [[
      <>

      <>
      ]],
      {
        c(1, {
          fmta(
            [[
        \begin{gather*}
            <>
        \end{gather*}
        ]],
            { i(1) }
          ),
          fmta(
            [[
        \begin{gather}
            <>
        \end{gather}
        ]],
            { i(1) }
          ),
        }),
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- ALIGN
  s(
    { trig = "all", snippetType = "autosnippet" },
    fmta(
      [[
      <>

      <>
      ]],
      {
        c(1, {
          fmta(
            [[
        \begin{align*}
            <>
        \end{align*}
        ]],
            { i(1) }
          ),
          fmta(
            [[
        \begin{align}
            <>
        \end{align}
        ]],
            { i(1) }
          ),
        }),
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- ITEMIZE
  s(
    { trig = "itt", snippetType = "autosnippet" },
    fmta(
      [[

        \begin{itemize}

            \item <>

        \end{itemize}
        
      ]],
      {
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- ENUMERATE
  s(
    { trig = "enn", snippetType = "autosnippet" },
    fmta(
      [[

        \begin{enumerate}

            \item <>

        \end{enumerate}
      
      ]],
      {
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  s(
    { trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_text }
  ),
  -- DISPLAY MATH
  s(
    { trig = "mk", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
    <>\[
    <>
    \]
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, get_visual),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  -- FIGURE
  s(
    { trig = "fig" },
    fmta(
      [[

        \begin{figure}[htb!]
          \centering
          \includegraphics[width=<>\linewidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        
        <>
        ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(0),
      }
    ),
    { condition = line_begin and tex.in_text }
  ),
  s(
    { trig = "([.])-", regTrig = true, snippetType = "autosnippet" },
    fmta("\\item <>", { i(0) }),
    { condition = line_begin and tex.in_text }
  ),
  s(
    { trig = "lbb", regTrig = true, snippetType = "autosnippet" },
    fmta("\\label{<>:<>}", { i(1), i(2) }),
    { condition = line_begin }
  ),
}

return M
