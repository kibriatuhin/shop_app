import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_Product_screens.dart';

class UserProductItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
   UserProductItems({
    Key? key,
    required this.title,
    required this.imageUrl,required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pushNamed(EditProductScreens.routeName);
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete),color: Theme.of(context).primaryColor,),
              ],
            ),
        ),

      ),
    );
  }
}
