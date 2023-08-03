local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- Math context detection
local tex = {}
tex.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end

-- MATRIX generator
local mat = function(args, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ " \\\\", "" }))
  end
  -- fix last node.
  nodes[#nodes] = t(" \\\\")
  return sn(nil, nodes)
end

-- CASES generator
local generate_cases = function(args, snip)
  local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
  local cols = 2 -- fix to 2 cols
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ "\\\\", "" }))
  end
  -- fix last node.
  table.remove(nodes, #nodes)
  return sn(nil, nodes)
end

local M = {
  -----------------------------
  -- MATRICES
  -----------------------------
  -- GENERATING MATRICES
  s(
    {
      trig = "([bBpvV])mat(%d+)x(%d+)([ar])",
      regTrig = true,
      name = "matrix",
      dscr = "matrix trigger lets go",
      snippetType = "autosnippet",
    },
    fmt(
      [[
    \begin{<>}<>
    <>
    \end{<>}]],
      {
        f(function(_, snip)
          return snip.captures[1] .. "matrix" -- captures matrix type
        end),
        f(function(_, snip)
          if snip.captures[4] == "a" then
            local out = string.rep("c", tonumber(snip.captures[3]) - 1) -- array for augment
            return "[" .. out .. "|c]"
          end
          return "" -- otherwise return nothing
        end),
        d(1, mat),
        f(function(_, snip)
          return snip.captures[1] .. "matrix" -- i think i could probably use a repeat node but whatever
        end),
      },
      { delimiters = "<>" }
    ),
    { condition = tex.in_mathzone }
  ),

  ---------------------
  -- CASES
  ---------------------

  -- GENERATING CASES
  s(
    { trig = "(%d?)cases", name = "cases", dscr = "cases", regTrig = true, hidden = true, snippetType = "autosnippet" },
    fmta(
      [[
    \begin{cases}
    <>
    \end{cases}
    ]],
      { d(1, generate_cases) }
    ),
    { condition = tex.in_math, show_condition = tex.in_mathzone }
  ),
}

return M
