import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';
import 'package:flutter_vendure_stor/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/status_controller.dart';

class StatusView extends GetView<StatusController> {
  const StatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed:() => Get.offAllNamed(Routes.HOME), icon:const Icon(Icons.arrow_back_ios,color: ColorConstant.iconColor,)),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Padding(
            padding:EdgeInsets.only(left: 15),
            child:Text("Order Status",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24),),
          ),
          Expanded(child:ListView(
            padding:const EdgeInsets.all(15),
            children: [
              //time line
              //  Timeline.tileBuilder(
              //     builder: TimelineTileBuilder.fromStyle(
              //       contentsAlign: ContentsAlign.alternating,
              //       contentsBuilder: (context, index) => Padding(
              //         padding: const EdgeInsets.all(24.0),
              //         child: Text('Timeline Event $index'),
              //       ),
              //       itemCount:4,
              //     ),
              //   ),

            ],
          )),
          Container(
            width: Get.width,
            padding:const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: ColorConstant.backgroundColor,
                        side:const BorderSide(color: ColorConstant.primeryColor)
                      ),
                        onPressed:() {}, child:const Text("Cancel Order")),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(onPressed:() {}, child:const Text("Message",style: TextStyle(color: ColorConstant.backgroundColor),)),
                  ),
                ),
              ],
            ),
          )

        ],
      )
    );
  }
}
