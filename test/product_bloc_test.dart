import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test_app/features/product/data/model/product_model.dart';
import 'package:test_app/features/product/data/repository/product_repository.dart';
import 'package:test_app/features/product/presentation/bloc/product_bloc.dart';

class FakeProductRepository implements ProductRepository {
  @override
  Future<List<ProductModel>> fetchFilteredProducts({
    required int categoryId,
    int? priceMin,
    int? priceMax,
    String? color,
  }) async {
    return [
      ProductModel(
        id: 1,
        name: "Test Product",
        image: "url",
        categoryId: categoryId,
        color: "#000000",
      ),
    ];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('ProductsBloc test', () {
    late ProductsBloc bloc;

    setUp(() {
      bloc = ProductsBloc(FakeProductRepository());
    });

    blocTest<ProductsBloc, ProductsState>(
      'emits [ProductsLoading, ProductsLoaded] when LoadProducts is added',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadProducts(categoryId: 3)),
      expect:
          () => [
            isA<ProductsLoading>(),
            isA<ProductsLoaded>().having(
              (state) => state.products.length,
              'products.length',
              1,
            ),
          ],
    );
  });
}
