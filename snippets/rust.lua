main_function = s("main",
	fmt([[
		fn main() {
			<>
		}
	]], { i(1) }, { delimiters = "<>" })
)

let = s("l", fmt("let {} = {};", { i(1, "var"), i(2, "val") }))
let_mut = s("lm", fmt("let mut {} = {};", { i(1, "var"), i(2, "val") }))
let_else = s(
	"le",
	fmt([[
		let <> = <> else {
			<>
		};
	]], {
		i(1, "var"),
		i(2, "val"),
		i(3, "return None"),
	}, { delimiters = "<>" })
)
let_mut_else = s(
	"lme",
	fmt([[
		let mut <> = <> else {
			<>
		};
	]], {
		i(1, "var"),
		i(2, "val"),
		i(3, "return None"),
	}, { delimiters = "<>" })
)


local function not_implemented_macro(args)
	local function_name = args[1][1]
	return sn(nil, {
		i(1, 'unimplemented!("todo implement ' .. function_name .. ' function")'),
	})
end

local function function_nodes(prefix)
	if prefix == nil then
		prefix = "fn"
	else
		prefix = prefix .. " fn"
	end

	format = string.format([[
		%s <>(<>) <>{
			<>
		}
	]], prefix)

	return fmt(format, {
		i(1, "func"),
		i(2),
		c(3, {
			sn(nil, { t"-> ", i(1), t" " }),
			t"",
		}),
		d(4, not_implemented_macro, { 1 }),
	}, { delimiters = "<>" })
end


local fn = s({ trig = "fn", docstring = "fn …(…) -> … { … }" }, function_nodes())
local pub_fn = s({ trig = "pfn", docstring = "pub fn …(…) -> … { … }" }, function_nodes("pub"))
local async_fn = s({ trig = "afn", docstring = "async fn …(…) -> … { … }" }, function_nodes("async") )
local pub_async_fn = s({ trig = "pafn", docstring = "pub async fn …(…) -> … { … }" }, function_nodes("pub async "))


local impl = s(
	"im",
	fmt(
		[[
			impl <> {
				<>	
			}
		]],
		{ i(1), i(2), },
		{ delimiters = "<>" }
	)
)

local impl_generic = s(
	"img",
	fmt(
		[[
			impl<{}> {}<{}> {{
				{}
			}}
		]],
		{
			d(1, function(gs) return sn(nil, { t(gs[1][1]) }) end, { 3 }),
			i(2), i(3), i(4),
		}
	)
)

local impl_trait = s(
	"imt",
	fmt(
		[[
			impl <> for <> {
				<>
			}
		]],
		{ i(1), i(2), i(3), },
		{ delimiters = "<>" }
	)
)


return {
	main_function,
	let,
	let_mut,
	let_else,
	let_mut_else,
	fn,
	pub_fn,
	async_fn,
	pub_async_fn,

	impl,
	impl_generic,
	impl_trait,

	s("n", t"None"),

	s("p",   fmt("print!({})",    { i(1, '"Hello, World!"') })),
	s("pl",  fmt("println!({})",  { i(1, '"Hello, World!"') })),
	s("ep",  fmt("eprint!({})",   { i(1, '"Hello, World!"') })),
	s("epl", fmt("eprintln!({})", { i(1, '"Hello, World!"') })),
	s("f",   fmt("format!({})",   { i(1, '"Hello, World!"') })),

	s("w",  fmt("write!({}, {})",   { i(1, "fmt"), i(2, '"Hello, World!"') })),
	s("wl", fmt("writeln!({}, {})", { i(1, "fmt"), i(2, '"Hello, World!"') })),

	s("s", fmt("Some({})", { i(1) })),
	s("o", fmt("Ok({})", { i(1) })),
	s("e", fmt("Err({})", { i(1) })),

	s(
		"if",
		fmt(
			[[
				if <> {
					<>
				}
			]],
			{ i(1, "true"), i(2, "todo!()") },
			{ delimiters = "<>" }
		)
	),

	s(
		"elif",
		fmt(
			[[
				else if <> {
					<>
				}
			]],
			{ i(1, "true"), i(2, "todo!()") },
			{ delimiters = "<>" }
		)
	),

	s(
		"else",
		fmt(
			[[
				else {
					<>
				}
			]],
			{ i(1, "todo!()") },
			{ delimiters = "<>" }
		)
	),

	s(
		"for",
		fmt(
			[[
				for <> in <> {
					<>
				}
			]],
			{ i(1, "x"), i(2, "xs"), i(3, "todo!()") },
			{ delimiters = "<>" }
		)
	),

	s(
		"static",
		fmt("static {} = {};", {
			i(1, "var"),
			i(2, "val"),
		})
	),
	s(
		"en",
		fmt(
			[[
				enum <> {
					<>
				}
			]],
			{
				i(1, "Type"),
				i(2, "Variant"),
			},
			{ delimiters = "<>" }
		)
	),
	s(
		"st",
		fmt(
			[[
				struct <> {
					<>
				}
			]],
			{ i(1, "Type"), i(2, "field") },
			{ delimiters = "<>" }
		)
	),
	s(
		"testm",
		fmt(
			[[
				#[cfg(test)]
				mod <> {
					use super::*;

					<>
				}
			]],
			{ i(1, "test"), i(2) },
			{ delimiters = "<>" }
		)
	),
	s(
		"test",
		fmt(
			[[
				#[test]
				fn <>() {
					<>
				}
			]],
			{ i(1, "test"), i(2) },
			{ delimiters = "<>" }
		)
	),
	s("dr", fmt("#[derive({})]", { i(1) })),
}
