import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';
import 'package:get/get.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Container(width: Get.width,height: Get.height,color: ColorConstant.backgroundColor),
          Container(
            width: Get.width,
            height: 300,
            padding:const EdgeInsets.all(15),
            decoration:const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/back.jpg"),fit: BoxFit.fill),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)
              )
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Account",style: TextStyle(color: ColorConstant.backgroundColor,fontWeight: FontWeight.bold,fontSize: 30),),
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading: CircleAvatar(radius: 30,),
                  title: Text("User Name"),
                  subtitle: Text("useremail@gmail.com"),
                  trailing: Icon(Icons.edit_note,color: ColorConstant.iconColor,),
                  titleTextStyle: TextStyle(color: ColorConstant.backgroundColor,fontSize: 20),
                  subtitleTextStyle: TextStyle(color: ColorConstant.backgroundColor),
                )
              ],
            ),
          ),
          Positioned(
             top: 200,
              left: 0,
              right: 0,
              child: Container(
                width: Get.width,
                height:Get.height,
                margin:const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Material(
                    elevation:2,
                    borderRadius: BorderRadius.circular(15),
                    child:Container(
                    width: Get.width,
                    padding:const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: ColorConstant.backgroundColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                      child: const Column(
                        children: [
                          ListTile(leading: Icon(Icons.location_pin),title: Text("Shipping Address"),),
                          ListTile(leading: Icon(Icons.payment),title: Text("Payment Method"),),
                          ListTile(leading: Icon(Icons.history),title: Text("Order History"),),
                          ListTile(leading: Icon(Icons.delivery_dining),title: Text("Delivery Status"),),
                          ListTile(leading: Icon(Icons.favorite_border),title: Text("Favorite"),),
                          ListTile(leading: Icon(Icons.privacy_tip_outlined),title: Text("Privacy Policy"),),
                          ListTile(leading: Icon(Icons.question_mark),title: Text("Frequently Asked Questions "),),
                          ListTile(leading: Icon(Icons.star_rate_outlined),title: Text("Rate Our App"),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.logout),
                      Text("LogOut")
                    ],)
                  ],
                ),
              ),
              )
        ],
      )
    );
  }
}
