import 'package:flutter/material.dart';
import 'package:practice_ui/furniture/home/product_body.dart';

import '../../constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: kFurnitureColor,
      body: const ProductBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kFurnitureColor,
      elevation: 0,
      centerTitle: false,
      title: const Text('Dashboard'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    );
  }
}