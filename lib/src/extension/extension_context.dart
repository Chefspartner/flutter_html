import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/src/html_elements.dart';
import 'package:html/dom.dart' as html;

/// Provides information about the current element on the Html tree for
/// an [Extension] to use.
class ExtensionContext {
  /// The HTML node being represented as a Flutter widget.
  final html.Node node;

  /// Returns the name of the Html element, or an empty string if the node is
  /// a text content node, comment node, or any other node without a name.
  String get elementName {
    if (node is html.Element) {
      return (node as html.Element).localName ?? '';
    }

    return '';
  }

  /// Returns the HTML within this element, or an empty string if there is none.
  String get innerHtml {
    return node.sourceSpan?.text ?? '';
  }

  /// Returns the list of child Elements on this html Node, or an empty list if
  /// there are no children.
  List<html.Element> get elementChildren {
    return node.children;
  }

  /// Returns a linked hash map representing the attributes of the node, or an
  /// empty map if it has no attributes.
  LinkedHashMap<String, String> get attributes {
    return LinkedHashMap.from(node.attributes.map((key, value) {
      // Key is either a String or html.AttributeName
      return MapEntry(key.toString(), value);
    }));
  }

  /// Returns the id of the element, or an empty string if it is not present
  String get id {
    if (node is html.Element) {
      return (node as html.Element).id;
    }

    return '';
  }

  /// Returns a set of classes on the element, or an empty set if none are
  /// present.
  Set<String> get classes {
    if (node is html.Element) {
      return (node as html.Element).classes;
    }

    return <String>{};
  }

  /// A reference to the [HtmlParser] instance. Useful for calling callbacks
  /// on the [Html] widget like [onLinkTap].
  final HtmlParser parser;

  /// A reference to the [StyledElement] representation of this node.
  /// Guaranteed to be non-null only after the lexing step
  final StyledElement? styledElement;

  /// Guaranteed only when in the `parse` method of an Extension, but it might not necessarily be the nearest BuildContext. Probably should use a `Builder` Widget if you absolutely need the most relevant BuildContext.
  final BuildContext? context;

  /// Constructs a new [ExtensionContext] object with the given information.
  const ExtensionContext({
    required this.node,
    required this.parser,
    this.styledElement,
    this.context,
  });
}
