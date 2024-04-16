import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';
import 'package:flutter_vendure_stor/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/getstarted_controller.dart';

class GetstartedView extends GetView<GetstartedController> {
  const GetstartedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("SalemMart",style: TextStyle(fontWeight: FontWeight.bold,color: ColorConstant.primeryColor,fontSize: 26,letterSpacing: 10),),
            const Image(image:AssetImage("assets/images/getstarted.png")),
            SizedBox(
              width: Get.width,
              child: ElevatedButton(onPressed:() => Get.offAllNamed(Routes.HOME), child: const Text("Take a look",style: TextStyle(color: Colors.white),)),
            ),
            const SizedBox(height: 25,),
            InkWell(
              onTap: () => Get.toNamed(Routes.AUTH),
                child: const Text("SIGN IN",style: TextStyle(fontWeight: FontWeight.bold,color: ColorConstant.primeryColor)))
          ],
        ),
      )
    );
  }
}
