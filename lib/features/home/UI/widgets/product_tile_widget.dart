import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({super.key,required this.productDataModel,required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 10),
        border: Border.all(color: Colors.black)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(productDataModel.image.toString())
              )
            ),
          ),
          SizedBox(height: 20,),
          Text(productDataModel.name.toString(),style: TextStyle(
            fontSize: 18,fontWeight: FontWeight.bold
          ),),
          Text(productDataModel.desc.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs. "+productDataModel.price.toString(),style: TextStyle(
                  fontSize: 14,fontWeight: FontWeight.bold
              ),),
              Row(

                children: [
                  IconButton(
                    onPressed:(){
                      homeBloc.add(HomeProductWishlistButtonClickedEvent(productDataModel));
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed:(){
                      homeBloc.add(HomeProductCartButtonClickedEvent(productDataModel));
                    },
                    icon: Icon(Icons.shopping_cart_outlined,),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
