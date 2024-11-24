import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class LoadShops extends ShopEvent {}

class SearchShops extends ShopEvent {
  final String query;

  const SearchShops(this.query);

  @override
  List<Object> get props => [query];
}
