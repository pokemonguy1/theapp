import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/widgetConstant.dart';
import 'package:flutter_vendure_stor/app/modules/categories/views/categori_detail_view.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants/colorConstant.dart';
import '../../../data/query/query.dart';
import '../controllers/search_product_controller.dart';

class SearchProductView extends GetView<SearchProductController> {
  const SearchProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorConstant.iconColor,
              )),
          title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              controller: controller.searchController.value,
              autofocus: true,
              onChanged: (value) => controller.searchTerm.value = value,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: ColorConstant.primeryColor.withOpacity(0.03),
                  hintText: "Search",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorConstant.iconColor,
                    size: 35,
                  )),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Serach",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.secondryColor),
              ),
              const Text(
                "your Favotite Product",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.secondryColor),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                  child: Obx(() => controller.searchTerm.value == ""
                      ? const SizedBox()
                      : Query(
                          options: QueryOptions(
                              document: gql(QueryApp.search),
                              variables: {
                                "term": controller.searchTerm.value,
                                "skip": 0,
                              }),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return const Center(
                                child: WidgetConstant.spinkitLoading,
                              );
                            }
                            if (result.hasException) {
                              return const Center(
                                child: WidgetConstant.spinkitLoading,
                              );
                            }
                            if (result.data!.isEmpty) {
                              return const Center(
                                  child: Text("no product found"));
                            }
                            if (result.data!.isNotEmpty) {
                              controller.searchedProduct.value = result.data!;
                            }
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemCount: controller
                                  .searchedProduct["search"]["items"].length,
                              itemBuilder: (context, index) => CollectionProductCart(
                                  image: controller.searchedProduct["search"]
                                          ["items"][index]["productAsset"]
                                      ["preview"],
                                  name: controller.searchedProduct["search"]
                                      ["items"][index]["productName"],
                                  min: controller.searchedProduct["search"]
                                      ["items"][index]["priceWithTax"]["min"],
                                  max: controller.searchedProduct["search"]
                                      ["items"][index]["priceWithTax"]["max"],
                                  slug: controller.searchedProduct["search"]
                                      ["items"][index]["slug"]),
                            );
                          },
                        )))
            ],
          ),
        ));
  }
}
