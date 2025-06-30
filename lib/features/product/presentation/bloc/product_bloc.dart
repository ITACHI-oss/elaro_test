import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/product_model.dart';
import '../../data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository repository;

  ProductsBloc(this.repository) : super(ProductsInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await repository.fetchFilteredProducts(
          categoryId: event.categoryId,
          priceMin: event.priceMin,
          priceMax: event.priceMax,
        );
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });
  }
}
