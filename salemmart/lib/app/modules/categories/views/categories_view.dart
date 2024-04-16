import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/widgetConstant.dart';
import 'package:flutter_vendure_stor/app/modules/categories/views/categori_detail_view.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../constants/colorConstant.dart';
import '../../../data/query/query.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);
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
          actions: const [
            Badge(
                alignment: Alignment.topRight,
                backgroundColor: ColorConstant.primeryColor,
                smallSize: 30,
                offset: Offset(5, -3),
                label: Text("3"),
                child: Icon(
                  Icons.notifications,
                  color: ColorConstant.iconColor,
                )),
            SizedBox(
              width: 20,
            ),
          ],
          title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: ColorConstant.primeryColor.withOpacity(0.05),
                  hintText: "Search",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorConstant.iconColor,
                    size: 30,
                  )),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 11, top: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "All Categories",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.secondryColor),
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //categories
                      SizedBox(
                          width: 90,
                          child: Query(
                            options: QueryOptions(
                                document: gql(QueryApp.allCategory)),
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
                                  child: Text("No product found"),
                                );
                              }
                              if (result.data!.isNotEmpty) {
                                controller.allCategory = result.data!;
                              }
                              return ListWheelScrollView(
                                itemExtent: 90,
                                magnification: 1,
                                useMagnifier: false,
                                controller: ScrollController(),
                                diameterRatio: 2,
                                children: List.generate(
                                    controller.allCategory["collections"]["totalItems"],
                                    (index) => Obx(() => 
                                    GestureDetector(
                                          onTap: () {
                                            controller.subCategorySlug
                                                .value = controller
                                                    .allCategory["collections"]
                                                ["items"][index]["slug"];
                                            controller.selectedSubCategory
                                                .value = index;
                                          },
                                          child: Material(
                                            elevation: controller
                                                        .selectedSubCategory
                                                        .value ==
                                                    index
                                                ? 20
                                                : 0,
                                            animationDuration: const Duration(
                                                microseconds: 20),
                                            type: MaterialType.card,
                                            borderOnForeground: true,
                                            shadowColor: ColorConstant
                                                .primeryColor
                                                .withOpacity(0.4),
                                            color: Colors.transparent,
                                            child: Container(
                                                width: controller
                                                            .selectedSubCategory
                                                            .value ==
                                                        index
                                                    ? 90
                                                    : 80,
                                                height: controller
                                                            .selectedSubCategory
                                                            .value ==
                                                        index
                                                    ? 90
                                                    : 80,
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    border: controller
                                                                .selectedSubCategory
                                                                .value ==
                                                            index
                                                        ? Border.all(
                                                            style:
                                                                BorderStyle.solid,
                                                            width: 2,
                                                            color: ColorConstant.primeryColor)
                                                        : Border.all(color: ColorConstant.backgroundColor),
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                                        .allCategory[
                                                                    "collections"]
                                                                ["items"][index]
                                                            [
                                                            "featuredAsset"]["preview"],
                                                        placeholder:
                                                            (context, url) =>
                                                                const Icon(
                                                          Icons.image,
                                                          color: ColorConstant
                                                              .iconColor,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        fit: BoxFit.cover,
                                                        width: 90,
                                                        height: 90,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: Get.width,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration: BoxDecoration(
                                                            color: ColorConstant
                                                                .backgroundColor
                                                                .withOpacity(
                                                                    0.7),
                                                            borderRadius: const BorderRadius
                                                                .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                        child: Text(
                                                          controller.allCategory[
                                                                      "collections"]
                                                                  ["items"]
                                                              [index]["name"],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: ColorConstant
                                                                  .secondryColor),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ))),
                              );
                            },
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      // sub category
                      Expanded(
                          child: Obx(
                        () => SizedBox(
                          child: controller.allCategory.isEmpty
                              ? const Center(
                                  child: WidgetConstant.spinkitLoading,
                                )
                              : Query(
                                  options: QueryOptions(
                                      document:
                                          gql(QueryApp.getCollectionProducts),
                                      variables: {
                                        "slug": controller
                                                    .subCategorySlug.value ==
                                                ""
                                            ? controller
                                                    .allCategory["collections"]
                                                ["items"][0]["slug"]
                                            : controller.subCategorySlug.value,
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
                                        child: Text("No product found"),
                                      );
                                    }
                                    if (result.data!.isNotEmpty) {
                                      controller.products = result.data!;
                                    }
                                    return GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                        itemCount: controller.products["search"]
                                            ["totalItems"],
                                        itemBuilder: (context, index) => CollectionProductCart(
                                            image: controller.products["search"]["items"][index]
                                                ["productAsset"]["preview"],
                                            name: controller.products["search"]
                                                ["items"][index]["productName"],
                                            min: controller.products["search"]["items"]
                                                [index]["priceWithTax"]["min"],
                                            max: controller.products["search"]["items"]
                                                [index]["priceWithTax"]["max"],
                                            slug: controller.products["search"]
                                                ["items"][index]["slug"]));
                                  },
                                ),
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
