//// The Html.Attributes module provides functions for defining DOM attributes
//// for `Html` values.

import gleam/string_builder.{StringBuilder}
import gleam/list
import gleam/int
import gleam/pair
import gleam/string
import ag_html/string_utils

/// An `Attribute` is a value mapping to a dom attribute, such as `href` in
/// `<a href="http://example.com">click here</a>`.
pub opaque type Attribute {
  Simple(name: String, enabled: Bool)
  WithValue(name: String, value: String)
}

fn render(attribute: Attribute) -> StringBuilder {
  case attribute {
    Simple(name: name, enabled: True) -> string_builder.from_string(name)

    Simple(name: _, enabled: False) -> string_builder.from_string("")

    WithValue(name: name, value: value) ->
      name
      |> string_builder.from_string
      |> string_builder.append("=\"")
      |> string_builder.append_builder(escape(value))
      |> string_builder.append("\"")
  }
}

pub fn render_list(attributes: List(Attribute)) -> StringBuilder {
  case attributes {
    [] -> string_builder.from_string("")

    other ->
      other
      |> list.map(render)
      |> string_builder.join(" ")
      |> string_builder.prepend(" ")
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
        "'" -> "&#39;"
        "\"" -> "&quot;"
        _ -> g
      }
    },
  )
}

/// Define a simple attribute that does not have a value in the DOM, such as
/// `disabled` in `<input type="button" disabled>`.
pub fn simple(name: String, enabled: Bool) -> Attribute {
  Simple(name, enabled)
}

/// Define an attribute with a value in the DOM, such as `href` in
/// `<a href="/home">link</a>`.
pub fn with_value(name: String, value: String) -> Attribute {
  WithValue(name, value)
}

/// Build a space-separated list of classes from a list of classes and whether
/// to include it or not.
///
/// # Examples
///
///   > class_list([#("btn", True), #("hidden", isLoggedIn)])
///
pub fn class_list(classes: List(#(String, Bool))) -> Attribute {
  classes
  |> list.filter(pair.second)
  |> list.map(pair.first)
  |> string.join(" ")
  |> class
}

pub fn hidden(enabled: Bool) -> Attribute {
  simple("hidden", enabled)
}

pub fn autofocus(enabled: Bool) -> Attribute {
  simple("autofocus", enabled)
}

pub fn spellcheck(enabled: Bool) -> Attribute {
  simple("spellcheck", enabled)
}

pub fn contenteditable(enabled: Bool) -> Attribute {
  simple("contenteditable", enabled)
}

pub fn reversed(enabled: Bool) -> Attribute {
  simple("reversed", enabled)
}

pub fn default(enabled: Bool) -> Attribute {
  simple("default", enabled)
}

pub fn loop(enabled: Bool) -> Attribute {
  simple("loop", enabled)
}

pub fn controls(enabled: Bool) -> Attribute {
  simple("controls", enabled)
}

pub fn autoplay(enabled: Bool) -> Attribute {
  simple("autoplay", enabled)
}

pub fn required(enabled: Bool) -> Attribute {
  simple("required", enabled)
}

pub fn readonly(enabled: Bool) -> Attribute {
  simple("readonly", enabled)
}

pub fn novalidate(enabled: Bool) -> Attribute {
  simple("novalidate", enabled)
}

pub fn multiple(enabled: Bool) -> Attribute {
  simple("multiple", enabled)
}

pub fn disabled(enabled: Bool) -> Attribute {
  simple("disabled", enabled)
}

pub fn checked(enabled: Bool) -> Attribute {
  simple("checked", enabled)
}

pub fn defer(enabled: Bool) -> Attribute {
  simple("defer", enabled)
}

pub fn draggable(enabled: Bool) -> Attribute {
  simple("draggable", enabled)
}

pub fn open(enabled: Bool) -> Attribute {
  simple("open", enabled)
}

pub fn accept(value: String) -> Attribute {
  with_value("accept", value)
}

pub fn accept_charset(value: String) -> Attribute {
  with_value("accept-charset", value)
}

pub fn accesskey(value: String) -> Attribute {
  with_value("accesskey", value)
}

pub fn action(value: String) -> Attribute {
  with_value("action", value)
}

pub fn align(value: String) -> Attribute {
  with_value("align", value)
}

pub fn allow(value: String) -> Attribute {
  with_value("allow", value)
}

pub fn alt(value: String) -> Attribute {
  with_value("alt", value)
}

pub fn async(value: String) -> Attribute {
  with_value("async", value)
}

pub fn autocapitalize(value: String) -> Attribute {
  with_value("autocapitalize", value)
}

pub fn autocomplete(value: String) -> Attribute {
  with_value("autocomplete", value)
}

pub fn buffered(value: String) -> Attribute {
  with_value("buffered", value)
}

pub fn capture(value: String) -> Attribute {
  with_value("capture", value)
}

pub fn challenge(value: String) -> Attribute {
  with_value("challenge", value)
}

pub fn charset(value: String) -> Attribute {
  with_value("charset", value)
}

pub fn cite(value: String) -> Attribute {
  with_value("cite", value)
}

pub fn class(value: String) -> Attribute {
  with_value("class", value)
}

pub fn code(value: String) -> Attribute {
  with_value("code", value)
}

pub fn codebase(value: String) -> Attribute {
  with_value("codebase", value)
}

pub fn cols(value: Int) -> Attribute {
  with_value("cols", int.to_string(value))
}

pub fn colspan(value: Int) -> Attribute {
  with_value("colspan", int.to_string(value))
}

pub fn content(value: String) -> Attribute {
  with_value("content", value)
}

pub fn contextmenu(value: String) -> Attribute {
  with_value("contextmenu", value)
}

pub fn coords(value: String) -> Attribute {
  with_value("coords", value)
}

pub fn crossorigin(value: String) -> Attribute {
  with_value("crossorigin", value)
}

pub fn csp(value: String) -> Attribute {
  with_value("csp", value)
}

pub fn datetime(value: String) -> Attribute {
  with_value("datetime", value)
}

pub fn decoding(value: String) -> Attribute {
  with_value("decoding", value)
}

pub fn dir(value: String) -> Attribute {
  with_value("dir", value)
}

pub fn dirname(value: String) -> Attribute {
  with_value("dirname", value)
}

pub fn download(value: String) -> Attribute {
  with_value("download", value)
}

pub fn enctype(value: String) -> Attribute {
  with_value("enctype", value)
}

pub fn enterkeyhint(value: String) -> Attribute {
  with_value("enterkeyhint", value)
}

pub fn for(value: String) -> Attribute {
  with_value("for", value)
}

pub fn form(value: String) -> Attribute {
  with_value("form", value)
}

pub fn formaction(value: String) -> Attribute {
  with_value("formaction", value)
}

pub fn formenctype(value: String) -> Attribute {
  with_value("formenctype", value)
}

pub fn formmethod(value: String) -> Attribute {
  with_value("formmethod", value)
}

pub fn formnovalidate(value: String) -> Attribute {
  with_value("formnovalidate", value)
}

pub fn formtarget(value: String) -> Attribute {
  with_value("formtarget", value)
}

pub fn headers(value: String) -> Attribute {
  with_value("headers", value)
}

pub fn high(value: String) -> Attribute {
  with_value("high", value)
}

pub fn href(value: String) -> Attribute {
  with_value("href", value)
}

pub fn hreflang(value: String) -> Attribute {
  with_value("hreflang", value)
}

pub fn http_equiv(value: String) -> Attribute {
  with_value("http-equiv", value)
}

pub fn icon(value: String) -> Attribute {
  with_value("icon", value)
}

pub fn id(value: String) -> Attribute {
  with_value("id", value)
}

pub fn importance(value: String) -> Attribute {
  with_value("importance", value)
}

pub fn integrity(value: String) -> Attribute {
  with_value("integrity", value)
}

pub fn ismap(value: String) -> Attribute {
  with_value("ismap", value)
}

pub fn itemprop(value: String) -> Attribute {
  with_value("itemprop", value)
}

pub fn keytype(value: String) -> Attribute {
  with_value("keytype", value)
}

pub fn kind(value: String) -> Attribute {
  with_value("kind", value)
}

pub fn label(value: String) -> Attribute {
  with_value("label", value)
}

pub fn lang(value: String) -> Attribute {
  with_value("lang", value)
}

pub fn language(value: String) -> Attribute {
  with_value("language", value)
}

pub fn list(value: String) -> Attribute {
  with_value("list", value)
}

pub fn low(value: String) -> Attribute {
  with_value("low", value)
}

pub fn manifest(value: String) -> Attribute {
  with_value("manifest", value)
}

pub fn max(value: String) -> Attribute {
  with_value("max", value)
}

pub fn maxlength(value: Int) -> Attribute {
  with_value("maxlength", int.to_string(value))
}

pub fn minlength(value: Int) -> Attribute {
  with_value("minlength", int.to_string(value))
}

pub fn media(value: String) -> Attribute {
  with_value("media", value)
}

pub fn method(value: String) -> Attribute {
  with_value("method", value)
}

pub fn min(value: String) -> Attribute {
  with_value("min", value)
}

pub fn muted(value: String) -> Attribute {
  with_value("muted", value)
}

pub fn name(value: String) -> Attribute {
  with_value("name", value)
}

pub fn optimum(value: String) -> Attribute {
  with_value("optimum", value)
}

pub fn pattern(value: String) -> Attribute {
  with_value("pattern", value)
}

pub fn ping(value: String) -> Attribute {
  with_value("ping", value)
}

pub fn placeholder(value: String) -> Attribute {
  with_value("placeholder", value)
}

pub fn poster(value: String) -> Attribute {
  with_value("poster", value)
}

pub fn preload(value: String) -> Attribute {
  with_value("preload", value)
}

pub fn radiogroup(value: String) -> Attribute {
  with_value("radiogroup", value)
}

pub fn referrerpolicy(value: String) -> Attribute {
  with_value("referrerpolicy", value)
}

pub fn rel(value: String) -> Attribute {
  with_value("rel", value)
}

pub fn role(value: String) -> Attribute {
  with_value("role", value)
}

pub fn rows(value: String) -> Attribute {
  with_value("rows", value)
}

pub fn rowspan(value: Int) -> Attribute {
  with_value("rowspan", int.to_string(value))
}

pub fn sandbox(value: String) -> Attribute {
  with_value("sandbox", value)
}

pub fn scope(value: String) -> Attribute {
  with_value("scope", value)
}

pub fn scoped(value: String) -> Attribute {
  with_value("scoped", value)
}

pub fn selected(value: String) -> Attribute {
  with_value("selected", value)
}

pub fn shape(value: String) -> Attribute {
  with_value("shape", value)
}

pub fn size(value: Int) -> Attribute {
  with_value("size", int.to_string(value))
}

pub fn sizes(value: String) -> Attribute {
  with_value("sizes", value)
}

pub fn slot(value: String) -> Attribute {
  with_value("slot", value)
}

pub fn span(value: String) -> Attribute {
  with_value("span", value)
}

pub fn src(value: String) -> Attribute {
  with_value("src", value)
}

pub fn srcdoc(value: String) -> Attribute {
  with_value("srcdoc", value)
}

pub fn srclang(value: String) -> Attribute {
  with_value("srclang", value)
}

pub fn srcset(value: String) -> Attribute {
  with_value("srcset", value)
}

pub fn start(value: Int) -> Attribute {
  with_value("start", int.to_string(value))
}

pub fn step(value: String) -> Attribute {
  with_value("step", value)
}

pub fn style(value: String) -> Attribute {
  with_value("style", value)
}

pub fn summary(value: String) -> Attribute {
  with_value("summary", value)
}

pub fn tabindex(value: Int) -> Attribute {
  with_value("tabindex", int.to_string(value))
}

pub fn target(value: String) -> Attribute {
  with_value("target", value)
}

pub fn title(value: String) -> Attribute {
  with_value("title", value)
}

pub fn translate(value: String) -> Attribute {
  with_value("translate", value)
}

pub fn type_(value: String) -> Attribute {
  with_value("type", value)
}

pub fn usemap(value: String) -> Attribute {
  with_value("usemap", value)
}

pub fn value(value: String) -> Attribute {
  with_value("value", value)
}

pub fn height(value: Int) -> Attribute {
  with_value("height", int.to_string(value))
}

pub fn width(value: Int) -> Attribute {
  with_value("width", int.to_string(value))
}

pub fn wrap(value: String) -> Attribute {
  with_value("wrap", value)
}
