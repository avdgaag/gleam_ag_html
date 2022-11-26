# HTML

[![Package Version](https://img.shields.io/hexpm/v/html)](https://hex.pm/packages/html)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/html/)

Generate HTML using functions, much like [elm-html](https://package.elm-lang.org/packages/elm/html/1.0.0/).

## Quick start

```gleam
import html
import html/attributes

pub fn hello_world() -> String {
  html([
    head([], []),
    body([
      p([text("Hello, world!")], [class("big")])
    ], [])
  ], [])
  |> render_document()
}
/// will return:
///
///   "<!doctype html><html><head></head><body><p class=\"big\">Hello, world!</p></body></html>"
```

## Installation

If available on Hex this package can be added to your Gleam project:

```sh
gleam add html
```

and its documentation can be found at <https://hexdocs.pm/html>.
