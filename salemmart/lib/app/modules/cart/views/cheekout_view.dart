import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class CheekOutView extends GetView {
  const CheekOutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text("CheekOut",style: TextStyle(fontSize: 23),),
        scrolledUnderElevation: 0,
        leading: IconButton(onPressed:() {Get.back();}, icon:const Icon(Icons.arrow_back_ios,color: ColorConstant.iconColor,),),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SizedBox(
            width: Get.width,
            child: ListView(
              padding:const EdgeInsets.all(15),
              children: [
                 const Text("Shipping Address",style: TextStyle(fontWeight: FontWeight.normal),),
                 Material(
                   elevation:10,
                   shadowColor: ColorConstant.primeryColor.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(10),
                   child: Container(
                     width: Get.width,
                     height: 140,
                     padding:const EdgeInsets.all(15),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: ListTile(
                       title: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                         const Text("full name",style: TextStyle(color: ColorConstant.secondryColor,fontWeight: FontWeight.w600),),
                           Container(
                               width: 30,
                               height: 30,
                               decoration:const BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: ColorConstant.iconColor
                               ),
                               child:const Center(child: Icon(Icons.edit,color: ColorConstant.backgroundColor,size:20,))
                           ),
                         ],
                       ),
                       subtitle:const Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("23wes,sub Street",style: TextStyle(color: ColorConstant.secondryColor),),
                           Text("phone,",style: TextStyle(color: ColorConstant.secondryColor),),
                           Text("City name,province CCountry",style: TextStyle(color: ColorConstant.secondryColor),),
                   
                         ],
                       ),
                   
                     ),
                   
                   ),
                 ),
                 const SizedBox(height: 15,), const Text("Shipping Method",style: TextStyle(fontWeight: FontWeight.normal),),
                 Material(
                   elevation:10,
                   shadowColor: ColorConstant.primeryColor.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(10),
                   child: Container(
                     width: Get.width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child:Column(
                       children: [
                         ListTile(
                           leading:Radio.adaptive(value:true, groupValue:true, onChanged:(value) {},activeColor: ColorConstant.primeryColor),
                           title:const Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("shipping method 1"),
                               Text("\$23",style: TextStyle(color: ColorConstant.primeryColor),),
                             ],
                           ),
                           titleTextStyle:const TextStyle(fontSize: 14,color: ColorConstant.secondryColor),
                         ),
                         ListTile(
                           leading:Radio.adaptive(value:true, groupValue:true, onChanged:(value) {},activeColor: ColorConstant.primeryColor,),
                           title:const Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                Text("shipping method 2"),
                               Text("\$53",style: TextStyle(color: ColorConstant.primeryColor),),
                             ],
                           ),
                           titleTextStyle:const TextStyle(fontSize: 14,color: ColorConstant.secondryColor),

                         ),
                         ListTile(
                           leading:Radio.adaptive(value:true, groupValue:true, onChanged:(value) {},activeColor: ColorConstant.primeryColor,),
                           title:const Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                Text("shipping method 2"),
                               Text("\$23",style: TextStyle(color: ColorConstant.primeryColor),),
                             ],
                           ),
                           titleTextStyle:const TextStyle(fontSize: 14,color: ColorConstant.secondryColor),

                         )
                       ],
                     )

                   ),
                 ),
                 const SizedBox(height: 15,),
                 const Text("Payment Method",style: TextStyle(fontWeight: FontWeight.normal),),
                 Material(
                  elevation: 4,
                  shadowColor: ColorConstant.primeryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                    width: Get.width,
                    height: 100,
                    padding:const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:ListTile(
                      leading:Hero(
                        tag: "pay",
                          child: Icon(Icons.payment_outlined,color: ColorConstant.primeryColor.withOpacity(0.8),size: 35,)),
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("CBE"),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.PAYMENTMETHOD),
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration:const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstant.iconColor
                                ),
                                child:const Center(child: Icon(Icons.edit,color: ColorConstant.backgroundColor,size:20,))
                            ),
                          ),
                        ],
                      ),
                      subtitle:const Text("*********54",style: TextStyle(color: ColorConstant.iconColor),),
                    )
                  ),
                ),
                const SizedBox(height: 20,),
                //items
                Row(
                  children: [
                    const Text("Items",style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    Container(
                      width:20,
                      height:20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.primeryColor.withOpacity(0.5),
                      ),
                      child:const Center(child: Text("3",style: TextStyle(color: ColorConstant.backgroundColor),)),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                SizedBox(
                    width: Get.width,
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder:(context, index) => Container(
                          width: 100,
                          height: 100,
                          margin:const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "https://images.unsplash.com/photo-1605348532760-6753d2c43329?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  placeholder: (context, url) => const Icon(
                                    Icons.image,
                                    color: ColorConstant.iconColor,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width:100,
                                  height:80,
                                ),
                              ),
                              const Text("Nike jordan",style: TextStyle(fontSize: 12),)

                            ],
                          )
                        ),
                    ),
                  ),


              ],
            ),

          )),
          Container(
            width: Get.width,
            padding:const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total",style: TextStyle(fontSize: 13,color: ColorConstant.iconColor),),
                    Text("\$234.00",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(onPressed:(){Get.toNamed(Routes.STATUS);}, child:const Text("Place Order",style: TextStyle(color: ColorConstant.backgroundColor),))),
              ],
            ),
          )
        ],
      )
    );
  }
}
