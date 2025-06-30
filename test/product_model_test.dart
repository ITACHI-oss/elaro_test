import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/features/product/data/model/product_model.dart';

void main() {
  test("ProductModel JSON parse test", () {
    final json = {
      "id": 1,
      "name_uz": "Kompyuter",
      "image": "https://api.elaro.uz/img.png",
      "category_id": 3,
    };

    final product = ProductModel.fromJson(json);

    expect(product.id, 1);
    expect(product.name, "Kompyuter");
    expect(product.image, "https://api.elaro.uz/img.png");
    expect(product.categoryId, 3);
  });
}
