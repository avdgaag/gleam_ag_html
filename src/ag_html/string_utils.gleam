//// Utility functions for working with strings.

import gleam/string
import gleam/list
import gleam/string_builder.{StringBuilder}

/// Map over graphemes in a string.
pub fn map(str: String, fun: fn(String) -> String) -> StringBuilder {
  str
  |> string.to_graphemes
  |> list.map(fun)
  |> string_builder.from_strings
}
