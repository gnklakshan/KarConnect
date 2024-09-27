import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TRentOwnerDetailsTab extends StatelessWidget {
  final String owner;
  const TRentOwnerDetailsTab(
    this.owner, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(108, 224, 224, 224), width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Row(
              children: [
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),
                //rating
                const Icon(
                  Iconsax.people,
                  color: TColors.primary,
                  size: 24,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),
                SafeArea(
                  child: Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: owner.length > 15
                            ? owner.substring(0, 15) + '...'
                            : owner,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      // const TextSpan(text: "  (258)"),
                    ],
                  )),
                )
                //share
              ],
            ),
          ),
          // const SizedBox(
          //   width: TSizes.spaceBtwItems * 5,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.message_outlined,
                    size: TSizes.iconMd,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.call_end_outlined,
                    size: TSizes.iconMd,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
