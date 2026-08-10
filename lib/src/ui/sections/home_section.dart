import 'package:flutter/material.dart';

import '../widgets/footer_section.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [FooterSection()]));
  }
}
