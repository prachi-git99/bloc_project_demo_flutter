import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/cart/UI/cart.dart';
import 'package:flutter_bloc_project/features/home/UI/widgets/product_tile_widget.dart';
import 'package:flutter_bloc_project/features/wishlist/UI/wishlist.dart';

import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    // TODO: implement initState
    super.initState();

  }
  //initialise home bloc
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous,current) => current is HomeActionState,
      buildWhen: (previous,current) => current is !HomeActionState,
      listener: (context, state) {
        //ye logic dekhega
        if(state is HomeNavigateToCartPageActionState){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>Cart()));
        }
        else if(state is HomeNavigateToWishlistPageActionState){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>Wishlist()));
        }
        else if(state is HomeProductItemWishlistedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Wishlist updated")));
        }
        else if(state is HomeProductItemCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Cart Item updated")));
        }

      },
      builder: (context, state) {
        //ye ui dekhega
        switch(state.runtimeType){
          case HomeLoadingState:
            return Scaffold(
              body:  Center(
                child: CircularProgressIndicator(color: Colors.teal,),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
            appBar: AppBar(
              title: Text("Bloc Demo App", style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),),
              actions: [
                IconButton(
                  onPressed:(){
                    homeBloc.add(HomeWishlistButtonNavigateEvent());
                  },
                  icon: Icon(Icons.favorite,color: Colors.white,),
                ),
                IconButton(
                  onPressed:(){
                    homeBloc.add(HomeCartButtonNavigateEvent());
                  },
                  icon: Icon(Icons.shopping_cart,color: Colors.white,),
                ),
              ],
            ),
            body: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder:(context,index){
                      return ProductTileWidget(productDataModel: successState.products[index],homeBloc: homeBloc,);
                    }
                  ),

          );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child:Text('Error....'),
              ),
            );
          default: return SizedBox();
        }
      },
    );
  }
}
