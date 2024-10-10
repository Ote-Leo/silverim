local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node

local else_nodes = { t({ "else:", "\t" }), i(1, "...") }

---@param idx integer
---@return ChoiceNode
local function as_renaming(idx)
	return c(idx, {
		sn(nil, { i(1), t(" as "), i(2) }),
		i(3),
	})
end

---Get text from clipboard, trimmed (trimming empty lines) and indented
local function registered_text()
	local text = vim.fn.trim(vim.fn.getreg() .. "", "\n")
	local lines = vim.split(text, "\n")

	for idx, line in ipairs(lines) do
		if #vim.trim(line) > 0 then
			lines[idx] = "\t" .. line
		end
	end

	return sn(nil, t(lines))
end

local for_loops = s({ trig = "for", docstring = "for … in …: … else: …" }, {
	t("for "),
	i(1),
	t(" in "),
	i(2),
	t({ ":", "\t" }),
	i(3, "..."),
	t({ "", "" }),
	-- c(4, {
	-- 	t(""),
	-- 	sn(nil, vim.deepcopy(else_nodes)),
	-- }),
})

local with_statement = s("with", {
	t("with "),
	as_renaming(1),
	t({ ":", "\t" }),
	i(2, "..."),
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
local else_statement = s("else", vim.deepcopy(else_nodes)) -- BUG: check if preceeded by an ``if`` statement or a ``for-loop``

local import_statement = s("import", {
	c(1, { sn(nil, { t("from "), i(1), t(" ") }), t("") }),
	t("import "),
	as_renaming(2),
})

local yield_statement = s("yield", { t("yield "), i(1) })

local function not_implemented_error(args)
	local function_name = args[1][1]
	return sn(nil, {
		i(1, 'raise NotImplementedError("todo implement ' .. function_name .. '")'),
	})
end

local function_definition_snippet = s({ trig = "def", docstring = "def …(…)…: …" }, {
	t("def "),
	i(1, "func"),
	t("("),
	i(2),
	t(")"),
	c(3, {
		sn(nil, { t(" -> "), i(1) }),
		t(""),
	}),
	t({ ":", "\t" }),
	d(4, not_implemented_error, { 1 }),
})

local entry_point = s({ trig = "main", docstring = 'if __name__ == "__main__": …' }, {
	t({ 'if __name__ == "__main__":', "\t" }),
	i(1, "..."),
})

local class_declaration = s({ trig = "class", docstring = "class …: …" }, {
	t("class "),
	i(1),
	t({ ":", "\t" }),
	i(2, "..."),
})

local sorround_by_try = s({ trig = ":try", docstring = "try …: … except …: …" }, {
	t({ "try:", "" }),
	d(1, registered_text),
	t({ "", "except " }),
	as_renaming(2),
	t({ ":", "\t" }),
	i(3, "..."),
})

local sorround_by_def = s({ trig = ":def", docstring = "def …(…)…: …" }, {
	t("def "),
	i(1, "func"),
	t("("),
	i(2),
	t(")"),
	c(3, {
		sn(nil, { t(" -> "), i(1) }),
		t(""),
	}),
	t({ ":", "" }),
	d(4, registered_text),
	t({ "", "" }),
})

local sorround_by_with = s({ trig = ":with", docstring = "with …: …" }, {
	t("with "),
	as_renaming(1),
	t({ ":", "" }),
	d(2, registered_text),
	t({ "", "" }),
})

local sorround_by_if = s({ trig = ":if", docstring = "if …: …" }, {
	t("if "),
	i(1),
	t({ ":", "" }),
	d(2, registered_text),
	t({ "", "" }),
})

local sorround_by_for = s({ trig = ":for", docstring = "for … in …: …" }, {
	t("for "),
	i(1),
	t(" in "),
	i(2),
	t({ ":", "" }),
	d(3, registered_text),
	t({ "", "" }),
})

local sorround_by_while = s({ trig = ":while", docstring = "while …: …" }, {
	t("while "),
	i(1),
	t({ ":", "" }),
	d(2, registered_text),
	t({ "", "" }),
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
	class_declaration,

	sorround_by_try,
	sorround_by_def,
	sorround_by_with,
	sorround_by_if,
	sorround_by_for,
	sorround_by_while,
}
