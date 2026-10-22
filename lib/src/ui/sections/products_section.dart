import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/build_products.dart';
import 'package:trakmate_portal/src/ui/widgets/hero_animation.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import '../widgets/footer_section.dart';

class ProductsSection extends StatefulWidget {
  final bool isActive;
  final void Function(int index)? onNavigate;
  const ProductsSection({super.key, required this.isActive, this.onNavigate});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  static const String _heroImage = 'images/hero_products2.png';

  bool _heroImageLoading = true;

  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
    });
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(const AssetImage(_heroImage), context);
      // await Future.delayed(const Duration(seconds: 3)); // just fr testing
    } catch (e) {
      // debugPrint('Error preloading hero image: $e');
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
          BuildProductSection(
            header:
                _heroImageLoading
                    ? const HeroHeaderShimmer()
                    : _buildProductsHeader(),
          ),
          SizedBox(height: isMobile ? 32 : 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------
  Widget _buildProductsHeader() {
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
          // Increase for a bigger image / longer blend, decrease for smaller.
          final double imageWidth =
              constraints.maxWidth * (isTablet ? 0.5 : 0.62);

          return Stack(
            children: [
              // 1) IMAGE LAYER (behind the text), blended into the blue
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                width: imageWidth,
                child: _buildBlendedHeroImage(),
              ),

              // 2) CONTENT LAYER (text + cards) on top
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
                        flex: isTablet ? 8 : 1,
                        child: _buildHeroTextColumn(),
                      ),
                      SizedBox(width: isTablet ? 0 : 40),
                      // Empty half: the image shows through behind this space.
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

  // MOBILE header: image banner on top (fading into the blue), text below.
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
          colors: [Colors.black, Colors.black, Colors.transparent],
          stops: [0.0, 0.6, 1.0],
        ).createShader(rect);
      },
      child: Image.asset(
        _heroImage,
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
        errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
      ),
    );
  }

  /// Hero image with its LEFT edge (and a bit of the BOTTOM edge)
  /// faded to transparent, so it melts into the blue background.
  Widget _buildBlendedHeroImage() {
    // Horizontal fade: left = invisible -> right = fully visible
    final Widget horizontallyFaded = ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.transparent, Colors.black54, Colors.black],
          // 0.00 -> 0.55 is the blend zone. Bigger last value = softer,
          // longer blend. Smaller = sharper edge.
          stops: [0.0, 0.30, 0.55],
        ).createShader(rect);
      },
      child: Image.asset(
        _heroImage,
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
        errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
      ),
    );

    // Vertical fade: softens the bottom edge into the blue.
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black, Colors.transparent],
          // Fully visible until 80% height, then fades out.
          stops: [0.0, 0.80, 1.0],
        ).createShader(rect);
      },
      child: horizontallyFaded,
    );
  }

  Widget _buildImageFallback() {
    return Container(
      color: tBlack.withOpacity(0.05),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 50,
        color: tWhite.withOpacity(0.6),
      ),
    );
  }

  /// Left side: label, title, description and the 4 intro cards.
  Widget _buildHeroTextColumn() {
    final bool mobile = isMobile;
    final double screenW = MediaQuery.of(context).size.width;
    final bool compact = screenW < 380; // small phones

    final double headingSize =
        mobile ? (compact ? 25 : 30) : (isTablet ? 34 : 48);

    // (icon, title, description, animation delay)
    const List<(String, String, String, int)> introData = [
      (
        'icons/performance2.svg',
        'High Performance',
        'Built for reliable performance.',
        520,
      ),
      (
        'icons/secured.svg',
        'Reliable & Secure',
        'Built for secure performanceble ',
        720,
      ),
      (
        'icons/integration2.svg',
        'Easy Integration',
        'Simple integration with your systems',
        920,
      ),
      (
        'icons/scalability.svg',
        'Built for Scale',
        'Designed to grow with your needs',
        1120,
      ),
    ];

    Widget introAt(int i) => HeroAnimatedText(
      isActive: widget.isActive,
      delay: introData[i].$4,
      child: _buildHeaderIntroCard(
        icon: introData[i].$1,
        title: introData[i].$2,
        description: introData[i].$3,
      ),
    );

    Widget intros;
    if (mobile) {
      // Mobile: 2 x 2 grid
      const double hPad = 20;
      const double gap = 16;
      final double cardW = ((screenW - (hPad * 2) - gap) / 2).floorToDouble();
      intros = Wrap(
        spacing: gap,
        runSpacing: 22,
        children: [
          for (int i = 0; i < introData.length; i++)
            SizedBox(width: cardW, child: introAt(i)),
        ],
      );
    } else {
      // Tablet / desktop (unchanged): one row
      intros = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: introAt(0)),
          SizedBox(width: isTablet ? 17 : 0),
          Expanded(child: introAt(1)),
          Expanded(child: introAt(2)),
          Expanded(child: introAt(3)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 20,
          child: Text(
            mobile ? 'OUR PRODUCTS' : ' OUR PRODUCTS',
            style: GoogleFonts.manrope(
              fontSize: mobile ? 12 : 13,
              fontWeight: FontWeight.w600,
              color: tOrange1,
              letterSpacing: 1.2,
            ),
          ),
        ),

        SizedBox(height: mobile ? 12 : 20),
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
                const TextSpan(text: 'Innovative Products.\n'),
                TextSpan(
                  text: 'Built for Performance.',
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
            'Explore our range of hardware and software products engineered to help businesses automate, connect and scale with confidence.',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: tWhite,
              fontWeight: FontWeight.w400,
              height: mobile ? 1.55 : 1.5,
            ),
          ),
        ),

        SizedBox(height: mobile ? 26 : 35),

        intros,

        // Desktop / tablet keep their bottom gap; mobile has its own padding.
        if (!mobile) const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    final bool mobile = isMobile;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 0 : (isTablet ? 1 : 6),
      ),
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
                fontSize: isTablet ? 12.5 : 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tWhite.withOpacity(0.7),
              fontSize: isTablet ? 11 : (mobile ? 11.5 : 12),
              height: mobile ? 1.35 : null,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
