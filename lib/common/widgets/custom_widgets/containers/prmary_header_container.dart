import 'package:karconnect/common/widgets/custom_widgets/containers/circular_container.dart';
import 'package:karconnect/common/widgets/custom_widgets/curved_edges/curved_edges_widget.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 400,
          //if size.infinite is not true in stack arror occured
          child: Stack(
            children: [
              Positioned(
                  right: -250,
                  top: -150,
                  child: TCircularContainer(
                    backgroundColor: TColors.textwhite.withOpacity(0.1),
                  )),
              Positioned(
                  right: -300,
                  top: 100,
                  child: TCircularContainer(
                    backgroundColor: TColors.textwhite.withOpacity(0.1),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
