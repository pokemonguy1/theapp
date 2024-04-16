import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_vendure_stor/app/modules/home/views/widgets/categoryShimmer.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../constants/colorConstant.dart';
import '../../../constants/widgetConstant.dart';
import '../../../data/query/query.dart';
import '../../../routes/app_pages.dart';

class HomeDashbordView extends GetView<HomeController> {
  const HomeDashbordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
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
          child: GestureDetector(
            onTap: () => Get.toNamed(Routes.SEARCH_PRODUCT),
            child: TextField(
              autofocus: false,
              enabled: false,
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
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        padding: const EdgeInsets.all(15),
        addAutomaticKeepAlives: true,
        children: [
          const Text(
            "New Arrival",
            style: TextStyle(
              color: ColorConstant.secondryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const HomePageCarousel(),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  4,
                  (index) => Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: const BoxDecoration(
                            color: ColorConstant.primeryColor,
                            shape: BoxShape.circle),
                      )),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Categories",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.secondryColor),
                ),
              ),
              GestureDetector(
                  onTap: () => Get.toNamed(Routes.CATEGORIES),
                  child: const Row(
                    children: [
                      Text(
                        "view all",
                        style: TextStyle(color: ColorConstant.secondryColor),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: ColorConstant.iconColor,
                      )
                    ],
                  ))
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Query(
            options: QueryOptions(document: gql(QueryApp.allhomeCategory)),
            builder: (result, {fetchMore, refetch}) {
              if (result.hasException) {
                return SizedBox(
                  width: Get.width,
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        List.generate(5, (index) => const CategoryShimmer()),
                  ),
                );
              }
              if (result.isLoading) {
                return SizedBox(
                  width: Get.width,
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        List.generate(5, (index) => const CategoryShimmer()),
                  ),
                );
              }
              if (result.data!.isNotEmpty) {
                controller.allCategories.value =
                    result.data!["collections"]["items"];
              }
              return SizedBox(
                width: Get.width,
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: result.data!["collections"]["totalItems"],
                  itemBuilder: (context, index) =>
                      CategoryCard(category: controller.allCategories[index]),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Exclusive deal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.secondryColor),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Query(
            options: QueryOptions(document: gql(QueryApp.homeProducts)),
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
                controller.allproducts.value = result.data!;
              }
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 260,
                    mainAxisSpacing: 10),
                itemCount: controller.allproducts["search"]["items"].length,
                itemBuilder: (context, index) => ProductCard(
                    product: controller.allproducts["search"]["items"][index],
                    key: Key(index.toString())),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Stack(
          children: [
            InkWell(
              onTap: () =>
                  Get.toNamed(Routes.PRODUCT, arguments: product["slug"]),
              child: Hero(
                tag: product["slug"],
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: product["productAsset"]["preview"],
                    placeholder: (context, url) => const Icon(
                      Icons.image,
                      color: ColorConstant.iconColor,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: Get.width,
                    height: 140,
                  ),
                ),
              ),
            ),
            const Positioned(
                right: 6,
                top: 3,
                child: Icon(
                  Icons.favorite_border,
                  color: ColorConstant.iconColor,
                ))
          ],
        )),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 1),
          child: Row(
            children: [
              Text(
                product["priceWithTax"]["min"].toString(),
                style: const TextStyle(
                  color: ColorConstant.secondryColor,
                ),
              ),
              const Text("-"),
              Text(
                product["priceWithTax"]["max"].toString(),
                style: const TextStyle(
                  color: ColorConstant.secondryColor,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 3, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product["productName"],
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15,
                      color: ColorConstant.secondryColor,
                      fontWeight: FontWeight.w200),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: ColorConstant.primeryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                    children: [
                      Text(
                        "3.5",
                        style: TextStyle(
                            fontSize: 11, color: ColorConstant.backgroundColor),
                      ),
                      Icon(
                        Icons.star,
                        color: ColorConstant.backgroundColor,
                        size: 10,
                      )
                    ],
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: Get.width,
            child: ElevatedButton(
                onPressed: () => Get.snackbar("Add to cart", "item to cart"),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.all(1),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ))),
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(color: ColorConstant.backgroundColor),
                )))
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key(category['name']),
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        Get.toNamed(Routes.CATEGORIEDETAIL, arguments: category);
      },
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: ColorConstant.primeryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: category["featuredAsset"]["preview"],
                placeholder: (context, url) => const Icon(
                  Icons.image,
                  color: ColorConstant.iconColor,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: ColorConstant.backgroundColor.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Text(
                  category["name"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, color: ColorConstant.secondryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePageCarousel extends StatelessWidget {
  const HomePageCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              placeholder: (context, url) => const Icon(
                Icons.image,
                color: ColorConstant.iconColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: Get.width,
            ),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
          ),
          Positioned(
            top: 5,
            left: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Super flash sale",
                  style: TextStyle(
                      fontSize: 25, color: ColorConstant.backgroundColor),
                ),
                const Text(
                  "50% Off",
                  style: TextStyle(
                      fontSize: 20, color: ColorConstant.backgroundColor),
                ),
                Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: ColorConstant.backgroundColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Text(
                      "see more",
                      style: TextStyle(fontSize: 11),
                    ))
              ],
            ),
          )
        ],
      ),
      options: CarouselOptions(
          height: 130,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal),
    );
  }
}
