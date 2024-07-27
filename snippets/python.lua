return {
  s(
    'main',
    fmt(
      [[
        if __name__ == '__main__':
            {}
      ]],
      {
        i(1, '...'),
      }
    )
  ),
  s(
    {
      trig = 'p',
      desc = 'print',
    },
    fmt('print({})', {
      i(1, "'Hello, World!'"),
    })
  ),
  s('from', fmt('from {} import {}', { i(1), i(2) })),
  s(
    'for',
    fmt(
      [[
      for {} in {}:
          {}
    ]],
      {
        i(1, 'x'),
        i(2, 'xs'),
        i(3, '...'),
      }
    )
  ),
  s(
    'if',
    fmt(
      [[
      if {}:
          {}
    ]],
      {
        i(1, 'True'),
        i(2, '...'),
      }
    )
  ),
  s(
    'elif',
    fmt(
      [[
      elif {}:
          {}
    ]],
      {
        i(1, 'True'),
        i(2, '...'),
      }
    )
  ),
  s(
    'else',
    fmt(
      [[
      else:
          {}
    ]],
      {
        i(1, '...'),
      }
    )
  ),
  s(
    'while',
    fmt(
      [[
      while {}:
          {}
    ]],
      {
        i(1, 'True'),
        i(2, '...'),
      }
    )
  ),
  s(
    'def',
    fmt(
      [[
      def {}({}):
          {}
    ]],
      {
        i(1, 'func'),
        i(2, 'args'),
        i(3, '...'),
      }
    )
  ),
  s(
    'with',
    fmt(
      [[
      with {} as {}:
          {}
    ]],
      {
        i(1),
        i(2),
        i(3, '...'),
      }
    )
  ),
  s('imp', fmt('import {}', { i(1) })),
  s('yi', fmt('yield {}', { i(1) })),
}
