import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/shop/shop_event.dart';
import 'package:leafolyze/blocs/shop/shop_state.dart';
import 'package:leafolyze/repositories/shop_repository.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository _repository;

  ShopBloc(this._repository) : super(ShopInitial()) {
    on<LoadShops>(_onLoadShops);
  }

  Future<void> _onLoadShops(
    LoadShops event,
    Emitter<ShopState> emit,
  ) async {
    emit(ShopLoading());
    try {
      final shops = await _repository.getShop();
      emit(ShopLoaded(shops));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }
}
