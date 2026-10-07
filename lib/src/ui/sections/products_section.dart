import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/buildproducts.dart';
import 'package:trakmate_portal/src/ui/widgets/heroanimation.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import '../widgets/footer_section.dart';

class ProductsSection extends StatefulWidget {
  final bool isActive;
  final void Function(int index)? onNavigate;
  const ProductsSection({super.key, required this.isActive, this.onNavigate});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  bool _heroImageLoading = true; // NEW
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadHeroImage();
    });
  }

  Future<void> _preloadHeroImage() async {
    try {
      await precacheImage(
        const AssetImage('images/hero_products2.png'),
        context,
      );
      // await Future.delayed(const Duration(seconds: 3)); // just fr testing
    } catch (e) {
      debugPrint('Error preloading hero image: $e');
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
          // BuildProductSection(header: _buildProductsHeader()),
          BuildProductSection(
            header:
                _heroImageLoading
                    ? const HeroHeaderShimmer() // NEW
                    : _buildProductsHeader(),
          ),
          const SizedBox(height: 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildProductsHeader() {
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
          final double imageWidth = constraints.maxWidth * 0.62;

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 25,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _buildHeroTextColumn()),
                      const SizedBox(width: 40),
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
        'images/hero_products2.png',
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

  /// Left side: label, title, description and the 4 intro cards.
  /// (Same content as before, just moved into its own method.)
  Widget _buildHeroTextColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 20,
          child: Text(
            ' OUR PRODUCTS',
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

        const SizedBox(height: 20),
        HeroAnimatedText(
          isActive: widget.isActive,
          delay: 320,
          child: Text(
            'Explore our range of hardware and software products engineered to help businesses automate, connect and scale with confidence.',
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
                child: _buildHeaderIntroCard(
                  icon: 'icons/performance1.svg',
                  title: 'High Performance',
                  description: 'Built for reliable performance.',
                ),
              ),
            ),
            Expanded(
              child: HeroAnimatedText(
                isActive: widget.isActive,
                delay: 720,
                child: _buildHeaderIntroCard(
                  icon: 'icons/secured.svg',
                  title: 'Reliable & Secure',
                  description: 'Built for secure performanceble ',
                ),
              ),
            ),
            Expanded(
              child: HeroAnimatedText(
                isActive: widget.isActive,
                delay: 920,
                child: _buildHeaderIntroCard(
                  icon: 'icons/integration1.svg',
                  title: 'Easy Integration',
                  description: 'Simple integration with your systems',
                ),
              ),
            ),
            Expanded(
              child: HeroAnimatedText(
                isActive: widget.isActive,
                delay: 1120,
                child: _buildHeaderIntroCard(
                  icon: 'icons/scalability.svg',
                  title: 'Built for Scale',
                  description: 'Designed to grow with your needs',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
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
