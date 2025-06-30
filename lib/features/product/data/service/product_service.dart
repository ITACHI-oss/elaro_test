import 'package:dio/dio.dart';
import '../model/product_model.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<ProductModel>> getFilteredProducts({
    required int categoryId,
    int? priceMin,
    int? priceMax,
    String? color,
  }) async {
    try {
      final response = await dio.get(
        'https://api.elaro.uz/api/categories/$categoryId',
        queryParameters: {
          if (priceMin != null) 'price_min': priceMin,
          if (priceMax != null) 'price_max': priceMax,
          if (color != null && color.isNotEmpty) 'color': color,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<dynamic>? subCategories = data['sub_categories'];

        if (subCategories == null) {
          throw Exception('"sub_categories" mavjud emas');
        }

        return subCategories
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Serverdan noto‘g‘ri status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Productlarni olishda xatolik: $e');
    }
  }
}
