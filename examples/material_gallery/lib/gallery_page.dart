// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'demo/widget_demo.dart';

class GalleryPage extends StatefulComponent {
  GalleryPage({ this.demos, this.active, this.onThemeChanged });

  final List<WidgetDemo> demos;
  final WidgetDemo active;
  final ValueChanged<ThemeData> onThemeChanged;

  _GalleryPageState createState() => new _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Widget _buildDrawer() {
    List<Widget> items = <Widget>[
      new DrawerHeader(child: new Text('Flutter Material demos')),
    ];

    for (WidgetDemo demo in config.demos) {
      items.add(new DrawerItem(
        onPressed: () {
          Navigator.pushNamed(context, demo.routeName);
        },
        child: new Text(demo.title)
      ));
    }

    // TODO(eseidel): We should make this into a shared DrawerFooter.
    items.add(new DrawerDivider());
    items.add(new DrawerItem(child: new Flex([
      new Text("Made with Flutter "),
      new Container(
        margin: const EdgeDims.symmetric(horizontal: 5.0),
        child: new AssetImage(
            name: 'assets/flutter_logo.png',
            height: 16.0,
            fit: ImageFit.contain
        )
      )
    ])));

    return new Drawer(child: new Block(items));
  }

  Widget _buildBody() {
    if (config.active != null)
      return config.active.builder(context);
    return new Material(
      child: new Center(
        child: new Text('Select a demo from the drawer')
      )
    );
  }

  Widget _buildTabBar() {
    final WidgetBuilder builder = config.active?.tabBarBuilder;
    return builder != null ? builder(context) : null;
  }

  Widget _buildPageWrapper(BuildContext context, Widget child) {
    final PageWrapperBuilder builder = config.active?.pageWrapperBuilder;
    return builder != null ? builder(context, child) : child;
  }

  Widget _buildFloatingActionButton() {
    final WidgetBuilder builder = config.active?.floatingActionButtonBuilder;
    return builder != null ? builder(context) : null;
  }

  Widget build(BuildContext context) {
    return _buildPageWrapper(context,
      new Scaffold(
        toolBar: new ToolBar(
          center: new Text(config.active?.title ?? 'Flutter Material gallery'),
          tabBar: _buildTabBar()
        ),
        drawer: _buildDrawer(),
        floatingActionButton: _buildFloatingActionButton(),
        body: _buildBody()
      )
    );
  }
}
