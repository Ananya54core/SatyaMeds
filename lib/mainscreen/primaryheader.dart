import 'package:flutter/material.dart';
import 'package:satyameds/mainscreen/circularcontainer.dart';
import 'package:satyameds/mainscreen/curve_edge.dart';
import 'package:satyameds/utils/constants/colors.dart';



class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key, required this.child, required this.height,
  });
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.secondaryColor,
        padding: EdgeInsets.all(0),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TcircularContainer(
                  backgroundcolor: TColors.textPrimary.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TcircularContainer(
                  backgroundcolor: TColors.textPrimary.withOpacity(0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
