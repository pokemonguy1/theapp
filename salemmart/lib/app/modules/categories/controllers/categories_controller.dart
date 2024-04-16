import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final selectedSubCategory = 0.obs;
  RxString subCategorySlug = "".obs;
  RxList<dynamic> subCategorys = RxList<dynamic>([]);
  RxList brandFacet = [].obs;
  Map<String, dynamic> products = <String, dynamic>{};
  Map<String, dynamic> allCategory = <String, dynamic>{};

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getBrands(List<dynamic> facetvalue) {
    if (products.values.isNotEmpty) {
      brandFacet.value = facetvalue
          .where((element) => element['facetValue']['facet']['name'] == 'brand')
          .toList();
    }
  }
}
