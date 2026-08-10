import 'package:flutter/material.dart';

import '../widgets/footer_section.dart';

class ManufacturingSection extends StatefulWidget {
  const ManufacturingSection({super.key});

  @override
  State<ManufacturingSection> createState() => _ManufacturingSectionState();
}

class _ManufacturingSectionState extends State<ManufacturingSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [FooterSection()]));
  }
}
