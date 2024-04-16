import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/colorConstant.dart';
import 'package:flutter_vendure_stor/app/modules/account/views/account_view.dart';
import 'package:flutter_vendure_stor/app/modules/cart/views/cart_view.dart';
import 'package:flutter_vendure_stor/app/modules/favorite/views/favorite_view.dart';
import 'package:flutter_vendure_stor/app/modules/home/views/home_dashbord_view.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   HomeView({Key? key}) : super(key: key);
   final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         bottomNavigationBar:
      // Container(
        //   width: Get.width,
        //   margin:const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10)
        //   ),
        //   child:Obx(() =>ClipRRect(
        //       borderRadius: BorderRadius.circular(10),
        //       child: NavigationBar(
        //         selectedIndex: controller.intialPage.value,
        //         indicatorColor: ColorConstant.primeryColor,
        //         destinations:[
        //           NavigationDestination(icon: Icon(Icons.home,color: controller.intialPage.value==0?ColorConstant.backgroundColor:ColorConstant.secondryColor,), label:"Home"),
        //           NavigationDestination(icon: Icon(Icons.favorite,color: controller.intialPage.value==1?ColorConstant.backgroundColor:ColorConstant.secondryColor,), label:"Favorite"),
        //           NavigationDestination(icon: Badge(
        //               alignment: Alignment.topRight,
        //                       backgroundColor: Colors.deepOrange,
        //                       smallSize: 30,
        //                       label: Text("3"),
        //               child: Icon(Icons.shopping_cart,color: controller.intialPage.value==2?ColorConstant.backgroundColor:ColorConstant.secondryColor,)), label:"Cart"),
        //           NavigationDestination(icon: Icon(Icons.person,color: controller.intialPage.value==3?ColorConstant.backgroundColor:ColorConstant.secondryColor,), label:"Account"),
        //       ],
        //         onDestinationSelected: (value) async{
        //              controller.intialPage.value=value;
        //              _pageController.jumpToPage(value);
        //         },
        //     ),
        //   ),
        //   )
        // ),
         Obx(() =>CurvedNavigationBar(
          height:57,
          key: _bottomNavigationKey,
          index: controller.intialPage.value,
          backgroundColor: ColorConstant.backgroundColor,
          buttonBackgroundColor: ColorConstant.primeryColor,
          color: ColorConstant.primeryColor,
          items:const[
            Icon(Icons.home, size:25,color: ColorConstant.backgroundColor,),
            Icon(Icons.favorite, size: 25,color: ColorConstant.backgroundColor,),
            Badge(
                alignment: Alignment.topRight,
                backgroundColor: Colors.deepOrange,
                smallSize: 30,
               // offset: Offset(5, -3),
                label: Text("3"),
                child: Icon(
                  Icons.shopping_cart,
                  size: 25,color: ColorConstant.backgroundColor,
                )),
            Icon(Icons.person, size: 25,color: ColorConstant.backgroundColor,)
          ],
          onTap: (index) {
           controller.intialPage.value=index;
           _pageController.jumpToPage(index);
          },
        ),),
        body:
            PageView(
             controller:_pageController,
             physics:const NeverScrollableScrollPhysics(),
             children:[
               HomeDashbordView(),
               FavoriteView(),
               CartView(),
               AccountView()
          ],

      )


    );
  }
}