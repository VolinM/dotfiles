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

local M = {
  s({ trig = "h¨", snippetType = "autosnippet", wordTrig = false }, {
    t("\\hbar"),
  }, { condition = tex.in_mathzone }),
  s(
    { trig = "brr", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \bra{<>}<>
    ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = tex.in_math }
  ),
  s(
    { trig = "ktt", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \ket{<>}<>
    ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = tex.in_math }
  ),
  s(
    { trig = "bkk", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
    \braket{<>}{<>}<>
    ]],
      {
        d(1, get_visual),
        i(2),
        i(0),
      }
    ),
    { condition = tex.in_math }
  ),
}

return M
