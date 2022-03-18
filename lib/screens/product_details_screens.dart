import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
class ProductDetails extends StatelessWidget {
  static const routeName = "/product-details";

 // final String title;

  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,listen: false).findById(productId);


    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title,style: TextStyle(
          color: Theme.of(context).primaryColor
        ),),
      ),
      body:Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(loadedProduct.imageUrl,fit: BoxFit.cover,),
          ),
          SizedBox(
            height: 10,
          ),
          Text("\$${loadedProduct.price}",style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
          SizedBox(
            height: 10,
          ),
          Text("${loadedProduct.description}",textAlign: TextAlign.center,softWrap: true,style: TextStyle(
            fontWeight: FontWeight.bold
          ),)
        ],
      )
    );
  }
}
