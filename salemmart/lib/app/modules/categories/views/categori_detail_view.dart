import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/widgetConstant.dart';
import 'package:flutter_vendure_stor/app/modules/categories/controllers/categories_controller.dart';
import 'package:flutter_vendure_stor/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../constants/colorConstant.dart';
import '../../../data/query/query.dart';

class CategoriDetailView extends GetView<CategoriesController> {
  CategoriDetailView({Key? key}) : super(key: key);

  final category = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => CategoriesController(),
    );
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: ColorConstant.primeryColor.withOpacity(0.03),
                  hintText: "Search",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorConstant.iconColor,
                    size: 30,
                  )),
            ),
          ),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorConstant.iconColor,
              )),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.filter_list_alt,
                color: ColorConstant.iconColor,
                size: 30,
              ),
              onPressed: () => Get.bottomSheet(
                  ignoreSafeArea: true,
                  BottomSheet(
                    backgroundColor: ColorConstant.backgroundColor,
                    enableDrag: true,
                    elevation: 10,
                    onClosing: () {},
                    builder: (context) => const BottomSheetContent(),
                  )),
            ),
            const Badge(
                alignment: Alignment.topRight,
                backgroundColor: ColorConstant.primeryColor,
                smallSize: 30,
                offset: Offset(5, -3),
                label: Text("3"),
                child: Icon(
                  Icons.notifications,
                  color: ColorConstant.iconColor,
                )),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                category["name"],
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.secondryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Row(
                children: [
                  Text("Slug:  ",
                      style: TextStyle(
                          color: ColorConstant.secondryColor.withOpacity(0.6))),
                  Text(
                    category["slug"],
                    style: TextStyle(
                        color: ColorConstant.secondryColor.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: Get.width,
              height: Get.height,
              margin: const EdgeInsets.only(top: 15, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    child: Query(
                      options: QueryOptions(
                          document: gql(QueryApp.categoryOfSelectedCollection),
                          variables: {"slug": category["slug"]}),
                      builder: (result, {fetchMore, refetch}) {
                        if (result.isLoading) {
                          return const Center(
                              child: WidgetConstant.spinkitLoading);
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
                          controller.subCategorys.value =
                              result.data?["collection"]["children"];
                        }
                        return ListWheelScrollView(
                          itemExtent: 90,
                          magnification: 1,
                          useMagnifier: false,
                          controller: ScrollController(),
                          diameterRatio: 2,
                          children: List.generate(
                              controller.subCategorys.length,
                              (index) => GestureDetector(
                                    onTap: () async {
                                      controller.subCategorySlug.value =
                                          result.data?["collection"]["children"]
                                              [index]["slug"];
                                      controller.selectedSubCategory.value =
                                          index;
                                    },
                                    child: ChildCollectionCart(
                                      image: controller.subCategorys[index]
                                          ["featuredAsset"]["preview"],
                                      name: controller.subCategorys[index]
                                          ["name"],
                                      slug: controller.subCategorys[index]
                                          ["slug"],
                                    ),
                                  )),
                        );
                      },
                    ),
                  ),
                  //products
                  Expanded(
                      child: Obx(() => Query(
                            options: QueryOptions(
                                document: gql(QueryApp.getCollectionProducts),
                                variables: {
                                  "slug": controller.subCategorySlug.value == ""
                                      ? category["slug"]
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
                                controller.getBrands(controller
                                    .products["search"]["facetValues"]);
                              }
                              return GridView.builder(
                                  padding: const EdgeInsets.all(15),
                                  controller: ScrollController(),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.products["search"]
                                      ["totalItems"],
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemBuilder: (context, index) =>
                                      CollectionProductCart(
                                        image: controller.products["search"]
                                                ["items"][index]["productAsset"]
                                            ["preview"],
                                        name: controller.products["search"]
                                            ["items"][index]["productName"],
                                        min: controller.products["search"]
                                                ["items"][index]["priceWithTax"]
                                            ["min"],
                                        max: controller.products["search"]
                                                ["items"][index]["priceWithTax"]
                                            ["max"],
                                        slug: controller.products["search"]
                                            ["items"][index]["slug"],
                                      ));
                            },
                          )))
                ],
              ),
            )),
          ],
        ));
  }
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(15),
      color: ColorConstant.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            indent: 150,
            endIndent: 150,
            thickness: 5,
            color: ColorConstant.iconColor,
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
              child: ListView(
            children: [
              const Text(
                "Category",
                style: TextStyle(color: ColorConstant.secondryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                verticalDirection: VerticalDirection.down,
                children: List.generate(
                    Get.find<CategoriesController>().subCategorys.length,
                    (index) => Obx(() => Row(
                          children: [
                            Checkbox.adaptive(
                              value: Get.find<CategoriesController>()
                                          .subCategorySlug
                                          .value ==
                                      ""
                                  ? false
                                  : Get.find<CategoriesController>()
                                              .selectedSubCategory
                                              .value ==
                                          index
                                      ? true
                                      : false,
                              onChanged: (value) async {
                                Get.find<CategoriesController>()
                                    .selectedSubCategory
                                    .value = index;
                                Get.find<CategoriesController>()
                                        .subCategorySlug
                                        .value =
                                    Get.find<CategoriesController>()
                                        .subCategorys[index]["slug"];
                              },
                            ),
                            Text(Get.find<CategoriesController>()
                                .subCategorys[index]["name"])
                          ],
                        ))),
              ),
              const Text(
                "Brand",
                style: TextStyle(color: ColorConstant.secondryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                verticalDirection: VerticalDirection.down,
                children: List.generate(
                    Get.find<CategoriesController>().brandFacet.length,
                    (index) => Row(
                          children: [
                            Checkbox.adaptive(
                              value: false,
                              onChanged: (value) {},
                            ),
                            Text(Get.find<CategoriesController>()
                                .brandFacet[index]["facetValue"]['name'])
                          ],
                        )),
              )
            ],
          )),
          SizedBox(
            width: Get.width,
            child: ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.filter_list_alt,
                  color: ColorConstant.backgroundColor,
                ),
                label: const Text(
                  "Apply filter",
                  style: TextStyle(color: ColorConstant.backgroundColor),
                )),
          )
        ],
      ),
    );
  }
}

class CollectionProductCart extends StatelessWidget {
  const CollectionProductCart(
      {super.key,
      required this.image,
      required this.name,
      required this.min,
      required this.max,
      required this.slug});

  final String image;
  final String name;
  final int min;
  final int max;
  final String slug;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: GestureDetector(
        onTap: () async {
          Get.toNamed(Routes.PRODUCT, arguments: slug);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: slug,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => const Icon(
                        Icons.image,
                        color: ColorConstant.iconColor,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 110,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 3, right: 10),
              child: Text(
                name,
                maxLines: 1,
                style: const TextStyle(
                  color: ColorConstant.secondryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 1),
              child: min == max
                  ? Text(
                      (min / 100).toString(),
                      style: const TextStyle(
                          fontSize: 15,
                          color: ColorConstant.secondryColor,
                          fontWeight: FontWeight.bold),
                    )
                  : Row(
                      children: [
                        Text(
                          (min / 100).toString(),
                          style: const TextStyle(
                              fontSize: 15,
                              color: ColorConstant.secondryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(" - "),
                        Text(
                          (max / 100).toString(),
                          style: const TextStyle(
                              fontSize: 15,
                              color: ColorConstant.secondryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChildCollectionCart extends StatelessWidget {
  const ChildCollectionCart(
      {super.key, required this.image, required this.name, required this.slug});

  final String image;
  final String name;
  final String slug;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Material(
          elevation:
              Get.find<CategoriesController>().subCategorySlug.value == slug
                  ? 10
                  : 0,
          animationDuration: const Duration(microseconds: 20),
          type: MaterialType.card,
          borderOnForeground: true,
          shadowColor: ColorConstant.primeryColor.withOpacity(0.4),
          color: Colors.transparent,
          child: Container(
              width: 90,
              height: 71,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Get.find<CategoriesController>()
                              .subCategorySlug
                              .value ==
                          slug
                      ? Border.all(color: ColorConstant.primeryColor, width: 1)
                      : Border.all(color: ColorConstant.backgroundColor)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => const Icon(
                        Icons.image,
                        color: ColorConstant.iconColor,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: ColorConstant.backgroundColor.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12, color: ColorConstant.secondryColor),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
