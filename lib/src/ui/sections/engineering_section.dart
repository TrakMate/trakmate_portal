import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/buildengineering.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';
import 'package:trakmate_portal/src/ui/widgets/navfooter.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

import '../widgets/footer_section.dart';

class EngineeringSection extends StatefulWidget {
  final bool isActive;
  final void Function(int index)? onNavigate;
  const EngineeringSection({
    super.key,
    required this.isActive,
    this.onNavigate,
  });

  @override
  State<EngineeringSection> createState() => _EngineeringSectionState();
}

class _EngineeringSectionState extends State<EngineeringSection> {
  bool _heroImageLoading = true; // NEW
  final Map<String, GlobalKey> _serviceKeys = {
    'CAD Design': GlobalKey(),
    'Product Design': GlobalKey(),
    'Mechanical Engineering': GlobalKey(),
    'PCB Design': GlobalKey(),
    'PCB Assembly (PCBA)': GlobalKey(),
    'Firmware Development': GlobalKey(),
    'Prototyping': GlobalKey(),
  };
  @override
  void initState() {
    super.initState(); // NEW
    SectionScrollBus.instance.pendingKey.addListener(_onPendingKeyChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
      _tryScrollToPending();
    });
  }

  @override
  void didUpdateWidget(covariant EngineeringSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _tryScrollToPending(),
      );
    }
  }

  @override
  void dispose() {
    SectionScrollBus.instance.pendingKey.removeListener(_onPendingKeyChanged);
    super.dispose();
  }

  void _onPendingKeyChanged() {
    if (widget.isActive) _tryScrollToPending();
  }

  void _tryScrollToPending() {
    final target = SectionScrollBus.instance.pendingKey.value;
    if (target == null) return;

    final key = _serviceKeys[target.key];
    if (key == null) return; // not one of this section's items

    final ctx = key.currentContext;
    if (ctx == null) {
      // layout not ready yet, retry next frame
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _tryScrollToPending(),
      );
      return;
    }
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );

    SectionScrollBus.instance.pendingKey.value = null; // consumed
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(const AssetImage('images/sol3.jpg'), context);
      // await Future.delayed(const Duration(seconds: 3)); //  testing only
    } catch (e) {
      debugPrint('Error preloading solutions hero image: $e');
    }

    if (!mounted) return;
    setState(() {
      _heroImageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // _buildEngineeringHeader(),
          _heroImageLoading
              ? const HeroHeaderShimmer() // NEW
              : _buildEngineeringHeader(),
          const SizedBox(height: 30),
          BuildEngineeringSection(serviceKeys: _serviceKeys),
          const SizedBox(height: 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildEngineeringHeader() {
    return Container(
      width: double.infinity,
      // height: 400,
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
            // flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroAnimatedText(
                  isActive: widget.isActive,
                  delay: 20,
                  child: Text(
                    'ENGINEERING',
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
                        const TextSpan(text: 'Engineering Innovation.\n'),
                        TextSpan(
                          text: 'Built to Perform.',
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
                    'From concept to production, we deliver end-to-end engineering solutions that bring your ideas to life with precision, quality and efficiency.',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 520,
                      child: _buildHeaderIntroCard(
                        icon: 'icons/location.svg',
                        title: 'End-to-End Expertise',
                        description:
                            'Complete engineering support to production',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 720,
                      child: _buildHeaderIntroCard(
                        icon: 'icons/laptop.svg',
                        title: 'Advanced Engineering',
                        description: 'Modern tools for precise engineering',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 920,
                      child: _buildHeaderIntroCard(
                        icon: 'icons/collaboration.svg',
                        title: 'Expert Team',
                        description:
                            'Skilled engineers focused on quality and innovation',
                      ),
                    ),
                    HeroAnimatedText(
                      isActive: widget.isActive,
                      delay: 1120,
                      child: _buildHeaderIntroCard(
                        icon: 'icons/quality.svg',
                        title: 'Quality & Reliability',
                        description:
                            'Engineered for consistent performance & reliability',
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
                'images/hero_engineering.png',
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
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

          const SizedBox(height: 6),

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
      ),
    );
  }
}
