import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class ManufacturingSection extends StatefulWidget {
  final bool isActive;

  const ManufacturingSection({super.key, required this.isActive});

  @override
  State<ManufacturingSection> createState() => _ManufacturingSectionState();
}

class _ManufacturingSectionState extends State<ManufacturingSection> {
  static const String _heroImage = 'images/company.png';
  // static const String _cardImage = 'images/company.jpg';

  final List<_ManufacturingService> _services = const [
    _ManufacturingService(
      title: 'Electronics Manufacturing',
      description:
          'End-to-end electronics manufacturing with reliable processes and quality-focused production.',
      image: 'images/manufacture.jpg',
      icon: 'icons/automation.svg',
    ),
    _ManufacturingService(
      title: 'Product Assembly',
      description:
          'Efficient product assembly solutions built for consistent quality and scalable production.',
      image: 'images/pcba.jpg',
      icon: 'icons/product.svg',
    ),
    _ManufacturingService(
      title: 'Testing & Validation',
      description:
          'Comprehensive testing, electrical validation and performance checks for dependable products.',
      image: 'images/testing.jpg',
      icon: 'icons/search.svg',
    ),
    _ManufacturingService(
      title: 'Quality Assurance',
      description:
          'Rigorous quality control processes and standards to deliver defect-free products consistently.',
      image: 'images/quality_assurance.jpg',
      icon: 'icons/quality.svg',
    ),
    _ManufacturingService(
      title: 'Production Support',
      description:
          'End-to-end production support including supply-chain management and process improvement.',
      image: 'images/production_support.jpg',
      icon: 'icons/production.svg',
    ),
    _ManufacturingService(
      title: 'Contract Manufacturing',
      description:
          'Flexible manufacturing support designed to scale with your product and business requirements.',
      image: 'images/contract_manufacturing.jpg',
      icon: 'icons/contract.svg',
    ),
  ];

  final List<_ManufacturingValue> _values = const [
    _ManufacturingValue(
      icon: 'icons/quality.svg',
      title: 'High Quality',
      description: 'Standardized processes and consistent product quality.',
    ),
    _ManufacturingValue(
      icon: 'icons/laptop.svg',
      title: 'Advanced Facilities',
      description: 'Modern capabilities for efficient and reliable production.',
    ),
    _ManufacturingValue(
      icon: 'icons/team.svg',
      title: 'Experienced Team',
      description: 'Skilled professionals focused on precision and execution.',
    ),
    _ManufacturingValue(
      icon: 'icons/scalability.svg',
      title: 'Scalable Solutions',
      description:
          'Production support designed to grow with your requirements.',
    ),
    _ManufacturingValue(
      icon: 'icons/ontime.svg',
      title: 'On-Time Delivery',
      description: 'Structured planning and dependable production schedules.',
    ),
    _ManufacturingValue(
      icon: 'icons/secured.svg',
      title: 'Confidential & Secure',
      description: 'Responsible handling of products, processes and data.',
    ),
  ];

  final List<_ManufacturingProcess> _process = const [
    _ManufacturingProcess(
      number: '01',
      title: 'Requirement Analysis',
      description:
          'We understand your product requirements, specifications and production goals.',
      icon: 'icons/globe.svg',
    ),
    _ManufacturingProcess(
      number: '02',
      title: 'Manufacturing Planning',
      description:
          'We design the right solution, features, experience and technology.',
      icon: 'icons/automation.svg',
    ),
    _ManufacturingProcess(
      number: '03',
      title: 'Production & Assembly',
      description:
          'Products are assembled and manufactured with precision and controlled processes.',
      icon: 'icons/product.svg',
    ),
    _ManufacturingProcess(
      number: '04',
      title: 'Testing & Validation',
      description:
          'Products undergo testing and validation to ensure reliability and performance.',
      icon: 'icons/search.svg',
    ),
    _ManufacturingProcess(
      number: '05',
      title: 'Packaging & Delivery',
      description:
          'Finished products are prepared, packaged and coordinated for delivery.',
      icon: 'icons/truck.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHero(),

          const SizedBox(height: 42),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _buildServicesSection(),
          ),

          const SizedBox(height: 42),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _buildQualityBar(),
          ),

          const SizedBox(height: 42),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _buildProcessSection(),
          ),

          const SizedBox(height: 45),

          FooterSection(),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      // height: 400,
      // constraints: const BoxConstraints(minHeight: 365),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        children: [
          Expanded(
            // flex: 5,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroAnimatedText(
                  isActive: widget.isActive,
                  delay: 20,
                  child: Text(
                    'MANUFACTURING EXCELLENCE',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tOrange1,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                HeroAnimatedText(
                  isActive: widget.isActive,
                  delay: 120,
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                        height: 1.15,
                        color: tWhite,
                      ),
                      children: [
                        const TextSpan(text: 'Precision Manufacturing.\n'),
                        TextSpan(
                          text: 'Trusted Delivery.',
                          style: TextStyle(
                            color: tOrange1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),
                HeroAnimatedText(
                  isActive: widget.isActive,
                  delay: 320,
                  child: Text(
                    'End-to-end manufacturing solutions designed to deliver reliable, scalable and quality-focused products.',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: tWhite,
                      fontWeight: FontWeight.w400,
                      height: 1.55,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: HeroAnimatedText(
                        isActive: widget.isActive,
                        delay: 520,
                        child: _buildHeroPoint(
                          icon: 'icons/laptop.svg',
                          title: 'Advanced Infrastructure',
                          subtitle:
                              'Modern facilities for efficient production',
                        ),
                      ),
                    ),

                    Expanded(
                      child: HeroAnimatedText(
                        isActive: widget.isActive,
                        delay: 720,
                        child: _buildHeroPoint(
                          icon: 'icons/team.svg',
                          title: 'Skilled Workforce',
                          subtitle: 'Experienced teams focused on precision',
                        ),
                      ),
                    ),

                    Expanded(
                      child: HeroAnimatedText(
                        isActive: widget.isActive,
                        delay: 920,
                        child: _buildHeroPoint(
                          icon: 'icons/quality1.svg',
                          title: 'Quality Focus',
                          subtitle: 'Consistent quality at every stage',
                        ),
                      ),
                    ),

                    Expanded(
                      child: HeroAnimatedText(
                        isActive: widget.isActive,
                        delay: 1120,
                        child: _buildHeroPoint(
                          icon: 'icons/ontime.svg',
                          title: 'On-Time Delivery',
                          subtitle: 'Reliable production and timely delivery',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          Expanded(
            // flex: 4,
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: tBlack.withOpacity(0.25),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                _heroImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildImageFallback(dark: true);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPoint({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, width: 30, height: 30, color: tOrange1),

          const SizedBox(height: 10),

          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tWhite,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tWhite.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // SERVICES

  Widget _buildServicesSection() {
    return Column(
      children: [
        Text(
          'OUR MANUFACTURING SERVICES',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'End-to-End Manufacturing Solutions',
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
          width: 600,
          child: Text(
            'From electronics manufacturing and assembly to testing and production support, we help bring products from concept to reality.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: tBlack,
              height: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 30),

        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth - 32) / 3;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children:
                  _services.map((service) {
                    return SizedBox(
                      width: cardWidth,
                      child: _buildServiceCard(service),
                    );
                  }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(_ManufacturingService service) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tBlack1.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.045),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    service.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildImageFallback();
                    },
                  ),
                ),

                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: tBlue2,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: tBlack.withOpacity(0.18),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(9),
                    child: SvgPicture.asset(service.icon, color: tWhite),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: tBlack,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Expanded(
                    child: Text(
                      service.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: tBlack.withOpacity(0.58),
                        height: 1.4,
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Learn More',
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: tOrange1,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 13,
                          color: tOrange1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // QUALITY BAR

  Widget _buildQualityBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: tBlue2.withOpacity(0.16),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'WHY PARTNER WITH US',
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Built on Quality. Driven by Commitment.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              for (int i = 0; i < _values.length; i++) ...[
                Expanded(child: _buildQualityItem(_values[i])),
                if (i < _values.length - 1)
                  Container(
                    width: 1,
                    height: 55,
                    color: tWhite.withOpacity(0.14),
                  ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQualityItem(_ManufacturingValue value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset(value.icon, color: tOrange1),
          ),

          const SizedBox(height: 7),

          Text(
            value.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value.description,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: tWhite.withOpacity(0.62),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // PROCESS

  Widget _buildProcessSection() {
    return Column(
      children: [
        Text(
          'OUR MANUFACTURING PROCESS',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'From Concept to Customer',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: tBlack,
          ),
        ),

        const SizedBox(height: 32),

        LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < _process.length; index++) ...[
                    // PROCESS ITEM
                    Expanded(
                      child: _buildProcessItem(
                        _process[index],
                        index.isEven ? tBlue3 : tOrange1,
                      ),
                    ),

                    // LONG DOTTED ARROW
                    if (index != _process.length - 1)
                      SizedBox(
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: _buildDottedArrow(),
                        ),
                      ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // DOTTED LONG ARROW

  Widget _buildDottedArrow() {
    return SizedBox(
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 9; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.circle,
                size: 3.5,
                color: tBlue3.withOpacity(0.45),
              ),
            ),

          const SizedBox(width: 2),

          Icon(
            Icons.arrow_forward_rounded,
            size: 18,
            color: tBlue3.withOpacity(0.65),
          ),
        ],
      ),
    );
  }

  // PROCESS ITEM

  Widget _buildProcessItem(_ManufacturingProcess process, Color circleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(11),
          child: SvgPicture.asset(process.icon, color: tWhite),
        ),

        const SizedBox(height: 10),

        Text(
          process.number,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: tOrange1,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          process.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tBlack,
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          width: 180,
          height: 49,
          child: Text(
            process.description,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.55),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  // IMAGE FALLBACK

  Widget _buildImageFallback({bool dark = false}) {
    return Container(
      color: dark ? tBlue2 : tBlack.withOpacity(0.04),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: dark ? 48 : 34,
        color: dark ? tWhite.withOpacity(0.55) : tBlack.withOpacity(0.25),
      ),
    );
  }
}

// DATA MODELS

class _ManufacturingService {
  final String title;
  final String description;
  final String image;
  final String icon;

  const _ManufacturingService({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
  });
}

class _ManufacturingValue {
  final String icon;
  final String title;
  final String description;

  const _ManufacturingValue({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _ManufacturingProcess {
  final String number;
  final String title;
  final String description;
  final String icon;

  const _ManufacturingProcess({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
  });
}
