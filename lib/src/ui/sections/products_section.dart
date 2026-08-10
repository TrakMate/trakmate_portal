import 'package:flutter/material.dart';

import '../widgets/footer_section.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [FooterSection()]));
  }
}
