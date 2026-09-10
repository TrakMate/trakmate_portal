import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

import '../pages/blog.dart';
import '../pages/case_studies.dart';
import '../pages/documentation.dart';
// import '../pages/faq.dart';
import '../pages/whitepapers.dart';
import '../pages/webinar.dart';

class ResourcesSection extends StatefulWidget {
  final bool isActive;
  final ValueChanged<int>? onNavigate;

  const ResourcesSection({super.key, this.onNavigate, required this.isActive});

  @override
  State<ResourcesSection> createState() => _ResourcesSectionState();
}

class _ResourcesSectionState extends State<ResourcesSection> {
  final List<_ResourceCardData> _popularResources = const [
    _ResourceCardData(
      type: 'BLOGS',
      title: 'Explore Resources',
      description:
          'Discover useful information, insights, guidance and practical knowledge to help you learn, make informed decisions and get more from our solutions.',
      action: 'View Resources',
      image: 'images/future_iot.png',
      icon: Icons.article_outlined,
      accent: tOrange1,
    ),

    _ResourceCardData(
      type: 'WHITEPAPERS',
      title: 'Explore Resources',
      description:
          'Discover useful information, insights, guidance and practical knowledge to help you learn, make informed decisions and get more from our solutions.',
      action: 'View Resources',
      image: 'images/secure_iot.png',
      icon: Icons.description_outlined,
      accent: tBlue3,
    ),

    _ResourceCardData(
      type: 'CASE STUDIES',
      title: 'Explore Resources',
      description:
          'Discover useful information, insights, guidance and practical knowledge to help you learn, make informed decisions and get more from our solutions.',
      action: 'View Resources',
      image: 'images/casestudy.png',
      icon: Icons.local_shipping_outlined,
      accent: tBlue2,
    ),

    _ResourceCardData(
      type: 'TEAMS',
      title: 'Explore Resources',
      description:
          'Discover useful information, insights, guidance and practical knowledge to help you learn, make informed decisions and get more from our solutions.',
      action: 'View Resources',
      image: 'images/webinar.png',
      icon: Icons.groups_outlined,
      accent: tOrange1,
    ),

    _ResourceCardData(
      type: 'DOCUMENTATION',
      title: 'Explore Resources',
      description:
          'Discover useful information, insights, guidance and practical knowledge to help you learn, make informed decisions and get more from our solutions.',
      action: 'View Resources',
      image: 'images/documentation.png',
      icon: Icons.menu_book_outlined,
      accent: tBlue3,
    ),
  ];

  void _handleResourceAction(String type) {
    Widget? page;

    switch (type) {
      case 'BLOGS':
        page = const BlogPage();
        break;

      case 'WHITEPAPERS':
        page = const WhitepapersPage();
        break;

      case 'CASE STUDIES':
        page = const CaseStudiesPage();
        break;

      case 'TEAMS':
        page = const WebinarsPage();
        break;

      case 'DOCUMENTATION':
        page = const DocumentationPage();
        break;
    }

    if (page == null) return;

    Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHero(),

          const SizedBox(height: 54),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: _buildPopularResources(),
          ),

          const SizedBox(height: 54),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: _buildStayUpdatedSection(),
          ),

          const SizedBox(height: 42),

          FooterSection(),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return SizedBox(
      height: 400,

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          Container(
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
                      HeroAnimatedText(
                        isActive: widget.isActive,
                        delay: 20,
                        child: Text(
                          'RESOURCES',
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: tOrange1,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
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
                              const TextSpan(text: 'Knowledge. Insights.\n'),

                              TextSpan(
                                text: 'Growth.',
                                style: TextStyle(
                                  color: tOrange1,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      HeroAnimatedText(
                        isActive: widget.isActive,
                        delay: 320,
                        child: Text(
                          'Explore our resources to stay informed, solve challenges and accelerate your IoT and digital transformation journey.',

                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            color: tWhite,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      Row(
                        children: [
                          Expanded(
                            child: HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 520,
                              child: _buildResourceHeaderIntroCard(
                                icon: 'icons/innovation.svg',
                                title: 'Expert Insights',
                                description:
                                    'Industry knowledge and practical insights',
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 720,
                              child: _buildResourceHeaderIntroCard(
                                icon: 'icons/secured.svg',
                                title: 'Trusted Knowledge',
                                description:
                                    'Reliable information for smarter decisions',
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 920,
                              child: _buildResourceHeaderIntroCard(
                                icon: 'icons/future.svg',
                                title: 'Future-Ready',
                                description:
                                    'Stay ahead with emerging technology trends',
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: HeroAnimatedText(
                              isActive: widget.isActive,
                              delay: 1120,
                              child: _buildResourceHeaderIntroCard(
                                icon: 'icons/globe.svg',
                                title: 'All in One Place',
                                description:
                                    'Guides, case studies, webinars and more',
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
                      'images/hero_resources.png',
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
          ),
        ],
      ),
    );
  }

  Widget _buildResourceHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      mainAxisSize: MainAxisSize.min,

      children: [
        SvgPicture.asset(
          icon,
          width: 30,
          height: 30,

          colorFilter: ColorFilter.mode(tOrange1, BlendMode.srcIn),
        ),

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

  Widget _buildPopularResources() {
    return Column(
      children: [
        Text(
          'RESOURCE CATEGORIES',

          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.0,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Explore our knowledge hub',

          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 12.0;

            final width = (constraints.maxWidth - spacing * 4) / 5;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: List.generate(_popularResources.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == _popularResources.length - 1 ? 0 : spacing,
                  ),

                  child: SizedBox(
                    width: width,

                    child: _HoverResourceCard(
                      data: _popularResources[index],

                      onAction: () {
                        _handleResourceAction(_popularResources[index].type);
                      },
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStayUpdatedSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),

      child: Container(
        width: double.infinity,

        height: 360,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tBlue3, tBlue2],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Stack(
          clipBehavior: Clip.none,

          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: SvgPicture.asset(
                  'icons/waves_7.svg',

                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Expanded(
                    flex: 6,

                    child: Center(
                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: Column(
                          mainAxisSize: MainAxisSize.min,

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Explore New Insights',

                              style: GoogleFonts.manrope(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: tOrange1,
                                height: 1.15,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              'Discover valuable ideas, practical knowledge, and expert perspectives to help you learn,',
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: tWhite,
                                height: 1.3,
                              ),
                            ),

                            Text(
                              'make informed decisions, and stay ahead.',
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: tWhite,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                // horizontal: 3,
                                vertical: 5,
                              ),
                              // decoration: BoxDecoration(
                              //   color: tWhite.withOpacity(0.10),
                              //   borderRadius: BorderRadius.circular(10),
                              //   border: Border.all(
                              //     color: tWhite.withOpacity(0.12),
                              //   ),
                              // ),
                              child: Text(
                                'Stay Ahead of What’s Next.',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: tWhite.withOpacity(0.72),
                                  height: 1.15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 30),

                  Expanded(flex: 4, child: Center(child: _buildNewsletter())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsletter() {
    return _HoverContainer(
      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),

        decoration: BoxDecoration(
          color: const Color(0xFFF0F6FF),

          borderRadius: BorderRadius.circular(8),

          border: Border.all(color: tBlue3.withOpacity(0.08)),
        ),

        child: Stack(
          clipBehavior: Clip.none,

          children: [
            Padding(
              padding: const EdgeInsets.only(right: 150),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'STAY UPDATED',

                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Subscribe to our newsletter',

                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: tBlack,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Get the latest insights, product updates and industry trends delivered to your inbox.',

                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: tBlack.withOpacity(0.60),
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,

                          decoration: BoxDecoration(
                            color: tWhite,

                            borderRadius: BorderRadius.circular(6),

                            border: Border.all(color: tBlack.withOpacity(0.07)),
                          ),

                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your email',

                              hintStyle: GoogleFonts.manrope(
                                fontSize: 10,
                                color: tBlack.withOpacity(0.35),
                              ),

                              border: InputBorder.none,

                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      SizedBox(
                        height: 38,

                        child: ElevatedButton(
                          onPressed: () {},

                          style: ElevatedButton.styleFrom(
                            backgroundColor: tBlue3,

                            foregroundColor: tWhite,

                            elevation: 0,

                            padding: const EdgeInsets.symmetric(horizontal: 20),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),

                          child: Text(
                            'Subscribe',

                            style: GoogleFonts.manrope(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildNewsletterPoint('Latest articles and insights'),

                  _buildNewsletterPoint('Product updates and releases'),

                  _buildNewsletterPoint('Upcoming webinars and events'),

                  _buildNewsletterPoint('Exclusive offers and more'),
                ],
              ),
            ),

            Positioned(
              right: -12,
              bottom: -6,

              child: IgnorePointer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),

                  child: SizedBox(
                    width: 175,
                    height: 125,

                    child: Image.asset(
                      'images/email.png',

                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 145,
                          height: 145,

                          decoration: BoxDecoration(
                            color: tBlue3.withOpacity(0.08),

                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 30,
                            color: tBlue3.withOpacity(0.35),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsletterPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),

      child: Row(
        children: [
          Icon(Icons.check_circle_outline_rounded, size: 14, color: tBlue3),

          const SizedBox(width: 7),

          Expanded(
            child: Text(
              text,

              style: GoogleFonts.manrope(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: tBlack.withOpacity(0.65),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverResourceCard extends StatefulWidget {
  final _ResourceCardData data;
  final VoidCallback onAction;

  const _HoverResourceCard({required this.data, required this.onAction});

  @override
  State<_HoverResourceCard> createState() => _HoverResourceCardState();
}

class _HoverResourceCardState extends State<_HoverResourceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },

      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),

        curve: Curves.easeOutCubic,

        transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),

        height: 300,

        decoration: BoxDecoration(
          color: tWhite,

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color:
                _hovering
                    ? data.accent.withOpacity(0.28)
                    : tBlack.withOpacity(0.06),
          ),

          boxShadow: [
            BoxShadow(
              color:
                  _hovering
                      ? data.accent.withOpacity(0.10)
                      : tBlack.withOpacity(0.045),

              blurRadius: _hovering ? 22 : 12,

              offset: Offset(0, _hovering ? 10 : 5),
            ),
          ],
        ),

        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              height: 140,
              width: double.infinity,

              child: Stack(
                fit: StackFit.expand,

                children: [
                  Image.asset(
                    data.image,

                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: tBlack.withOpacity(0.04),

                        alignment: Alignment.center,

                        child: Icon(
                          data.icon,
                          size: 35,
                          color: data.accent.withOpacity(0.55),
                        ),
                      );
                    },
                  ),

                  Positioned(
                    top: 10,
                    left: 10,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: data.accent,

                        borderRadius: BorderRadius.circular(5),
                      ),

                      child: Text(
                        data.type,

                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: tWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 15, 18, 13),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      data.title,

                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: tBlack,
                        height: 1.28,
                      ),
                    ),

                    const SizedBox(height: 9),

                    Text(
                      data.description,

                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,

                      style: GoogleFonts.manrope(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: tBlack.withOpacity(0.58),
                        height: 1.4,
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: widget.onAction,

                      child: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Text(
                            data.action,

                            style: GoogleFonts.manrope(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: tBlue3,
                            ),
                          ),

                          const SizedBox(width: 5),

                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: tBlue3,
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
      ),
    );
  }
}

class _HoverContainer extends StatefulWidget {
  final Widget child;

  const _HoverContainer({required this.child});

  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },

      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),

        curve: Curves.easeOutCubic,

        transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),

        child: widget.child,
      ),
    );
  }
}

class _ResourceCardData {
  final String type;
  final String title;
  final String description;
  final String action;
  final String image;
  final IconData icon;
  final Color accent;

  const _ResourceCardData({
    required this.type,
    required this.title,
    required this.description,
    required this.action,
    required this.image,
    required this.icon,
    required this.accent,
  });
}
