import gleeunit
import gleeunit/should
import ag_html.{a, br, hr, html, input, link, meta, p, render, text, wbr}
import ag_html/attributes.{charset,
  class, class_list, disabled, href, open, rel}

pub fn main() {
  gleeunit.main()
}

pub fn render_html_to_string_test() {
  html(
    [
      p(
        [
          text("hello, "),
          a([text("world")], [href("http://example.com"), class("btn")]),
          text("!"),
        ],
        [],
      ),
    ],
    [],
  )
  |> render()
  |> should.equal(
    "<html><p>hello, <a href=\"http://example.com\" class=\"btn\">world</a>!</p></html>",
  )
}

pub fn escape_text_test() {
  p([text("<hello> & more")], [class("btn\"foo")])
  |> render()
  |> should.equal("<p class=\"btn&quot;foo\">&lt;hello&gt; &amp; more</p>")
}

pub fn build_class_list_test() {
  p([], [class_list([#("foo", True), #("bar baz", False), #("bla", True)])])
  |> render()
  |> should.equal("<p class=\"foo bla\"></p>")
}

pub fn generate_open_tags_test() {
  link([rel("stylesheet"), href("styles.css")])
  |> render()
  |> should.equal("<link rel=\"stylesheet\" href=\"styles.css\">")

  meta([charset("utf-8")])
  |> render()
  |> should.equal("<meta charset=\"utf-8\">")

  br([])
  |> render()
  |> should.equal("<br>")

  hr([])
  |> render()
  |> should.equal("<hr>")

  wbr([])
  |> render()
  |> should.equal("<wbr>")

  input([])
  |> render()
  |> should.equal("<input>")
}

pub fn generate_simple_attributes() {
  input([disabled(True), open(True)])
  |> render()
  |> should.equal("<input disabled open>")

  input([disabled(False)])
  |> render()
  |> should.equal("<input>")
}
