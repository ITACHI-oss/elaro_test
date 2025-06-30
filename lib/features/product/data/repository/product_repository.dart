import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductRepository {
  final ProductService service;

  ProductRepository(this.service);

  Future<List<ProductModel>> fetchFilteredProducts({
    required int categoryId,
    int? priceMin,
    int? priceMax,
    String? color,
  }) {
    return service.getFilteredProducts(
      categoryId: categoryId,
      priceMin: priceMin,
      priceMax: priceMax,
      color: color,
    );
  }
}
