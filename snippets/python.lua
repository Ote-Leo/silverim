local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

local else_nodes = { { t({ "else:", "\t" }), i(1, "...") } }

local for_loops = s({ trig = "for", docstring = "for … in …: … else: …" }, {
	t("for "),
	i(1),
	t(" in "),
	i(2),
	t({ ":", "\t" }),
	i(3, "..."),
	c(4, {
		t(""),
		sn(nil, else_nodes),
	}),
})

local with_statement = s("with", {
	t("with "),
	i(1),
	c(2, {
		t(""),
		sn(nil, { t(" as "), i(1) }),
	}),
	t({ ":", "\t" }),
	i(3, "..."),
})

---Any of the form "<token> …: …"
---@param token string
local function single_placer(token)
	return s({
		trig = token,
		docstring = token .. " …: …",
	}, {
		t(token .. " "),
		i(1),
		t({ ":", "\t" }),
		i(2, "..."),
	})
end

local while_loops = single_placer("while")

local if_condition = single_placer("if")
local elif_condition = single_placer("elif") -- BUG: check if preceeded by an ``if`` statement
local else_statement = s("else", else_nodes) -- BUG: check if preceeded by an ``if`` statement or a ``for-loop``

local import_statement = s("import", {
	c(1, { sn(nil, { t("from "), i(1), t(" ") }), t("") }),
	t("import "),
	i(2),
	c(3, { sn(nil, { t(" as "), i(1) }), t("") }),
})

local yield_statement = s("yield", { t("yield "), i(1) })

local function_definition_snippet = s({ trig = "def", docstring = "def …(…)…: …" }, {
	t("def "),
	i(1, "func"),
	t("("),
	i(2),
	t(")"),
	c(3, {
		t(""),
		sn(nil, { t(" -> "), i(1) }),
	}),
	t({ ":", "\t" }),
	i(4, "..."),
})

local entry_point = s({ trig = "main", docstring = 'if __name__ == "__main__": …' }, {
	t({ 'if __name__ == "__main__":', "\t" }),
	i(1, "..."),
})

return {
	function_definition_snippet,
	for_loops,
	with_statement,
	while_loops,

	if_condition,
	elif_condition,
	else_statement,

	import_statement,
	yield_statement,

	entry_point,
}
