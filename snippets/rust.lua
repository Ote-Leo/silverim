return {
  s(
    'main',
    fmt(
      [[
      fn main() {{
          {}
      }}
    ]],
      {
        i(1),
      }
    )
  ),

  s(
    'l',
    fmt('let {} = {};', {
      i(1, 'var'),
      i(2, 'val'),
    })
  ),

  s(
    'lm',
    fmt('let mut {} = {};', {
      i(1, 'var'),
      i(2, 'val'),
    })
  ),

  s(
    'le',
    fmt(
      [[
      let {} = {} else {{
          {}
      }};
    ]],
      {
        i(1, 'var'),
        i(2, 'val'),
        i(3, 'return None'),
      }
    )
  ),

  s(
    'lme',
    fmt(
      [[
      let mut {} = {} else {{
          {}
      }};
    ]],
      {
        i(1, 'var'),
        i(2, 'val'),
        i(3, 'return None'),
      }
    )
  ),

  s(
    'p',
    fmt('print!({})', {
      i(1, '"Hello, World!"'),
    })
  ),

  s(
    'pl',
    fmt('println!({})', {
      i(1, '"Hello, World!"'),
    })
  ),

  s(
    'ep',
    fmt('eprint!({})', {
      i(1, '"Hello, World!"'),
    })
  ),

  s(
    'epl',
    fmt('eprintln!({})', {
      i(1, '"Hello, World!"'),
    })
  ),

  s(
    'w',
    fmt('write!({}, {})', {
      i(1, 'fmt'),
      i(2, '"Hello, World!"'),
    })
  ),

  s(
    'wl',
    fmt('writeln!({}, {})', {
      i(1, 'fmt'),
      i(2, '"Hello, World!"'),
    })
  ),
  s(
    'f',
    fmt('format!({})', {
      i(1, '"Hello, World!"'),
    })
  ),
  s('n', t 'None'),
  s('s', fmt('Some({})', { i(1) })),
  s('o', fmt('Ok({})', { i(1) })),
  s('e', fmt('Err({})', { i(1) })),

  s(
    'if',
    fmt(
      [[
    if {} {{
        {}
    }}
  ]],
      { i(1, 'true'), i(2, 'todo!()') }
    )
  ),

  s(
    'elif',
    fmt(
      [[
    else if {} {{
        {}
    }}
  ]],
      { i(1, 'true'), i(2, 'todo!()') }
    )
  ),

  s(
    'else',
    fmt(
      [[
    else {{
        {}
    }}
  ]],
      { i(1, 'todo!()') }
    )
  ),

  s(
    'for',
    fmt(
      [[
    for {} in {} {{
        {}
    }}
  ]],
      { i(1, 'x'), i(2, 'xs'), i(3, 'todo!()') }
    )
  ),

  s(
    'static',
    fmt('static {} = {};', {
      i(1, 'var'),
      i(2, 'val'),
    })
  ),
  s(
    'en',
    fmt(
      [[
          enum {} {{
            {}
          }}
      ]],
      {
        i(1, 'Type'),
        i(2, 'Variant'),
      }
    )
  ),
  s(
    'st',
    fmt(
      [[
          struct {} {{
            {}
          }}
      ]],
      {
        i(1, 'Type'),
        i(2, 'field'),
      }
    )
  ),

  s(
    'fn',
    fmt(
      [[
      fn {}({}) {}{{
          {}
      }}
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
  s(
    'pfn',
    fmt(
      [[
      pub fn {}({}){} {{
          {}
      }}
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
  s(
    'afn',
    fmt(
      [[
      async fn {}({}){} {{
          {}
      }}
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
  s(
    'pafn',
    fmt(
      [[
      pub async fn {}({}){} {{
          {}
      }}
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
  s(
    'im',
    fmt(
      [[
      impl {} {{
          {}
      }}
    ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    'imt',
    fmt(
      [[
      impl {} for {} {{
          {}
      }}
    ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
  s(
    'testm',
    fmt(
      [[
      #[cfg(test)]
      mod {} {{
          use super::*;

          {}
      }}
    ]],
      {
        i(1, 'test'),
        i(2),
      }
    )
  ),
  s(
    'test',
    fmt(
      [[
      #[test]
      fn {}() {{
          {}
      }}
    ]],
      {
        i(1, 'test'),
        i(2),
      }
    )
  ),
  s(
    'dr',
    fmt('#[derive({})]', {
      i(1),
    })
  ),
}
