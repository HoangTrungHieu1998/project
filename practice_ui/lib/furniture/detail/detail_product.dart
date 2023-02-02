import 'package:flutter/material.dart';
import 'package:practice_ui/constants.dart';
import 'package:practice_ui/furniture/detail/detail_body.dart';
import 'package:practice_ui/furniture/product.dart';

class DetailProduct extends StatelessWidget {
  final Product? product;

  const DetailProduct({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFurnitureColor,
      appBar: buildAppBar(context),
      body: DetailBody(
        product: product,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        icon: Image.asset("assets/icons/back_arrow.png"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ],
    );
  }
}