import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';

import 'package:get/get.dart';

class PaymentMethodView extends GetView {
  const PaymentMethodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(onPressed:() => Get.back(), icon:const Icon(Icons.arrow_back_ios,color: ColorConstant.iconColor,)),
      ),
      body:ListView(
        padding:const EdgeInsets.all(15),
        children:const [
           Text('Payment Methods',style: TextStyle(fontSize: 24,color: ColorConstant.secondryColor),),

        ],
      )


    );
  }
}
