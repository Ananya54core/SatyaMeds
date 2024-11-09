import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:satyameds/utils/constants/text_sizes.dart';

class TRoundImage extends StatelessWidget {
  const TRoundImage({
    super.key, this.width, this.height, required this.imageurl, this.applyImageRadius=true, this.border, this.background, this.fit=BoxFit.contain, this.isImagenetwork=false, this.onPressed, this.padding,  this.borderradius=TextSizes.md, this.overlay,
  });
  final double?width;
  final double? height;
  final String imageurl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? background;
  final BoxFit? fit;
  final bool isImagenetwork;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double borderradius;
  final Color? overlay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: background,
          borderRadius: BorderRadius.circular(borderradius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius? BorderRadius.circular(TextSizes.md):BorderRadius.zero,
          child: Image(
            fit: fit,
            image: isImagenetwork? NetworkImage(imageurl):AssetImage(imageurl)as ImageProvider,

          ),
        ),
      ),
    );
  }
}

