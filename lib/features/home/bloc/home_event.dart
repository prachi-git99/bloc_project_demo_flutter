part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

//jo bhi kaam hmm kr rhe h screen pr

class HomeInitialEvent extends HomeEvent{}

class HomeProductWishlistButtonClickedEvent extends HomeEvent{
  final ProductDataModel clickedProduct;
  HomeProductWishlistButtonClickedEvent(this.clickedProduct);
}

class HomeProductCartButtonClickedEvent extends HomeEvent{
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent(this.clickedProduct);

}

class HomeWishlistButtonNavigateEvent extends HomeEvent{}

class HomeCartButtonNavigateEvent extends HomeEvent{}