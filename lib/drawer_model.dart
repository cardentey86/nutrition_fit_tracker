import 'package:flutter/material.dart';

/* class ParentItem {
  final String title;
  final List<ChildItem> children;
  final Icon icon;

  ParentItem({required this.title, required this.children, required this.icon});
} */

class ChildItem {
  final Icon icon;
  final String text;
  final String route;

  ChildItem({required this.icon, required this.text, required this.route});
}
