
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satyameds/mainscreen/circularcontainer.dart';
import 'package:satyameds/mainscreen/curve_edge.dart';
import 'package:satyameds/mainscreen/homecontroller.dart';
import 'package:satyameds/utils/constants/text_sizes.dart';
import 'Troundimage.dart';



class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key, required this.banners,
  });
  final List<String> banners;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index,_)=> controller.updatePageIndicator(index)
            ),
            items: banners.map((url) => TRoundImage(imageurl:url)).toList()
        ),
        const SizedBox(height: TextSizes.spaceBtwItems,),
        Center(
          child: Obx(
                ()=> Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for(int i=0;i<banners.length;i++)
                  TcircularContainer(
                    width: 20,
                    height: 4,
                    margin: EdgeInsets.only(right:10),
                    backgroundcolor: controller.CarousalCurrentIndex.value==i?Colors.indigoAccent:Colors.grey,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
