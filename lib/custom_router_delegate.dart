library custom_router_delegate;

import 'dart:collection';

import 'package:flutter/material.dart';

abstract class CustomRouterDelegate<R> extends RouterDelegate<R>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<R> {
  abstract final List<Widget> pages;

  Queue<Page> get _pages =>
      Queue<Page>.from(pages.map((e) => MaterialPage(child: e)));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKey.currentState?.canPop() ?? false) {
          _navigatorKey.currentState?.pop();
          return true;
        } else {
          return false;
        }
      },
      child: Navigator(
        key: _navigatorKey,
        pages: _pages.toList(),
        onPopPage: (route, result) {
          pages.removeLast();
          return route.didPop(result);
        },
      ),
    );
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
}
