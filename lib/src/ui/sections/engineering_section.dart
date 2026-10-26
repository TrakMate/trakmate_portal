import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/build_engineering.dart';
import 'package:trakmate_portal/src/ui/widgets/hero_animation.dart';
import 'package:trakmate_portal/src/ui/widgets/nav_footer.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

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
  bool _heroImageLoading = true;

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

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
    super.initState();
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
      await precacheImage(
        const AssetImage('images/hero_engineering.png'),
        context,
        onError: (e, s) => debugPrint('Failed to load engineering hero: $e'),
      ).timeout(const Duration(seconds: 10)); // never stay stuck on shimmer
    } catch (e) {
      // ignore
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
          _heroImageLoading
              ? const HeroHeaderShimmer()
              : _buildEngineeringHeader(),
          SizedBox(height: isMobile ? 24 : 30),
          BuildEngineeringSection(serviceKeys: _serviceKeys),
          const SizedBox(height: 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────
  // HEADER
  // ───────────────────────────────────────────────────────────────
  Widget _buildEngineeringHeader() {
    // Mobile has its own stacked layout (image on top, text below).
    if (isMobile) return _buildMobileHeader();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // How much of the hero width the image covers (from the right).
          final double imageWidth =
              constraints.maxWidth * (isTablet ? 0.5 : 0.62);

          return Stack(
            children: [
              // ── 1) IMAGE LAYER (behind the text), blended into the blue ──
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                width: imageWidth,
                child: _buildBlendedHeroImage(),
              ),

              // ── 2) CONTENT LAYER (text + cards) on top ──
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 400),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24 : 40,
                    vertical: 25,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isTablet ? 5 : 1,
                        child: _buildHeroTextColumn(),
                      ),
                      SizedBox(width: isTablet ? 16 : 40),
                      // Empty half: the image is visible behind this space.
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // MOBILE header: image banner on top (fading into the blue), then the text.
  Widget _buildMobileHeader() {
    final double screenW = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: screenW * 0.62,
            child: _buildMobileHeroImage(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: _buildHeroTextColumn(),
          ),
        ],
      ),
    );
  }

  /// Mobile hero image: only the bottom edge fades into the blue.
  Widget _buildMobileHeroImage() {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [tBlack, tBlack, tTransparent],
          stops: [0.0, 0.6, 1.0],
        ).createShader(rect);
      },
      child: Image.asset(
        'images/hero_engineering.png',
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
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
    );
  }

  /// The hero image with its LEFT edge (and a bit of the BOTTOM edge)
  /// faded to transparent, so it melts into the blue background.
  Widget _buildBlendedHeroImage() {
    // Horizontal fade: left = invisible → right = fully visible
    final Widget horizontallyFaded = ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [tTransparent, tBlack2, tBlack],
          stops: [0.0, 0.30, 0.55],
        ).createShader(rect);
      },
      child: Image.asset(
        'images/hero_engineering.png',
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
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
    );

    // Vertical fade: softens the bottom (and top) edge into the blue.
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [tBlack, tBlack, tTransparent],
          stops: [0.0, 0.80, 1.0],
        ).createShader(rect);
      },
      child: horizontallyFaded,
    );
  }

  /// Label, title, description and the 4 intro cards.
  Widget _buildHeroTextColumn() {
    final bool mobile = isMobile;
    final double screenW = MediaQuery.of(context).size.width;
    final bool compact = screenW < 380; // medium phones

    final double headingSize =
        mobile ? (compact ? 25 : 30) : (isTablet ? 34 : 48);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 20,
          child: Text(
            'ENGINEERING',
            style: GoogleFonts.manrope(
              fontSize: mobile ? 12 : 13,
              fontWeight: FontWeight.w600,
              color: tOrange1,
              letterSpacing: 1.2,
            ),
          ),
        ),

        SizedBox(height: mobile ? 14 : 20),
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 120,
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.manrope(
                fontSize: headingSize,
                fontWeight: FontWeight.w600,
                height: mobile ? 1.2 : 1.15,
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

        SizedBox(height: mobile ? 14 : 20),
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

        SizedBox(height: mobile ? 28 : 35),
        _heroCardsLayout(
          children: [
            HeroAnimatedText(
              isActive: widget.isActive,
              delay: 520,
              child: _buildHeaderIntroCard(
                icon: 'icons/location.svg',
                title: 'End-to-End Expertise',
                description: 'Complete engineering support to production',
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
    );
  }

  Widget _heroCardsLayout({required List<Widget> children}) {
    // Mobile: 2 x 2 grid
    if (isMobile) {
      const double hPad = 20;
      const double gap = 16;
      final double screenW = MediaQuery.of(context).size.width;
      final double cardW = ((screenW - (hPad * 2) - gap) / 2).floorToDouble();

      return Wrap(
        spacing: gap,
        runSpacing: 22,
        children: [
          for (final child in children) SizedBox(width: cardW, child: child),
        ],
      );
    }

    if (isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(width: isTablet ? 25 : 12),
            Expanded(child: children[i]),
          ],
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      // null = take whatever width the parent gives (tablet + mobile)
      width: (isTablet || isMobile) ? null : 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, width: 30, height: 30, color: tOrange1),

          const SizedBox(height: 10),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              maxLines: 1,
              softWrap: false,
              style: GoogleFonts.manrope(
                color: tWhite,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 6),

          Text(
            description,
            style: GoogleFonts.manrope(
              color: tWhite.withOpacity(0.7),
              fontSize: isTablet ? 11 : (isMobile ? 11.5 : 12),
              height: 1.35,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
