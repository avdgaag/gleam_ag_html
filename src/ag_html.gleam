//// The Html module provides functions for building data structures mapping
//// a DOM. These values can be rendered to string HTML output.

import gleam/string_builder.{StringBuilder}
import gleam/list
import ag_html/attributes.{Attribute}
import ag_html/string_utils

/// Html represents the nested structure of DOM elements.
pub opaque type Html {
  ContentNode(tag: String, children: List(Html), attributes: List(Attribute))
  OpenNode(tag: String, attributes: List(Attribute))
  TextNode(text: String)
}

fn render_open(tag: String, attributes: List(Attribute)) -> StringBuilder {
  ["<", tag]
  |> string_builder.from_strings()
  |> string_builder.append_builder(attributes.render_list(attributes))
  |> string_builder.append(">")
}

fn render_content(
  tag: String,
  children: List(Html),
  attributes: List(Attribute),
) -> StringBuilder {
  ["<", tag]
  |> string_builder.from_strings()
  |> string_builder.append_builder(attributes.render_list(attributes))
  |> string_builder.append(">")
  |> string_builder.append_builder(render_list(children))
  |> string_builder.append("</")
  |> string_builder.append(tag)
  |> string_builder.append(">")
}

fn render_list(content: List(Html)) -> StringBuilder {
  content
  |> list.map(do_render)
  |> string_builder.concat()
}

/// Render an `Html` value to a plain string.
///
/// # Example
///
///   > render(p([text("Hello")], []))
///   "<p>Hello</p>"
///
pub fn render(content: Html) -> String {
  content
  |> do_render()
  |> string_builder.to_string()
}

/// Render an `Html` value to a plain string as a full document, including the
/// document type.
///
/// # Example
///
///   > render_document(p([text("Hello")], []))
///   "<!doctype html><p>Hello</p>"
///
pub fn render_document(content: Html) -> String {
  content
  |> do_render()
  |> string_builder.prepend("<!doctype html>")
  |> string_builder.to_string()
}

fn do_render(content: Html) -> StringBuilder {
  case content {
    TextNode(text: text) -> escape(text)

    OpenNode(tag: tag, attributes: attributes) -> render_open(tag, attributes)

    ContentNode(tag: tag, children: children, attributes: attributes) ->
      render_content(tag, children, attributes)
  }
}

fn escape(text: String) -> StringBuilder {
  string_utils.map(
    text,
    fn(g) {
      case g {
        "<" -> "&lt;"
        ">" -> "&gt;"
        "&" -> "&amp;"
        _ -> g
      }
    },
  )
}

/// Create plain text in the DOM. The given string value will be escaped.
///
/// # Examples
///
///   > text("Hello")
///
pub fn text(text: String) -> Html {
  TextNode(text: text)
}

/// Create an open DOM node. Some functions in this library are based on this
/// function.
///
/// # Examples
///
///   > open_node("br", [class("ruler")])
///
pub fn open_node(name: String, attributes: List(Attribute)) -> Html {
  OpenNode(tag: name, attributes: attributes)
}

/// Create any DOM node. All functions in this library are based on this
/// function.
///
/// # Examples
///
///   > node("div", [text("hello")], [])
///
pub fn node(
  name: String,
  children: List(Html),
  attributes: List(Attribute),
) -> Html {
  ContentNode(tag: name, children: children, attributes: attributes)
}

pub fn html(children: List(Html), attributes: List(Attribute)) -> Html {
  node("html", children, attributes)
}

pub fn base(children: List(Html), attributes: List(Attribute)) -> Html {
  node("base", children, attributes)
}

pub fn head(children: List(Html), attributes: List(Attribute)) -> Html {
  node("head", children, attributes)
}

pub fn style(children: List(Html), attributes: List(Attribute)) -> Html {
  node("style", children, attributes)
}

pub fn title(children: List(Html), attributes: List(Attribute)) -> Html {
  node("title", children, attributes)
}

pub fn address(children: List(Html), attributes: List(Attribute)) -> Html {
  node("address", children, attributes)
}

pub fn article(children: List(Html), attributes: List(Attribute)) -> Html {
  node("article", children, attributes)
}

pub fn footer(children: List(Html), attributes: List(Attribute)) -> Html {
  node("footer", children, attributes)
}

pub fn header(children: List(Html), attributes: List(Attribute)) -> Html {
  node("header", children, attributes)
}

pub fn h1(children: List(Html), attributes: List(Attribute)) -> Html {
  node("h1", children, attributes)
}

pub fn h2(children: List(Html), attributes: List(Attribute)) -> Html {
  node("h2", children, attributes)
}

pub fn h3(children: List(Html), attributes: List(Attribute)) -> Html {
  node("h3", children, attributes)
}

pub fn h4(children: List(Html), attributes: List(Attribute)) -> Html {
  node("h4", children, attributes)
}

pub fn h5(children: List(Html), attributes: List(Attribute)) -> Html {
  node("h5", children, attributes)
}

pub fn h6(children: List(Html), attributes: List(Attribute)) -> Html {
  node("h6", children, attributes)
}

pub fn hgroup(children: List(Html), attributes: List(Attribute)) -> Html {
  node("hgroup", children, attributes)
}

pub fn nav(children: List(Html), attributes: List(Attribute)) -> Html {
  node("nav", children, attributes)
}

pub fn section(children: List(Html), attributes: List(Attribute)) -> Html {
  node("section", children, attributes)
}

pub fn dd(children: List(Html), attributes: List(Attribute)) -> Html {
  node("dd", children, attributes)
}

pub fn div(children: List(Html), attributes: List(Attribute)) -> Html {
  node("div", children, attributes)
}

pub fn dl(children: List(Html), attributes: List(Attribute)) -> Html {
  node("dl", children, attributes)
}

pub fn dt(children: List(Html), attributes: List(Attribute)) -> Html {
  node("dt", children, attributes)
}

pub fn figcaption(children: List(Html), attributes: List(Attribute)) -> Html {
  node("figcaption", children, attributes)
}

pub fn figure(children: List(Html), attributes: List(Attribute)) -> Html {
  node("figure", children, attributes)
}

pub fn hr(attributes: List(Attribute)) -> Html {
  open_node("hr", attributes)
}

pub fn li(children: List(Html), attributes: List(Attribute)) -> Html {
  node("li", children, attributes)
}

pub fn main(children: List(Html), attributes: List(Attribute)) -> Html {
  node("main", children, attributes)
}

pub fn ol(children: List(Html), attributes: List(Attribute)) -> Html {
  node("ol", children, attributes)
}

pub fn p(children: List(Html), attributes: List(Attribute)) -> Html {
  node("p", children, attributes)
}

pub fn pre(children: List(Html), attributes: List(Attribute)) -> Html {
  node("pre", children, attributes)
}

pub fn ul(children: List(Html), attributes: List(Attribute)) -> Html {
  node("ul", children, attributes)
}

pub fn abbr(children: List(Html), attributes: List(Attribute)) -> Html {
  node("abbr", children, attributes)
}

pub fn b(children: List(Html), attributes: List(Attribute)) -> Html {
  node("b", children, attributes)
}

pub fn bdi(children: List(Html), attributes: List(Attribute)) -> Html {
  node("bdi", children, attributes)
}

pub fn bdo(children: List(Html), attributes: List(Attribute)) -> Html {
  node("bdo", children, attributes)
}

pub fn br(attributes: List(Attribute)) -> Html {
  open_node("br", attributes)
}

pub fn cite(children: List(Html), attributes: List(Attribute)) -> Html {
  node("cite", children, attributes)
}

pub fn code(children: List(Html), attributes: List(Attribute)) -> Html {
  node("code", children, attributes)
}

pub fn data(children: List(Html), attributes: List(Attribute)) -> Html {
  node("data", children, attributes)
}

pub fn dfn(children: List(Html), attributes: List(Attribute)) -> Html {
  node("dfn", children, attributes)
}

pub fn em(children: List(Html), attributes: List(Attribute)) -> Html {
  node("em", children, attributes)
}

pub fn i(children: List(Html), attributes: List(Attribute)) -> Html {
  node("i", children, attributes)
}

pub fn kbd(children: List(Html), attributes: List(Attribute)) -> Html {
  node("kbd", children, attributes)
}

pub fn mark(children: List(Html), attributes: List(Attribute)) -> Html {
  node("mark", children, attributes)
}

pub fn q(children: List(Html), attributes: List(Attribute)) -> Html {
  node("q", children, attributes)
}

pub fn rp(children: List(Html), attributes: List(Attribute)) -> Html {
  node("rp", children, attributes)
}

pub fn rt(children: List(Html), attributes: List(Attribute)) -> Html {
  node("rt", children, attributes)
}

pub fn rtc(children: List(Html), attributes: List(Attribute)) -> Html {
  node("rtc", children, attributes)
}

pub fn ruby(children: List(Html), attributes: List(Attribute)) -> Html {
  node("ruby", children, attributes)
}

pub fn s(children: List(Html), attributes: List(Attribute)) -> Html {
  node("s", children, attributes)
}

pub fn samp(children: List(Html), attributes: List(Attribute)) -> Html {
  node("samp", children, attributes)
}

pub fn small(children: List(Html), attributes: List(Attribute)) -> Html {
  node("small", children, attributes)
}

pub fn span(children: List(Html), attributes: List(Attribute)) -> Html {
  node("span", children, attributes)
}

pub fn strong(children: List(Html), attributes: List(Attribute)) -> Html {
  node("strong", children, attributes)
}

pub fn sub(children: List(Html), attributes: List(Attribute)) -> Html {
  node("sub", children, attributes)
}

pub fn sup(children: List(Html), attributes: List(Attribute)) -> Html {
  node("sup", children, attributes)
}

pub fn time(children: List(Html), attributes: List(Attribute)) -> Html {
  node("time", children, attributes)
}

pub fn u(children: List(Html), attributes: List(Attribute)) -> Html {
  node("u", children, attributes)
}

pub fn var(children: List(Html), attributes: List(Attribute)) -> Html {
  node("var", children, attributes)
}

pub fn wbr(attributes: List(Attribute)) -> Html {
  open_node("wbr", attributes)
}

pub fn area(children: List(Html), attributes: List(Attribute)) -> Html {
  node("area", children, attributes)
}

pub fn audio(children: List(Html), attributes: List(Attribute)) -> Html {
  node("audio", children, attributes)
}

pub fn map(children: List(Html), attributes: List(Attribute)) -> Html {
  node("map", children, attributes)
}

pub fn track(children: List(Html), attributes: List(Attribute)) -> Html {
  node("track", children, attributes)
}

pub fn video(children: List(Html), attributes: List(Attribute)) -> Html {
  node("video", children, attributes)
}

pub fn embed(children: List(Html), attributes: List(Attribute)) -> Html {
  node("embed", children, attributes)
}

pub fn object(children: List(Html), attributes: List(Attribute)) -> Html {
  node("object", children, attributes)
}

pub fn param(children: List(Html), attributes: List(Attribute)) -> Html {
  node("param", children, attributes)
}

pub fn source(children: List(Html), attributes: List(Attribute)) -> Html {
  node("source", children, attributes)
}

pub fn canvas(children: List(Html), attributes: List(Attribute)) -> Html {
  node("canvas", children, attributes)
}

pub fn noscript(children: List(Html), attributes: List(Attribute)) -> Html {
  node("noscript", children, attributes)
}

pub fn script(children: List(Html), attributes: List(Attribute)) -> Html {
  node("script", children, attributes)
}

pub fn del(children: List(Html), attributes: List(Attribute)) -> Html {
  node("del", children, attributes)
}

pub fn ins(children: List(Html), attributes: List(Attribute)) -> Html {
  node("ins", children, attributes)
}

pub fn caption(children: List(Html), attributes: List(Attribute)) -> Html {
  node("caption", children, attributes)
}

pub fn col(children: List(Html), attributes: List(Attribute)) -> Html {
  node("col", children, attributes)
}

pub fn colgroup(children: List(Html), attributes: List(Attribute)) -> Html {
  node("colgroup", children, attributes)
}

pub fn table(children: List(Html), attributes: List(Attribute)) -> Html {
  node("table", children, attributes)
}

pub fn tbody(children: List(Html), attributes: List(Attribute)) -> Html {
  node("tbody", children, attributes)
}

pub fn td(children: List(Html), attributes: List(Attribute)) -> Html {
  node("td", children, attributes)
}

pub fn tfoot(children: List(Html), attributes: List(Attribute)) -> Html {
  node("tfoot", children, attributes)
}

pub fn th(children: List(Html), attributes: List(Attribute)) -> Html {
  node("th", children, attributes)
}

pub fn thead(children: List(Html), attributes: List(Attribute)) -> Html {
  node("thead", children, attributes)
}

pub fn tr(children: List(Html), attributes: List(Attribute)) -> Html {
  node("tr", children, attributes)
}

pub fn button(children: List(Html), attributes: List(Attribute)) -> Html {
  node("button", children, attributes)
}

pub fn datalist(children: List(Html), attributes: List(Attribute)) -> Html {
  node("datalist", children, attributes)
}

pub fn fieldset(children: List(Html), attributes: List(Attribute)) -> Html {
  node("fieldset", children, attributes)
}

pub fn form(children: List(Html), attributes: List(Attribute)) -> Html {
  node("form", children, attributes)
}

pub fn input(attributes: List(Attribute)) -> Html {
  open_node("input", attributes)
}

pub fn keygen(children: List(Html), attributes: List(Attribute)) -> Html {
  node("keygen", children, attributes)
}

pub fn label(children: List(Html), attributes: List(Attribute)) -> Html {
  node("label", children, attributes)
}

pub fn legend(children: List(Html), attributes: List(Attribute)) -> Html {
  node("legend", children, attributes)
}

pub fn meter(children: List(Html), attributes: List(Attribute)) -> Html {
  node("meter", children, attributes)
}

pub fn optgroup(children: List(Html), attributes: List(Attribute)) -> Html {
  node("optgroup", children, attributes)
}

pub fn option(children: List(Html), attributes: List(Attribute)) -> Html {
  node("option", children, attributes)
}

pub fn output(children: List(Html), attributes: List(Attribute)) -> Html {
  node("output", children, attributes)
}

pub fn progress(children: List(Html), attributes: List(Attribute)) -> Html {
  node("progress", children, attributes)
}

pub fn select(children: List(Html), attributes: List(Attribute)) -> Html {
  node("select", children, attributes)
}

pub fn details(children: List(Html), attributes: List(Attribute)) -> Html {
  node("details", children, attributes)
}

pub fn dialog(children: List(Html), attributes: List(Attribute)) -> Html {
  node("dialog", children, attributes)
}

pub fn menu(children: List(Html), attributes: List(Attribute)) -> Html {
  node("menu", children, attributes)
}

pub fn menuitem(children: List(Html), attributes: List(Attribute)) -> Html {
  node("menuitem", children, attributes)
}

pub fn summary(children: List(Html), attributes: List(Attribute)) -> Html {
  node("summary", children, attributes)
}

pub fn content(children: List(Html), attributes: List(Attribute)) -> Html {
  node("content", children, attributes)
}

pub fn element(children: List(Html), attributes: List(Attribute)) -> Html {
  node("element", children, attributes)
}

pub fn shadow(children: List(Html), attributes: List(Attribute)) -> Html {
  node("shadow", children, attributes)
}

pub fn template(children: List(Html), attributes: List(Attribute)) -> Html {
  node("template", children, attributes)
}

pub fn acronym(children: List(Html), attributes: List(Attribute)) -> Html {
  node("acronym", children, attributes)
}

pub fn applet(children: List(Html), attributes: List(Attribute)) -> Html {
  node("applet", children, attributes)
}

pub fn basefont(children: List(Html), attributes: List(Attribute)) -> Html {
  node("basefont", children, attributes)
}

pub fn big(children: List(Html), attributes: List(Attribute)) -> Html {
  node("big", children, attributes)
}

pub fn blink(children: List(Html), attributes: List(Attribute)) -> Html {
  node("blink", children, attributes)
}

pub fn center(children: List(Html), attributes: List(Attribute)) -> Html {
  node("center", children, attributes)
}

pub fn dir(children: List(Html), attributes: List(Attribute)) -> Html {
  node("dir", children, attributes)
}

pub fn frame(children: List(Html), attributes: List(Attribute)) -> Html {
  node("frame", children, attributes)
}

pub fn frameset(children: List(Html), attributes: List(Attribute)) -> Html {
  node("frameset", children, attributes)
}

pub fn isindex(children: List(Html), attributes: List(Attribute)) -> Html {
  node("isindex", children, attributes)
}

pub fn listing(children: List(Html), attributes: List(Attribute)) -> Html {
  node("listing", children, attributes)
}

pub fn noembed(children: List(Html), attributes: List(Attribute)) -> Html {
  node("noembed", children, attributes)
}

pub fn plaintext(children: List(Html), attributes: List(Attribute)) -> Html {
  node("plaintext", children, attributes)
}

pub fn spacer(children: List(Html), attributes: List(Attribute)) -> Html {
  node("spacer", children, attributes)
}

pub fn strike(children: List(Html), attributes: List(Attribute)) -> Html {
  node("strike", children, attributes)
}

pub fn tt(children: List(Html), attributes: List(Attribute)) -> Html {
  node("tt", children, attributes)
}

pub fn xmp(children: List(Html), attributes: List(Attribute)) -> Html {
  node("xmp", children, attributes)
}

pub fn a(children: List(Html), attributes: List(Attribute)) -> Html {
  node("a", children, attributes)
}

pub fn textarea(children: List(Html), attributes: List(Attribute)) -> Html {
  node("textarea", children, attributes)
}

pub fn svg(children: List(Html), attributes: List(Attribute)) -> Html {
  node("svg", children, attributes)
}

pub fn path(children: List(Html), attributes: List(Attribute)) -> Html {
  node("path", children, attributes)
}

pub fn polygon(children: List(Html), attributes: List(Attribute)) -> Html {
  node("polygon", children, attributes)
}

pub fn img(children: List(Html), attributes: List(Attribute)) -> Html {
  node("img", children, attributes)
}

pub fn link(attributes: List(Attribute)) -> Html {
  open_node("link", attributes)
}

pub fn meta(attributes: List(Attribute)) -> Html {
  open_node("meta", attributes)
}
