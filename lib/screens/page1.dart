import 'package:doorcode_nfc/components/carousel.dart';
import 'package:flutter/material.dart';
import 'package:doorcode_nfc/components/customAppbar.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(children: [Carousel()],)
    );
  }
}
