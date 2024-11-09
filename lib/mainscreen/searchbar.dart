import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:satyameds/utils/constants/colors.dart';
import 'package:satyameds/utils/constants/helperfunctions.dart';
import 'package:satyameds/utils/constants/text_sizes.dart';
import 'package:satyameds/utils/theme/device_utility.dart';


class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    Key? key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TextSizes.defaultSpace), this.borderColor,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final bool showBackground;
  final bool showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TextSizes.md),
          decoration: BoxDecoration(
            color: showBackground ? (dark ? TColors.light : TColors.light) : Colors.transparent,
            borderRadius: BorderRadius.circular(TextSizes.spaceBtwItems),
            border: showBorder ? Border.all(color: borderColor ?? TColors.darkgrey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: TColors.darkgrey),
              const SizedBox(width: TextSizes.spaceBtwItems),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall ?? TextStyle(),
                // Ensure TextStyle is not null
              ),
            ],
          ),
        ),
      ),
    );
  }
}
