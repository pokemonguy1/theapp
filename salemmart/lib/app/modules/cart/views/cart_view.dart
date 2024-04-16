import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';
import 'package:flutter_vendure_stor/app/constants/widgetConstant.dart';
import 'package:flutter_vendure_stor/app/data/query/query.dart';
import 'package:flutter_vendure_stor/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorConstant.iconColor,
              )),
          title: const Text(
            'Cart',
            style: TextStyle(fontSize: 27),
          ),
          centerTitle: false,
          elevation: 0,
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
        ),
        body: Query(
          options: QueryOptions(document: gql(QueryApp.activeOrder)),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
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
              print(result.data);
              return const Center(
                child: Text("empty cart"),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    itemCount: 2,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key(index.toString()),
                      background: const Icon(Icons.delete),
                      secondaryBackground: const Icon(Icons.delete),
                      direction: DismissDirection.endToStart,
                      // this will only allow slide to left.
                      onDismissed: (direction) => {},
                      child: Card(
                        elevation: 15,
                        surfaceTintColor: ColorConstant.backgroundColor,
                        shadowColor:
                            ColorConstant.primeryColor.withOpacity(0.6),
                        child: SizedBox(
                            width: Get.width,
                            height: 100,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1605348532760-6753d2c43329?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                    placeholder: (context, url) => const Icon(
                                      Icons.image,
                                      color: ColorConstant.iconColor,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text(""),
                                        subtitle: Text(
                                            "description about the product"),
                                        subtitleTextStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 5),
                                      child: Text(
                                        "\$345.00",
                                        style: TextStyle(
                                            color: ColorConstant.primeryColor
                                                .withOpacity(0.9),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: ColorConstant.iconColor,
                                    ),
                                    Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: const Border.fromBorderSide(
                                                BorderSide(
                                                    width: 1,
                                                    color: ColorConstant
                                                        .primeryColor))),
                                        child: const Center(
                                            child: Text(
                                          "3",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))),
                                    const Icon(
                                      Icons.minimize,
                                      color: ColorConstant.iconColor,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: Get.width,
                  //  height: 200,
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 25),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Divider(
                          thickness: 0.7,
                          color: ColorConstant.primeryColor.withOpacity(0.9),
                        ),
                      ),
                      //promo
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(fontSize: 12),
                              cursorColor: ColorConstant.primeryColor,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorConstant.primeryColor
                                      .withOpacity(0.2),
                                  hintText: "promo code hear",
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  border: Border.fromBorderSide(BorderSide(
                                      width: 1,
                                      color: ColorConstant.primeryColor))),
                              child: const Text("Apply"))
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$0.0"),
                            Row(
                              children: [
                                Text("Delivery type"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Normal")
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: ColorConstant.iconColor),
                              ),
                              Text(
                                "\$234.00",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: () => Get.toNamed(Routes.CHEEKOUT),
                                  child: const Text(
                                    "CheckOut",
                                    style: TextStyle(
                                        color: ColorConstant.backgroundColor),
                                  ))),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
