local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node

-- Math context detection
local tex = {}
tex.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end

-- https://www.cmor-faculty.rice.edu/~heinken/latex/symbols.pdf

local M = {
  s({ trig = "¿a", snippetType = "autosnippet", wordTrig = false }, {
    t("\\alpha"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿b", snippetType = "autosnippet", wordTrig = false }, {
    t("\\beta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿c", snippetType = "autosnippet", wordTrig = false }, {
    t("\\chi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿d", snippetType = "autosnippet", wordTrig = false }, {
    t("\\delta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿e", snippetType = "autosnippet", wordTrig = false }, {
    t("\\epsilon"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿f", snippetType = "autosnippet", wordTrig = false }, {
    t("\\phi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿g", snippetType = "autosnippet", wordTrig = false }, {
    t("\\gamma"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿h", snippetType = "autosnippet", wordTrig = false }, {
    t("\\eta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿i", snippetType = "autosnippet", wordTrig = false }, {
    t("\\pi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿k", snippetType = "autosnippet", wordTrig = false }, {
    t("\\kappa"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿l", snippetType = "autosnippet", wordTrig = false }, {
    t("\\lambda"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿m", snippetType = "autosnippet", wordTrig = false }, {
    t("\\mu"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿n", snippetType = "autosnippet", wordTrig = false }, {
    t("\\nu"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿o", snippetType = "autosnippet", wordTrig = false }, {
    t("\\theta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿p", snippetType = "autosnippet", wordTrig = false }, {
    t("\\psi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿q", snippetType = "autosnippet", wordTrig = false }, {
    t("\\pi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿r", snippetType = "autosnippet", wordTrig = false }, {
    t("\\rho"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿s", snippetType = "autosnippet", wordTrig = false }, {
    t("\\sigma"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿t", snippetType = "autosnippet", wordTrig = false }, {
    t("\\tau"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿w", snippetType = "autosnippet", wordTrig = false }, {
    t("\\omega"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿x", snippetType = "autosnippet", wordTrig = false }, {
    t("\\xi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿z", snippetType = "autosnippet", wordTrig = false }, {
    t("\\zeta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿ve", snippetType = "autosnippet", wordTrig = false }, {
    t("\\varepsilon"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿vf", snippetType = "autosnippet", wordTrig = false }, {
    t("\\varphi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿vo", snippetType = "autosnippet", wordTrig = false }, {
    t("\\vartheta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿D", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Delta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿F", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Phi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿G", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Gamma"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿I", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Pi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿L", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Lambda"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿O", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Theta"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿P", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Psi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿Q", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Pi"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿S", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Sigma"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿W", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Omega"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "¿X", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Xi"),
  }, { condition = tex.in_mathzone }),
  -- HEBREW
  s({ trig = "aleph", snippetType = "autosnippet", wordTrig = false }, {
    t("\\aleph"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "beth", snippetType = "autosnippet", wordTrig = false }, {
    t("\\beth"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "gimel", snippetType = "autosnippet", wordTrig = false }, {
    t("\\gimel"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "daleth", snippetType = "autosnippet", wordTrig = false }, {
    t("\\daleth"),
  }, { condition = tex.in_mathzone }),
}

return M
