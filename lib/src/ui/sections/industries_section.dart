import 'package:flutter/material.dart';

import '../widgets/footer_section.dart';

class IndustriesSection extends StatefulWidget {
  const IndustriesSection({super.key});

  @override
  State<IndustriesSection> createState() => _IndustriesSectionState();
}

class _IndustriesSectionState extends State<IndustriesSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [FooterSection()]));
  }
}
