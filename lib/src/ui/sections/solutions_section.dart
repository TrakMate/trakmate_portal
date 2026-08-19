import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class SolutionsSection extends StatefulWidget {
  final ValueChanged<int>? onNavigate;

  const SolutionsSection({super.key, this.onNavigate});

  @override
  State<SolutionsSection> createState() => _SolutionsSectionState();
}

class _SolutionsSectionState extends State<SolutionsSection> {
  static const double _solutionCardHeight = 400;
  static const double _solutionCard = 400;
  static const double _solutionCardImageHeight = 200;
  static const double _solutionCardContentPadding = 20;
  static const double _solutionCardSpacing = 10;

  int? _hoveredSolutionIndex;

  final List<_SolutionCardData> _solutions = const [
    _SolutionCardData(
      title: 'IoT Solutions',
      description:
          'Connected solutions designed to improve visibility, efficiency and control.',
      image: 'images/iotsolution.png',
      features: [
        'IoT Device Design & Development',
        'Connectivity & Protocols',
        'Device Management Platform',
      ],
    ),
    _SolutionCardData(
      title: 'Embedded Systems',
      description:
          'Intelligent embedded solutions built for reliable performance and control.',
      image: 'images/embedded_systems.jpg',
      features: [
        'Firmware Development',
        'Sensor Integration',
        'Embedded Hardware Design',
      ],
    ),
    _SolutionCardData(
      title: 'Software Developments',
      description:
          'Scalable software solutions designed for seamless performance and growth.',
      image: 'images/softdev.jpg',
      features: [
        'Custom Software Solutions',
        'API & Backend Development',
        // 'System Integration',
      ],
    ),
    _SolutionCardData(
      title: 'Cloud & AI',
      description:
          'Smart cloud and AI solutions that turn data into actionable insights.',
      image: 'images/cloudai.jpg',
      features: [
        'Cloud Infrastructure Setup',
        'AI Model Development',
        'Intelligent Data Analytics',
      ],
    ),
    _SolutionCardData(
      title: 'Mobile Apps',
      description:
          'User-friendly mobile applications built for seamless digital experiences..',
      image: 'images/mobileapps.jpg',
      features: [
        'Cross-Platform Development',
        'Mobile UI/UX Design',
        'App API Integration',
      ],
    ),
    _SolutionCardData(
      title: 'Web Applications',
      description:
          'Powerful web applications designed for efficiency, accessibility, and growth.',
      image: 'images/webapps.jpg',
      features: [
        'Responsive Web Development',
        'Web Portal Development',
        'API & Database Integration',
      ],
    ),
  ];

  final List<_IndustryData> _industries = const [
    _IndustryData(icon: 'icons/truck.svg', label: 'Fleet & Logistics'),
    _IndustryData(icon: 'icons/city.svg', label: 'Smart Cities'),
    _IndustryData(icon: 'icons/automation.svg', label: 'Industrial Automation'),
    _IndustryData(icon: 'icons/utilities.svg', label: 'Energy & Utilities'),
    _IndustryData(icon: 'icons/agriculture.svg', label: 'Agriculture'),
    _IndustryData(icon: 'icons/healthcare.svg', label: 'Healthcare'),
    _IndustryData(icon: 'icons/retail.svg', label: 'Retail'),
    _IndustryData(icon: 'icons/andmore.svg', label: 'And More'),
  ];

  final List<_ApproachStepData> _approachSteps = const [
    _ApproachStepData(
      number: '01',
      title: 'Discover',
      description: 'We understand your challenges, goals and requirements.',
    ),
    _ApproachStepData(
      number: '02',
      title: 'Design',
      description: 'We architect the right solutions tailored to your needs.',
    ),
    _ApproachStepData(
      number: '03',
      title: 'Develop',
      description:
          'We build, test and integrate with precision and best practices.',
    ),
    _ApproachStepData(
      number: '04',
      title: 'Deploy',
      description: 'We ensure smooth implementation and seamless integration.',
    ),
    _ApproachStepData(
      number: '05',
      title: 'Support',
      description: 'We provide ongoing support and continuous improvement.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSolutionsHeader(),

          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildComprehensiveSolutionsSection(),
          ),

          const SizedBox(height: 45),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildIndustriesSection(),
          ),
          const SizedBox(height: 45),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildApproachSection(),
          ),
          const SizedBox(height: 40),

          FooterSection(),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildSolutionsHeader() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SOLUTIONS',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: tOrange1,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 20),

                RichText(
                  text: TextSpan(
                    style: GoogleFonts.manrope(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: tWhite,
                    ),
                    children: [
                      const TextSpan(text: 'Intelligent Solutions.\n'),
                      TextSpan(
                        text: 'Real-World Impact.',
                        style: TextStyle(
                          color: tOrange1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'We design and deliver innovative IoT, embedded and software solutions that help businesses automate operations, gain insights and accelerate growth.',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: tWhite,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  children: [
                    Expanded(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/globe.svg',
                        title: 'End-to-End Expertise',
                        description:
                            'Covering every stage from idea to deployment',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/secured.svg',
                        title: 'Scalable & Secure',
                        description: 'Built to grow safely with your business',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/future.svg',
                        title: 'Future-Ready Tech',
                        description: 'Designed to adapt as your needs evolve',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildHeaderIntroCard(
                        icon: 'icons/globe.svg',
                        title: 'Reliable Support',
                        description: 'Here for you at every step of the way',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          Expanded(
            flex: 4,
            child: Container(
              height: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: tBlack.withOpacity(0.25),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'images/company.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: tBlack.withOpacity(0.05),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: tWhite.withOpacity(0.6),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 30, height: 30, color: tOrange1),
        const SizedBox(height: 10),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            color: tWhite,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            color: tWhite.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildComprehensiveSolutionsSection() {
    return Column(
      children: [
        Text(
          'OUR SOLUTIONS',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Comprehensive Solutions for Every Need',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        SizedBox(
          width: double.infinity,
          child: Text(
            'From connected devices to powerful software platforms, we deliver solutions that are reliable, scalable and tailored to your business goals.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: tBlack,
              height: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 35),

        LayoutBuilder(
          builder: (context, constraints) {
            const crossAxisCount = 6; // all 6 cards in one row
            const spacing = 10.0;
            final cardWidth =
                (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                crossAxisCount;

            return Row(
              children: List.generate(_solutions.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index != _solutions.length - 1 ? spacing : 0,
                    ),
                    child: _buildSolutionCard(_solutions[index], index),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  // SOLUTION CARD
  Widget _buildSolutionCard(_SolutionCardData data, int index) {
    final bool isHovered = _hoveredSolutionIndex == index;

    final double scale = isHovered ? 1.04 : 1.0;
    final double blurRadius = isHovered ? 24 : 16;
    final double spreadRadius = isHovered ? 1 : 0;
    final double borderWidth = isHovered ? 1.3 : 1;

    final Color borderColor =
        isHovered ? tOrange1.withOpacity(0.45) : tBlack1.withOpacity(0.08);

    final Color shadowColor =
        isHovered ? tOrange1.withOpacity(0.16) : tBlack.withOpacity(0.28);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredSolutionIndex = index),
      onExit: (_) => setState(() => _hoveredSolutionIndex = null),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: double.infinity,
          height: _solutionCardHeight,
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: _solutionCardImageHeight,
                child: Image.asset(
                  data.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: tBlack.withOpacity(0.05),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: tBlack.withOpacity(0.3),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(_solutionCardContentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: tBlack,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 2,
                        decoration: BoxDecoration(color: tOrange1),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        data.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: tBlack.withOpacity(0.6),
                          height: 1.45,
                        ),
                      ),

                      const SizedBox(height: 14),

                      ...data.features.map(
                        (feature) =>
                            _buildFeatureItem(feature, textColor: tBlack),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FEATURE ITEM
  Widget _buildFeatureItem(String text, {required Color textColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 1),
            decoration: const BoxDecoration(
              color: tOrange1,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 10, color: Colors.white),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // INDUSTRIES
  Widget _buildIndustriesSection() {
    return Column(
      children: [
        Text(
          'INDUSTRIES WE EMPOWER',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Solutions for a Smarter Tomorrow',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 30),

        Row(
          children: [
            for (int i = 0; i < _industries.length; i++) ...[
              Expanded(
                child: Center(child: _buildIndustryItem(_industries[i])),
              ),

              if (i < _industries.length - 1)
                Container(
                  width: 1,
                  height: 42,
                  color: tBlack1.withOpacity(0.15),
                ),
            ],
          ],
        ),
        const SizedBox(height: 30),

        OutlinedButton(
          onPressed: () => widget.onNavigate?.call(5),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: tBlue3, width: 1.2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'View All Industries',
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tBlue3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndustryItem(_IndustryData data) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: tBlue1.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              data.icon,
              width: 24,
              height: 24,
              color: tBlue3,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          data.label,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: tBlack.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  Widget _buildApproachSection() {
    return Column(
      children: [
        Text(
          'OUR APPROACH',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'How We Deliver Solutions That Make a Difference',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 35),

        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < _approachSteps.length; i++) ...[
                Expanded(child: _buildApproachStepCard(_approachSteps[i])),

                if (i < _approachSteps.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: SvgPicture.asset(
                        'icons/arrow.svg',
                        width: 40,
                        height: 20,
                        color: tBlue3.withOpacity(0.35),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // BORDERED STEP CARD (number badge + title + description)
  Widget _buildApproachStepCard(_ApproachStepData data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tBlack1.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tBlue2, tBlue3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                data.number,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: tWhite,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            data.title,
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: tBlack,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            data.description,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.6),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SolutionCardData {
  final String title;
  final String description;
  final String image;
  final List<String> features;

  const _SolutionCardData({
    required this.title,
    required this.description,
    required this.image,
    required this.features,
  });
}

class _IndustryData {
  final String icon;
  final String label;

  const _IndustryData({required this.icon, required this.label});
}

class _ApproachStepData {
  final String number;
  final String title;
  final String description;

  const _ApproachStepData({
    required this.number,
    required this.title,
    required this.description,
  });
}
