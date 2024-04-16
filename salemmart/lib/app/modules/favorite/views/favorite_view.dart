import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colorConstant.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('My Favorite'),
        centerTitle: false,
        titleTextStyle:const TextStyle(fontSize: 27,color: Colors.black),
      ),
      body:Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: GridView.builder(

            padding: const EdgeInsets.only(left:15,top: 10,right: 15),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
            itemCount:8,
            itemBuilder:(context, index) =>const ProductCard() ,),
      )
    );
  }
}


class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2 - 20,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:Stack(
          children: [
             ClipRRect(
          borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
            child: CachedNetworkImage(
             imageUrl:"https://images.unsplash.com/photo-1605348532760-6753d2c43329?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
             placeholder: (context, url) => const Icon(
             Icons.image,
             color: ColorConstant.iconColor,
           ),
             errorWidget: (context, url, error) => const Icon(Icons.error),
             fit: BoxFit.cover,
             width: Get.width,
             height:150,
    ),
    ),
             const Positioned(
            top: 3,
              right: 5,
              child:Icon(Icons.delete,color: ColorConstant.iconColor,))
        ],
      )

          ),
          const Padding(
            padding:  EdgeInsets.only(left: 10, top: 3, right: 10),
            child:Text("smart watch",style: TextStyle(
                      fontSize:15,
                      color: ColorConstant.secondryColor,
                      fontWeight: FontWeight.w200),)
          ),
          Padding(
            padding:const EdgeInsets.only(left: 10, top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "\$234",
                  style: TextStyle(
                      fontSize:15,
                      color: ColorConstant.secondryColor,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: ColorConstant.primeryColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        Text(
                          "3.5",
                          style: TextStyle(
                              fontSize: 11,
                              color: ColorConstant.backgroundColor),
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

        ],
      ),
    );
  }
}