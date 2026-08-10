import 'package:flutter/material.dart';

import '../widgets/footer_section.dart';

class ResourcesSection extends StatefulWidget {
  const ResourcesSection({super.key});

  @override
  State<ResourcesSection> createState() => _ResourcesSectionState();
}

class _ResourcesSectionState extends State<ResourcesSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [FooterSection()]));
  }
}
