import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class GridItems extends StatelessWidget {
  final bool favoriteItems;

  const GridItems({Key? key,required this.favoriteItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = favoriteItems ? productData.favoriteItems :  productData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value:  products[index],
        child: ProductItems(),
      ),
    );
  }
}
