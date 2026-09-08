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
  const ProductsSection({super.key, required this.isActive});

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
      await precacheImage(const AssetImage('images/company.png'), context);
      await Future.delayed(const Duration(seconds: 3)); // just fr testing
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
          FooterSection(),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildProductsHeader() {
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
                'images/company.png',
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
