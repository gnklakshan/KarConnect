// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TBrandTitleText extends StatelessWidget {
//   const TBrandTitleText({
//     super.key,
//     required this.title,
//     this.maxLines = 1,
//     this.color,
//     this.textAlign = TextAlign.center,
//     this.brandTextSize = TextSizes.small,
//   });

//   final Color? color;
//   final String title;
//   final int maxLines;
//   final TextAlign? textAlign;
//   final TextSizes brandTextSIze;

//   @override
//   Widget build(BuildContext context) {
//     return Text(title,
//         textAlign: textAlign,
//         overflow: TextOverflow.ellipsis,
//         style: brandTextSIze == TextSizes.small
//             ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
//             : brandTextSIze == TextSizes.medium
//                 ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
//                 : brandTextSIze == TextSizes.large
//                     ? Theme.of(context)
//                         .textTheme
//                         .titleLarge!
//                         .apply(color: color)
//                     : Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .apply(color: color));
//   }
// }
