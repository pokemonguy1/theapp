import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';
import 'package:flutter_vendure_stor/app/constants/widgetConstant.dart';
import 'package:flutter_vendure_stor/app/data/mutation/mutation.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../data/query/query.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  ProductView({Key? key}) : super(key: key);

  String slug = Get.arguments;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: const Text("Product detail"),
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
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Query(
              options: QueryOptions(
                  document: gql(QueryApp.ProductDetail),
                  variables: {"slug": slug}),
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
                    child: WidgetConstant.spinkitLoading,
                  );
                }
                if (result.data!.isNotEmpty) {
                  controller.productDetail.value = result.data!;
                  controller.getAllVariantInfo();
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: [
                            Container(
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                      controller.productDetail
                                          .value["product"]["assets"].length,
                                      (index) => Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: controller.productDetail
                                                    .value["product"]["assets"]
                                                [index]["preview"],
                                            placeholder: (context, url) =>
                                                const Icon(
                                              Icons.image,
                                              color: ColorConstant.iconColor,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Hero(
                                      tag: slug,
                                      child: Container(
                                        width: Get.width,
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 230,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: controller.productDetail
                                                    .value["product"]
                                                ["featuredAsset"]["preview"],
                                            placeholder: (context, url) =>
                                                const Icon(
                                              Icons.image,
                                              color: ColorConstant.iconColor,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                            width: Get.width,
                                            height: 200,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.productDetail.value["product"]["variants"][0]["priceWithTax"] / 100} " +
                                      controller.productDetail.value["product"]
                                          ["variants"][0]["currencyCode"],
                                  style: const TextStyle(
                                      fontSize: 23,
                                      color: ColorConstant.primeryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                RatingBar.builder(
                                  glow: true,
                                  itemSize: 15,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: ColorConstant.primeryColor,
                                  ),
                                  onRatingUpdate: (rating) {},
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.productDetail.value["product"]
                                      ["name"],
                                  style: const TextStyle(
                                      color: ColorConstant.secondryColor),
                                ),
                                const Row(
                                  children: [
                                    Text('20 sold'),
                                    Divider(
                                      thickness: 1,
                                      color: ColorConstant.primeryColor,
                                      height: 20,
                                    ),
                                    Text(
                                      "In stock",
                                      style: TextStyle(
                                          color: ColorConstant.primeryColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Description",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(controller.productDetail.value["product"]
                                ["description"]),
                            Divider(
                              thickness: 1,
                              color:
                                  ColorConstant.primeryColor.withOpacity(0.2),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      controller.productDescMenu.length,
                                      (index) => GestureDetector(
                                            onTap: () async {
                                              controller.selectedIndex.value =
                                                  index;
                                              _pageController.jumpToPage(index);
                                            },
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  microseconds: 50),
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 7,
                                                  top: 7),
                                              margin: const EdgeInsets.only(
                                                  right: 7),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: controller.selectedIndex
                                                            .value ==
                                                        index
                                                    ? ColorConstant.primeryColor
                                                        .withOpacity(0.1)
                                                    : ColorConstant
                                                        .backgroundColor,
                                              ),
                                              child: Text(
                                                controller
                                                    .productDescMenu[index],
                                                style: TextStyle(
                                                    fontSize: controller
                                                                .selectedIndex
                                                                .value ==
                                                            index
                                                        ? 15
                                                        : 12,
                                                    color: controller
                                                                .selectedIndex
                                                                .value ==
                                                            index
                                                        ? ColorConstant
                                                            .primeryColor
                                                        : ColorConstant
                                                            .secondryColor
                                                            .withOpacity(0.5),
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ))),
                            ),
                            //indexed stack
                            SizedBox(
                                width: Get.width,
                                height: Get.height / 2,
                                child: PageView(
                                  controller: _pageController,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (value) {
                                    controller.selectedIndex.value = value;
                                  },
                                  children: [
                                    AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        width: Get.width,
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .productVariants.value.length,
                                          itemBuilder: (context, index) =>
                                              ListTile(
                                            leading:
                                                Obx(() => Checkbox.adaptive(
                                                      value: controller
                                                                  .selectedVariant
                                                                  .value ==
                                                              index
                                                          ? true
                                                          : false,
                                                      onChanged: (value) async {
                                                        controller
                                                            .selectedVariant
                                                            .value = index;
                                                      },
                                                    )),
                                            title: Text(controller
                                                .productVariants
                                                .value[index]["name"]),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text("Price"),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        (controller.productVariants
                                                                            .value[
                                                                        index][
                                                                    "priceWithTax"] /
                                                                100)
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: ColorConstant
                                                                .primeryColor)),
                                                    Text(
                                                      " " +
                                                          controller
                                                                  .productVariants
                                                                  .value[index]
                                                              ["currencyCode"],
                                                      style: const TextStyle(
                                                          color: ColorConstant
                                                              .primeryColor),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            trailing: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.green),
                                              child: Text(
                                                controller.productVariants
                                                    .value[index]["stockLevel"],
                                                style: const TextStyle(
                                                    color: ColorConstant
                                                        .backgroundColor),
                                              ),
                                            ),
                                          ),
                                        )),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(microseconds: 100),
                                      child: ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          ListTile(
                                              title: const Text("Category"),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    controller.category.length,
                                                    (index) => Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                                  ColorConstant
                                                                      .iconColor,
                                                            ),
                                                            Text(controller
                                                                    .category[
                                                                index]),
                                                          ],
                                                        )),
                                              )),
                                          ListTile(
                                            title: const Text("Brand"),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  controller.brand.length,
                                                  (index) => Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: ColorConstant
                                                                .iconColor,
                                                          ),
                                                          Text(controller
                                                              .brand[index]),
                                                        ],
                                                      )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(microseconds: 20),
                                      width: Get.width,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 4,
                                        itemBuilder: (context, index) =>
                                            ListTile(
                                          leading: const CircleAvatar(
                                            radius: 20,
                                          ),
                                          title: const Text("andrew"),
                                          subtitle: const Text(
                                            "review message from customer",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          trailing: Column(
                                            children: [
                                              Text(DateTime.now()
                                                  .year
                                                  .toString()),
                                              RatingBar.builder(
                                                glow: true,
                                                itemSize: 10,
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: ColorConstant
                                                      .primeryColor,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "price with tax",
                                  style:
                                      TextStyle(color: ColorConstant.iconColor),
                                ),
                                Obx(
                                  () => Text(
                                    (controller.productVariants.value[controller
                                                    .selectedVariant
                                                    .value]["priceWithTax"] /
                                                100)
                                            .toString() +
                                        controller.productVariants.value[
                                            controller.selectedVariant
                                                .value]["currencyCode"],
                                    style: const TextStyle(
                                        fontSize: 23,
                                        color: ColorConstant.primeryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  child: Mutation(
                                options: MutationOptions(
                                  document: gql(MutationAPp.addItemToOrder),
                                  onError: (error) {
                                    controller.isAddingItem.value = false;
                                  },
                                  onCompleted: (data) {
                                    if (data!.isNotEmpty) {
                                      controller.isAddingItem.value = false;
                                      print(data);
                                      Get.snackbar(
                                        data["addItemToOrder"]["lines"][0]
                                            ["productVariant"]["name"],
                                        "add to cart",
                                      );
                                    }
                                  },
                                ),
                                builder: (runMutation, result) {
                                  if (result!.isLoading) {
                                    controller.isAddingItem.value = true;
                                  }
                                  return Obx(() => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        backgroundColor:
                                            ColorConstant.primeryColor,
                                      ),
                                      onPressed: () async {
                                        runMutation({
                                          "variantId": controller.productDetail
                                                  .value["product"]["variants"][
                                              controller
                                                  .selectedVariant.value]["id"],
                                          "quantity": 1
                                        });
                                      },
                                      child:
                                          controller.isAddingItem.value == true
                                              ? WidgetConstant.spinkitLoading
                                              : const Text(
                                                  "Add To Cart",
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .backgroundColor),
                                                )));
                                },
                              ))),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ));
  }
}
