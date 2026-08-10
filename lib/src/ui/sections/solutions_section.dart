import 'package:flutter/material.dart';

import '../widgets/footer_section.dart';

class SolutionsSection extends StatefulWidget {
  const SolutionsSection({super.key});

  @override
  State<SolutionsSection> createState() => _SolutionsSectionState();
}

class _SolutionsSectionState extends State<SolutionsSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [FooterSection()]));
  }
}
