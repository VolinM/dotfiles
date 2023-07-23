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
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
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
        \begin{equation}
            <>
        \end{equation}
        ]],
            { i(1) }
          ),
          fmta(
            [[
        \begin{equation*}
            <>
        \end{equation*}
        ]],
            { i(1) }
          ),
        }),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
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
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "([.])-", regTrig = true, snippetType = "autosnippet" },
    fmta("\\item <>", { i(0) }),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "lbb", regTrig = true, snippetType = "autosnippet" },
    fmta("\\label{<>:<>}", { i(1), i(2) }),
    { condition = line_begin }
  ),
  s(
    { trig = "definition", name = "definition" },
    fmta(
      [[

        \begin{definition}
           <>
        \end{definition}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "property", name = "property" },
    fmta(
      [[

        \begin{property}
           <>
        \end{property}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "result", name = "result" },
    fmta(
      [[

        \begin{result}
           <>
        \end{result}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "lemma", name = "lemma" },
    fmta(
      [[

        \begin{lemma}
           <>
        \end{lemma}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "proposition", name = "proposition" },
    fmta(
      [[

        \begin{proposition}
           <>
        \end{proposition}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "statement", name = "statement" },
    fmta(
      [[

        \begin{statement}
           <>
        \end{statement}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "law", name = "law" },
    fmta(
      [[

        \begin{law}
           <>
        \end{law}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "postulate", name = "postulate" },
    fmta(
      [[

        \begin{postulate}
           <>
        \end{postulate}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "conclusion", name = "conclusion" },
    fmta(
      [[

        \begin{conclusion}
           <>
        \end{conclusion}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "extra", name = "extra" },
    fmta(
      [[

        \begin{extra}
           <>
        \end{extra}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "presumption", name = "presumption" },
    fmta(
      [[

        \begin{presumption}
           <>
        \end{presumption}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "repetition", name = "repetition" },
    fmta(
      [[

        \begin{repetition}
           <>
        \end{repetition}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "interlude", name = "interlude" },
    fmta(
      [[

        \begin{interlude}
           <>
        \end{interlude}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "inote", name = "inote" },
    fmta(
      [[

        \begin{note-}
           <>
        \end{note-}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "observation", name = "observation" },
    fmta(
      [[

        \begin{observation}
           <>
        \end{observation}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "remark", name = "remark" },
    fmta(
      [[

        \begin{remark}
           <>
        \end{remark}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "practical", name = "practical" },
    fmta(
      [[

        \begin{practical}
           <>
        \end{practical}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "problem", name = "problem" },
    fmta(
      [[

        \begin{problem}
           <>
        \end{problem}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "terminology", name = "terminology" },
    fmta(
      [[

        \begin{terminology}
           <>
        \end{terminology}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "application", name = "application" },
    fmta(
      [[

        \begin{application}
           <>
        \end{application}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "usage-example", name = "usage-example" },
    fmta(
      [[

        \begin{usage-example}
           <>
        \end{usage-example}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "ask", name = "ask" },
    fmta(
      [[

        \begin{ask}
           <>
        \end{ask}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "example", name = "example" },
    fmta(
      [[

        \begin{example}
           <>
        \end{example}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "notation", name = "notation" },
    fmta(
      [[

        \begin{notation}
           <>
        \end{notation}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "previously-seen", name = "previously-seen" },
    fmta(
      [[

        \begin{previously-seen}
           <>
        \end{previously-seen}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "observe", name = "observe" },
    fmta(
      [[

        \begin{observe}
           <>
        \end{observe}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "intuition", name = "intuition" },
    fmta(
      [[

        \begin{intuition}
           <>
        \end{intuition}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "theorem", name = "theorem" },
    fmta(
      [[

        \begin{theorem}
           <>
        \end{theorem}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "corollary", name = "corollary" },
    fmta(
      [[

        \begin{corollary}
           <>
        \end{corollary}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "correction", name = "correction" },
    fmta(
      [[

        \begin{correction}
           <>
        \end{correction}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "note", name = "note" },
    fmta(
      [[
        \begin{note}{<>}
          <>
        \end{note}

        <>
      
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "pff", name = "proof", snippetType = "autosnippet" },
    fmta(
      [[

        \begin{proof}
           <>
        \end{proof}

        <>
      
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "exx", name = "exercise", snippetType = "autosnippet" },
    fmta(
      [[

        \exercise{<>}

        <>

      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "sex", name = "subexercise", snippetType = "autosnippet" },
    fmta(
      [[

        \subexercise{<>}

        <>

      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
  s(
    { trig = "sll", name = "solution", snippetType = "autosnippet" },
    fmta(
      [[

        \solution{<>}

        <>

      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = line_begin * tex.in_text }
  ),
}

return M
