import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_project/features/wishlist/UI/widgets/wishlist_tile_widget.dart';
import 'package:flutter_bloc_project/features/wishlist/bloc/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  final WishlistBloc wishlistBloc = WishlistBloc();
  final HomeBloc homeBloc =HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous,current) => current is WishlistActionState,
        buildWhen: (previous,current) => current is !WishlistActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch(state.runtimeType){
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder:(context,index) {
                    return WishlistTileWidget(productDataModel: successState.wishlistItems[index] ,wishlistBloc: wishlistBloc,homeBloc: homeBloc,);
                  });
              break;
            default: return SizedBox(child: Text("Wishlist is empty"),);
          }
          return Container();
        },
      ),
    );
  }
}
