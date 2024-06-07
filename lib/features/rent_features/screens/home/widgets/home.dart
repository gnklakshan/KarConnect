import 'package:karconnect/common/widgets/custom_widgets/containers/prmary_header_container.dart';
import 'package:karconnect/common/widgets/custom_widgets/containers/circular_container.dart';
import 'package:karconnect/common/widgets/custom_widgets/curved_edges/curved_edges.dart';
import 'package:karconnect/common/widgets/custom_widgets/curved_edges/curved_edges_widget.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
