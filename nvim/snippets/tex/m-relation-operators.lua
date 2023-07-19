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
  -------------------------------
  -- BASIC OPERATORS
  -------------------------------

  -- NOT LESS
  s({ trig = "/<", snippetType = "autosnippet" }, {
    t("\\nless"),
  }, { condition = tex.in_mathzone }),
  -- NOT MORE
  s({ trig = "/>", snippetType = "autosnippet" }, {
    t("\\ngtr"),
  }, { condition = tex.in_mathzone }),
  -- LESS OR EQUAL
  s({ trig = "<=", snippetType = "autosnippet" }, {
    t("\\leq"),
  }, { condition = tex.in_mathzone }),
  -- MORE OR EQUAL
  s({ trig = ">=", snippetType = "autosnippet" }, {
    t("\\geq"),
  }, { condition = tex.in_mathzone }),
  -- PRECEDES
  s({ trig = "prec", snippetType = "autosnippet" }, {
    t("\\prec"),
  }, { condition = tex.in_mathzone }),
  -- SUCCEEDS
  s({ trig = "succ", snippetType = "autosnippet" }, {
    t("\\succ"),
  }, { condition = tex.in_mathzone }),
  -- PRECEDES OR EQUALS
  s({ trig = "preceq", snippetType = "autosnippet" }, {
    t("\\preceq"),
  }, { condition = tex.in_mathzone }),
  -- SUCCEEDS OR EQUALS
  s({ trig = "succeq", snippetType = "autosnippet" }, {
    t("\\succeq"),
  }, { condition = tex.in_mathzone }),
  -- MUCH GREATER
  s({ trig = ">>", snippetType = "autosnippet" }, {
    t("\\gg"),
  }, { condition = tex.in_mathzone }),
  -- MUCH LESSER
  s({ trig = "<<", snippetType = "autosnippet" }, {
    t("\\ll"),
  }, { condition = tex.in_mathzone }),
}
return M
