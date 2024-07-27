return {
  s(
    'l',
    fmt('let {} = {};', {
      i(1, 'var'),
      i(2, 'val'),
    })
  ),

  s(
    'v',
    fmt('var {}: {} = {};', {
      i(1, 'var'),
      i(2, 'type'),
      i(3, 'val'),
    })
  ),

  s(
    'bl',
    fmt('@builtin({})', {
      i(1),
    })
  ),

  s(
    'lc',
    fmt('@location({})', {
      i(1),
    })
  ),

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
}
