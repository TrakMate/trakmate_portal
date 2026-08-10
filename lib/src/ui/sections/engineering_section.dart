import 'package:flutter/material.dart';

import '../widgets/footer_section.dart';

class EngineeringSection extends StatefulWidget {
  const EngineeringSection({super.key});

  @override
  State<EngineeringSection> createState() => _EngineeringSectionState();
}

class _EngineeringSectionState extends State<EngineeringSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [FooterSection()]));
  }
}
