import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';

import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/ui/widgets/buildproducts.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductData product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _featuresExpanded = false;
  bool _specificationsExpanded = false;
  bool _connectivityExpanded = false;
  bool _applicationsExpanded = false;

  final ScrollController _rightScrollController = ScrollController();

  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _specificationsKey = GlobalKey();
  final GlobalKey _connectivityKey = GlobalKey();
  final GlobalKey _applicationsKey = GlobalKey();

  ProductData get product => widget.product;

  late final PageController _imagePageController;

  int _currentImageIndex = 0;

  List<String> get _productImages {
    final List<String> images = [];

    if (product.image.isNotEmpty) {
      images.add(product.image);
    }

    if (product.image2 != null && product.image2!.isNotEmpty) {
      images.add(product.image2!);
    }

    if (product.image3 != null && product.image3!.isNotEmpty) {
      images.add(product.image3!);
    }

    if (product.image4 != null && product.image4!.isNotEmpty) {
      images.add(product.image4!);
    }

    if (product.image5 != null && product.image5!.isNotEmpty) {
      images.add(product.image5!);
    }

    if (images.isEmpty) {
      images.add(product.image);
    }

    return images;
  }

  List<_FeatureItem> get _featureItems {
    switch (product.title) {
      // PRODUCT 1
      //
      // 'TMD364' now falls through to the exact same feature collage as
      // 'TMD 364-AIS140' (office photo + GPS icon + globe icon), instead of
      // the old commented-out layout further below.

      // case 'TMD 364-AIS140':
      case 'TMD364':
        return const [
          _FeatureItem.image(
            'images/tmd364-top1.png',
            left: 5,
            top: 26,
            width: 45,
            height: 45,
          ),
          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 72,
            top: 8,
            width: 16,
            height: 16,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 66,
            top: 30,
            width: 24,
            height: 24,
          ),

          _FeatureItem.image(
            'images/4g.png',
            left: 72,
            top: 57,
            width: 14,
            height: 14,
          ),

          // _FeatureItem.image(
          //   'images/company.png',
          //   left: 72,
          //   top: 74,
          //   width: 16,
          //   height: 16,
          // ),
        ];

      // PRODUCT 2

      case 'TMD104':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 15,
            top: 25,
            width: 30,
            height: 30,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 45,
            top: 18,
            width: 50,
            height: 50,
          ),

          // _FeatureItem.svg(
          //   'icons/gps.svg',
          //   left: 75,
          //   top: 15,
          //   width: 18,
          //   height: 18,
          // ),

          // _FeatureItem.svg(
          //   'icons/globe.svg',
          //   left: 20,
          //   top: 55,
          //   width: 25,
          //   height: 25,
          // ),

          // _FeatureItem.image(
          //   'images/company.png',
          //   left: 52,
          //   top: 48,
          //   width: 35,
          //   height: 32,
          // ),
        ];

      // PRODUCT 3

      case 'TMD004':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 30,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 18,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 30,
            width: 20,
            height: 20,
          ),

          // _FeatureItem.svg(
          //   'icons/globe.svg',
          //   left: 20,
          //   top: 55,
          //   width: 25,
          //   height: 25,
          // ),

          // _FeatureItem.image(
          //   'images/company.png',
          //   left: 52,
          //   top: 48,
          //   width: 35,
          //   height: 32,
          // ),
        ];

      // PRODUCT 4

      case 'TMD024':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 30,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 18,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 30,
            width: 20,
            height: 20,
          ),
        ];

      // PRODUCT 5

      case 'TMB024':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 30,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 18,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 30,
            width: 20,
            height: 20,
          ),
        ];

      // PRODUCT 6

      case 'TMD400':
        return const [
          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 35,
            top: 30,
            width: 40,
            height: 40,
          ),
        ];

      // PRODUCT 7

      case 'TCU510':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 20,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 9,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 20,
            width: 20,
            height: 20,
          ),

          // _FeatureItem.svg(
          //   'icons/globe.svg',
          //   left: 20,
          //   top: 55,
          //   width: 25,
          //   height: 25,
          // ),
          _FeatureItem.image(
            'images/linux.jpg',
            left: 35,
            top: 48,
            width: 35,
            height: 32,
          ),
        ];

      // PRODUCT 8

      case 'TCU520':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 20,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 9,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 20,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/wifi.png',
            left: 20,
            top: 55,
            width: 25,
            height: 25,
          ),
          _FeatureItem.image(
            'images/linux.jpg',
            left: 50,
            top: 54,
            width: 25,
            height: 22,
          ),
        ];

      // PRODUCT 9

      case 'TCU550':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 20,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 9,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 20,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/wifi.png',
            left: 7,
            top: 55,
            width: 25,
            height: 25,
          ),
          _FeatureItem.image(
            'images/linux.jpg',
            left: 40,
            top: 54,
            width: 25,
            height: 22,
          ),
          _FeatureItem.image(
            'images/ethernet.jpg',
            left: 57,
            top: 50,
            width: 45,
            height: 38,
          ),
        ];

      // PRODUCT 10

      case 'TMDCSTR-7':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 30,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 18,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 30,
            width: 20,
            height: 20,
          ),
        ];

      // PRODUCT 11

      case 'TMDCSTR-7A':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 20,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 9,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 20,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/wifi.png',
            left: 7,
            top: 55,
            width: 25,
            height: 25,
          ),
          _FeatureItem.image(
            'images/android.png',
            left: 40,
            top: 54,
            width: 25,
            height: 22,
          ),
          _FeatureItem.image(
            'images/HD.png',
            left: 65,
            top: 55,
            width: 30,
            height: 20,
          ),
        ];

      // PRODUCT 12

      case 'TMDCSTR-5':
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 10,
            top: 30,
            width: 20,
            height: 20,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 30,
            top: 18,
            width: 45,
            height: 45,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 70,
            top: 30,
            width: 20,
            height: 20,
          ),
        ];

      // DEFAULT

      default:
        return const [
          _FeatureItem.image(
            'images/4g.png',
            left: 8,
            top: 18,
            width: 18,
            height: 18,
          ),

          _FeatureItem.image(
            'images/bluetooth1.png',
            left: 30,
            top: 18,
            width: 18,
            height: 18,
          ),

          _FeatureItem.image(
            'images/ev-wifi.jpg',
            left: 48,
            top: 12,
            width: 25,
            height: 30,
          ),

          _FeatureItem.svg(
            'icons/gps.svg',
            left: 74,
            top: 18,
            width: 18,
            height: 18,
          ),

          _FeatureItem.svg(
            'icons/globe.svg',
            left: 19,
            top: 52,
            width: 18,
            height: 18,
          ),

          _FeatureItem.image(
            'images/company.png',
            left: 41,
            top: 52,
            width: 18,
            height: 18,
          ),

          _FeatureItem.svg(
            'icons/gps.svg',
            left: 63,
            top: 52,
            width: 18,
            height: 18,
          ),
        ];
    }
  }

  int get _carouselItemCount {
    return _productImages.length + 1;
  }

  int get _featurePageIndex {
    return _productImages.length;
  }

  @override
  void initState() {
    super.initState();

    _imagePageController = PageController();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _rightScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,

      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 22, 40, 20),

        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isCompact = constraints.maxWidth < 900;

            return isCompact ? _buildCompactLayout() : _buildDesktopLayout();
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        _buildBackButton(),

        const SizedBox(height: 25),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Expanded(
                flex: 52,

                child: _buildLeftProductArea(flexibleImage: true),
              ),

              const SizedBox(width: 48),

              Expanded(
                flex: 48,

                child: SingleChildScrollView(
                  controller: _rightScrollController,

                  child: _buildRightInformationArea(),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        _buildTalkToTeamSection(),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return SingleChildScrollView(
      controller: _rightScrollController,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          _buildBackButton(),

          const SizedBox(height: 22),

          _buildLeftProductArea(flexibleImage: false),

          const SizedBox(height: 35),

          _buildRightInformationArea(),

          const SizedBox(height: 35),

          _buildTalkToTeamSection(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.centerLeft,

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          mouseCursor: SystemMouseCursors.click,

          borderRadius: BorderRadius.circular(7),

          onTap: () {
            Navigator.pop(context);
          },

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),

            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Icon(Icons.arrow_back_rounded, size: 18, color: tBlue3),

                const SizedBox(width: 7),

                Text(
                  'Back to Products',

                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tBlue3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftProductArea({required bool flexibleImage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Text(
          product.title,

          style: GoogleFonts.manrope(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: tBlack,
            height: 1.15,
          ),
        ),

        const SizedBox(height: 12),

        flexibleImage
            ? Expanded(child: _buildProductImage(fixedHeight: null))
            : _buildProductImage(fixedHeight: 420),

        const SizedBox(height: 14),

        Row(
          children: [
            Container(width: 90, height: 2, color: tOrange1),

            const SizedBox(width: 9),
          ],
        ),
      ],
    );
  }

  Widget _buildProductImage({required double? fixedHeight}) {
    return Container(
      width: double.infinity,
      height: fixedHeight,

      decoration: BoxDecoration(
        color: tWhite,

        borderRadius: BorderRadius.circular(2),

        border: Border.all(color: tBlack.withOpacity(0.025)),
      ),

      child: Stack(
        clipBehavior: Clip.hardEdge,

        children: [
          Positioned(
            left: -80,
            bottom: -80,

            child: Container(
              width: 245,
              height: 245,

              decoration: BoxDecoration(
                color: tOrange1.withOpacity(0.055),

                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            right: -80,
            top: -80,

            child: Container(
              width: 245,
              height: 245,

              decoration: BoxDecoration(
                color: tBlue3.withOpacity(0.045),

                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(28),

              child: PageView.builder(
                controller: _imagePageController,

                itemCount: _carouselItemCount,

                onPageChanged: (index) {
                  if (!mounted) return;

                  setState(() {
                    _currentImageIndex = index;
                  });
                },

                itemBuilder: (context, index) {
                  if (index == _featurePageIndex) {
                    return _buildFeatureCollage();
                  }

                  return Image.asset(
                    _productImages[index],

                    fit: BoxFit.contain,

                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,

                          size: 48,

                          color: tBlack.withOpacity(0.20),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          Positioned(
            left: 5,
            top: 0,
            bottom: 0,

            child: Center(
              child: _buildImageNavigationButton(
                icon: Icons.arrow_back_ios_new_rounded,

                onTap: () {
                  if (_currentImageIndex > 0) {
                    _imagePageController.previousPage(
                      duration: const Duration(milliseconds: 350),

                      curve: Curves.easeOutCubic,
                    );
                  }
                },

                enabled: _currentImageIndex > 0,
              ),
            ),
          ),

          Positioned(
            right: 5,
            top: 0,
            bottom: 0,

            child: Center(
              child: _buildImageNavigationButton(
                icon: Icons.arrow_forward_ios_rounded,

                onTap: () {
                  if (_currentImageIndex < _carouselItemCount - 1) {
                    _imagePageController.nextPage(
                      duration: const Duration(milliseconds: 350),

                      curve: Curves.easeOutCubic,
                    );
                  }
                },

                enabled: _currentImageIndex < _carouselItemCount - 1,
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 10,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ...List.generate(_productImages.length, (index) {
                  return _buildProductThumbnail(index);
                }),

                _buildFeatureThumbnail(),
              ],
            ),
          ),

          Positioned(
            left: 24,
            bottom: 20,

            child: Text(
              product.title,

              style: GoogleFonts.manrope(
                fontSize: 13,

                fontWeight: FontWeight.w800,

                color: tBlue2.withOpacity(0.7),

                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductThumbnail(int index) {
    final bool isSelected = _currentImageIndex == index;

    return GestureDetector(
      onTap: () {
        _imagePageController.animateToPage(
          index,

          duration: const Duration(milliseconds: 350),

          curve: Curves.easeOutCubic,
        );
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),

        width: 52,
        height: 52,

        margin: const EdgeInsets.symmetric(horizontal: 5),

        padding: const EdgeInsets.all(3),

        decoration: BoxDecoration(
          color: tWhite,

          borderRadius: BorderRadius.circular(6),

          border: Border.all(
            color: isSelected ? tOrange1 : tBlack.withOpacity(0.10),

            width: isSelected ? 1.5 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(0.08),

              blurRadius: 7,

              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),

          child: Image.asset(
            _productImages[index],

            fit: BoxFit.contain,

            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.image_not_supported_outlined,

                size: 18,

                color: tBlack.withOpacity(0.25),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureThumbnail() {
    final bool isSelected = _currentImageIndex == _featurePageIndex;

    return GestureDetector(
      onTap: () {
        _imagePageController.animateToPage(
          _featurePageIndex,

          duration: const Duration(milliseconds: 350),

          curve: Curves.easeOutCubic,
        );
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),

        width: 52,
        height: 52,

        margin: const EdgeInsets.symmetric(horizontal: 5),

        padding: const EdgeInsets.all(3),

        decoration: BoxDecoration(
          color: tWhite,

          borderRadius: BorderRadius.circular(6),

          border: Border.all(
            color: isSelected ? tOrange1 : tBlack.withOpacity(0.10),

            width: isSelected ? 1.5 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(0.08),

              blurRadius: 7,

              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),

          child: Stack(
            children: [
              for (final item in _featureItems.take(4))
                Positioned(
                  left: item.left / 100 * 46,

                  top: item.top / 100 * 46,

                  width: item.width / 100 * 46,

                  height: item.height / 100 * 46,

                  child: _buildFeatureAsset(item),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCollage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        final double height = constraints.maxHeight;

        return Stack(
          clipBehavior: Clip.hardEdge,

          children: [
            for (final item in _featureItems)
              Positioned(
                left: (item.left / 100) * width,

                top: (item.top / 100) * height,

                width: (item.width / 100) * width,

                height: (item.height / 100) * height,

                child: Transform.rotate(
                  angle: item.rotation,

                  child: Opacity(
                    opacity: item.opacity,

                    child: _buildFeatureAsset(item),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureAsset(_FeatureItem item) {
    if (item.isSvg) {
      return SvgPicture.asset(
        item.asset,

        fit: BoxFit.contain,

        placeholderBuilder: (context) {
          return Center(
            child: Icon(
              Icons.image_outlined,

              size: 25,

              color: tBlack.withOpacity(0.20),
            ),
          );
        },
      );
    }

    return Image.asset(
      item.asset,

      fit: BoxFit.contain,

      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.image_not_supported_outlined,

            size: 30,

            color: tBlack.withOpacity(0.20),
          ),
        );
      },
    );
  }

  Widget _buildImageNavigationButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool enabled,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: enabled ? onTap : null,

        mouseCursor:
            enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,

        borderRadius: BorderRadius.circular(22),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color:
                enabled ? tWhite.withOpacity(0.92) : tWhite.withOpacity(0.55),

            shape: BoxShape.circle,

            boxShadow: [
              BoxShadow(
                color: tBlack.withOpacity(0.10),

                blurRadius: 10,

                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Icon(
            icon,

            size: 17,

            color: enabled ? tBlue2 : tBlack.withOpacity(0.22),
          ),
        ),
      ),
    );
  }

  void _scrollToExpandedSection(GlobalKey sectionKey) {
    Future.delayed(const Duration(milliseconds: 240), () {
      if (!mounted) return;

      final context = sectionKey.currentContext;

      if (context == null) return;

      final RenderObject? renderObject = context.findRenderObject();

      if (renderObject == null) return;

      final RenderAbstractViewport? viewport = RenderAbstractViewport.of(
        renderObject,
      );

      if (viewport == null) return;

      final double targetOffset =
          viewport.getOffsetToReveal(renderObject, 0.05).offset;

      if (!_rightScrollController.hasClients) {
        return;
      }

      final double maxScroll = _rightScrollController.position.maxScrollExtent;

      final double clampedOffset = targetOffset.clamp(0.0, maxScroll);

      _rightScrollController.animateTo(
        clampedOffset,

        duration: const Duration(milliseconds: 350),

        curve: Curves.easeOutCubic,
      );
    });
  }

  Widget _buildRightInformationArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(
              child: Text(
                'PRODUCT DESCRIPTION',

                style: GoogleFonts.manrope(
                  fontSize: 17,

                  fontWeight: FontWeight.w800,

                  color: tBlack,
                ),
              ),
            ),

            const _DataSheetButton(),
          ],
        ),

        const SizedBox(height: 37),

        Container(width: 98, height: 2, color: tBlue2),

        const SizedBox(height: 27),

        Text(
          product.description,

          style: GoogleFonts.manrope(
            fontSize: 14.5,

            fontWeight: FontWeight.w600,

            color: tBlack.withOpacity(0.65),

            height: 1.65,
          ),
        ),

        const SizedBox(height: 22),

        const SizedBox(height: 36),

        _buildExpandableSection(
          title: 'SPECIFICATIONS',

          icon:
              _specificationsExpanded
                  ? Icons.indeterminate_check_box_outlined
                  : Icons.add_box_outlined,

          expanded: _specificationsExpanded,

          onTap: () {
            final bool willExpand = !_specificationsExpanded;

            setState(() {
              _specificationsExpanded = willExpand;
            });

            if (willExpand) {
              _scrollToExpandedSection(_specificationsKey);
            }
          },

          child: _buildSpecificationsContent(),

          sectionKey: _specificationsKey,
        ),

        _buildExpandableSection(
          title: 'FEATURES',

          icon:
              _featuresExpanded
                  ? Icons.indeterminate_check_box_outlined
                  : Icons.add_box_outlined,

          expanded: _featuresExpanded,

          onTap: () {
            final bool willExpand = !_featuresExpanded;

            setState(() {
              _featuresExpanded = willExpand;
            });

            if (willExpand) {
              _scrollToExpandedSection(_featuresKey);
            }
          },

          child: _buildFeaturesContent(),

          sectionKey: _featuresKey,
        ),

        _buildExpandableSection(
          title: 'CONNECTIVITY & INTEGRATION',

          icon:
              _connectivityExpanded
                  ? Icons.indeterminate_check_box_outlined
                  : Icons.add_box_outlined,

          expanded: _connectivityExpanded,

          onTap: () {
            final bool willExpand = !_connectivityExpanded;

            setState(() {
              _connectivityExpanded = willExpand;
            });

            if (willExpand) {
              _scrollToExpandedSection(_connectivityKey);
            }
          },

          child: _buildConnectivityContent(),

          sectionKey: _connectivityKey,
        ),

        _buildExpandableSection(
          title: 'APPLICATIONS',

          icon:
              _applicationsExpanded
                  ? Icons.indeterminate_check_box_outlined
                  : Icons.add_box_outlined,

          expanded: _applicationsExpanded,

          onTap: () {
            final bool willExpand = !_applicationsExpanded;

            setState(() {
              _applicationsExpanded = willExpand;
            });

            if (willExpand) {
              _scrollToExpandedSection(_applicationsKey);
            }
          },

          child: _buildApplicationsContent(),

          sectionKey: _applicationsKey,
        ),
      ],
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
    required GlobalKey sectionKey,
  }) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: expanded ? const Color(0xFFFAFAFA) : tWhite,

        border: Border.all(color: tBlack.withOpacity(0.045)),
      ),

      child: Column(
        key: sectionKey,

        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Material(
            color: Colors.transparent,

            child: InkWell(
              onTap: onTap,

              mouseCursor: SystemMouseCursors.click,

              child: Container(
                height: 55,

                padding: const EdgeInsets.symmetric(horizontal: 14),

                child: Row(
                  children: [
                    Icon(icon, size: 22, color: tOrange1),

                    const SizedBox(width: 12),

                    Text(
                      title,

                      style: GoogleFonts.manrope(
                        fontSize: 15,

                        fontWeight: FontWeight.w800,

                        color: tBlack,
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 220),

            firstChild: const SizedBox(width: double.infinity, height: 0),

            secondChild: Container(
              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(20, 2, 20, 20),

              child: child,
            ),

            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesContent() {
    final features = [
      'Datalogging up to 15000 Location Records',
      'Vehicle / BMS monitoring using CAN / Serial Bus',
      'Configuration over SMS/GPRS',
      'Odometer (GPS & Pulse Count)',
      'Firmware Over The Air (FOTA)',
      'Battery Back-up',
      'IP67',
      'Immobilization Support',
      'Driver behavior',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children:
            features.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),

                child: Text(
                  '• $item',

                  style: GoogleFonts.manrope(
                    fontSize: 13,

                    fontWeight: FontWeight.w600,

                    color: tBlack.withOpacity(0.90),

                    height: 1.45,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildSpecificationsContent() {
    final specifications = [
      'GSM: 4G LTE modem with 2G fall back',
      'Protocols: TCP, UDP, HTTP, HTTPS',
      'GNSS: 48 Channel GNSS receiver, Position Accuracy 2.5m CEP, Sensitivity: -163 dBm',
      'Interfaces: 1 x CAN 2.0, 1 x RS485 or UART TTL',
      'Internal Antenna: GSM, GNSS',
      'Internal Battery: 450mAH',
      'Alerts: Over speed, Main power removal, Harsh acceleration, Harsh braking',
      'I/O’s: 1 x Digital Input, 1 x Digital Output, 1 x Analog Input',
      'Configuration: SMS/GPRS',
      'Indicator: GPS / GSM',
      'Plastic: ABS',
      'Motion Sensor: 6-Axis IMU, Accelerometer + Gyroscope',
      'Operating Temperature: -30°C to +80°C (Without Battery), -10°C to +60°C (With Battery)',
      'Power Supply: 8V to 70V – EV Variant, 8V to 120V – HV Variant',
      'Dimension: 70 x 50 x 28 mm',
      'Weight: 100 grams',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children:
            specifications.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),

                child: Text(
                  '• $item',

                  style: GoogleFonts.manrope(
                    fontSize: 13,

                    fontWeight: FontWeight.w600,

                    color: tBlack.withOpacity(0.90),

                    height: 1.45,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildConnectivityContent() {
    final connectivityItems = [
      '4G LTE modem with 2G fallback',
      'TCP, UDP, HTTP and HTTPS protocols',
      'CAN 2.0 vehicle / BMS interface',
      'RS485 or UART TTL interface',
      'GNSS positioning',
      'SMS/GPRS configuration',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children:
            connectivityItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),

                child: Text(
                  '• $item',

                  style: GoogleFonts.manrope(
                    fontSize: 13,

                    fontWeight: FontWeight.w600,

                    color: tBlack.withOpacity(0.90),

                    height: 1.45,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildApplicationsContent() {
    final applications = [
      'Vehicle Tracking',
      'Vehicle / BMS Monitoring',
      'Fleet Management',
      'Driver Behavior Monitoring',
      'Odometer Monitoring',
      'Remote Vehicle Configuration',
      'Vehicle Immobilization',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children:
            applications.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),

                child: Text(
                  '• $item',

                  style: GoogleFonts.manrope(
                    fontSize: 13,

                    fontWeight: FontWeight.w600,

                    color: tBlack.withOpacity(0.90),

                    height: 1.45,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildTalkToTeamSection() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FD),

        border: Border.all(color: tBlue3.withOpacity(0.10)),

        borderRadius: BorderRadius.circular(4),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            width: 4,
            height: 48,

            decoration: BoxDecoration(
              color: tOrange1,

              borderRadius: BorderRadius.circular(3),
            ),
          ),

          const SizedBox(width: 17),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Need more information?',

                  style: GoogleFonts.manrope(
                    fontSize: 17,

                    fontWeight: FontWeight.w800,

                    color: tBlue2,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Talk to our team to learn more about ${product.title}, integration options and deployment support.',

                  style: GoogleFonts.manrope(
                    fontSize: 11.5,

                    fontWeight: FontWeight.w400,

                    color: tBlack.withOpacity(0.52),

                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 25),

          Material(
            color: Colors.transparent,

            child: InkWell(
              mouseCursor: SystemMouseCursors.click,

              borderRadius: BorderRadius.circular(4),

              onTap: () {
                // CONTACT ACTION
              },

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),

                decoration: BoxDecoration(
                  color: tOrange1,

                  borderRadius: BorderRadius.circular(4),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      'Talk to Our Team',

                      style: GoogleFonts.manrope(
                        fontSize: 10.5,

                        fontWeight: FontWeight.w800,

                        color: tWhite,
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Icon(
                      Icons.arrow_forward_rounded,

                      size: 16,

                      color: tWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final String asset;

  final bool isSvg;

  final double left;
  final double top;

  final double width;
  final double height;

  final double rotation;
  final double opacity;

  const _FeatureItem({
    required this.asset,
    required this.isSvg,

    this.left = 0,
    this.top = 0,

    this.width = 20,
    this.height = 20,

    this.rotation = 0,
    this.opacity = 1,
  });

  const _FeatureItem.svg(
    String asset, {
    double left = 0,
    double top = 0,

    double width = 20,
    double height = 20,

    double rotation = 0,
    double opacity = 1,
  }) : this(
         asset: asset,
         isSvg: true,

         left: left,
         top: top,

         width: width,
         height: height,

         rotation: rotation,
         opacity: opacity,
       );

  const _FeatureItem.image(
    String asset, {
    double left = 0,
    double top = 0,

    double width = 20,
    double height = 20,

    double rotation = 0,
    double opacity = 1,
  }) : this(
         asset: asset,
         isSvg: false,

         left: left,
         top: top,

         width: width,
         height: height,

         rotation: rotation,
         opacity: opacity,
       );
}

class _DataSheetButton extends StatefulWidget {
  const _DataSheetButton();

  @override
  State<_DataSheetButton> createState() => _DataSheetButtonState();
}

class _DataSheetButtonState extends State<_DataSheetButton> {
  bool _isHovered = false;

  void _openDataSheetPlaceholder() {
    showDialog(
      context: context,

      builder: (context) {
        return Dialog(
          backgroundColor: tWhite,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          child: Container(
            width: 420,

            padding: const EdgeInsets.all(30),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  width: 55,
                  height: 55,

                  decoration: BoxDecoration(
                    color: tBlue2.withOpacity(0.08),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.description_outlined,

                    color: tBlue2,

                    size: 28,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'DATA SHEET',

                  style: GoogleFonts.manrope(
                    fontSize: 17,

                    fontWeight: FontWeight.w800,

                    color: tBlack,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Data sheet will be available here.',

                  textAlign: TextAlign.center,

                  style: GoogleFonts.manrope(
                    fontSize: 13,

                    fontWeight: FontWeight.w500,

                    color: tBlack.withOpacity(0.55),

                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 25),

                Material(
                  color: Colors.transparent,

                  child: InkWell(
                    mouseCursor: SystemMouseCursors.click,

                    borderRadius: BorderRadius.circular(4),

                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 11,
                      ),

                      decoration: BoxDecoration(
                        color: tBlue2,

                        borderRadius: BorderRadius.circular(4),
                      ),

                      child: Text(
                        'CLOSE',

                        style: GoogleFonts.manrope(
                          fontSize: 10.5,

                          fontWeight: FontWeight.w800,

                          color: tWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },

      child: GestureDetector(
        onTap: _openDataSheetPlaceholder,

        child: AnimatedScale(
          scale: _isHovered ? 1.06 : 1.0,

          duration: const Duration(milliseconds: 180),

          curve: Curves.easeOutBack,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),

            curve: Curves.easeOutCubic,

            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),

            decoration: BoxDecoration(
              color: _isHovered ? tOrange1 : tOrange1.withOpacity(0.90),

              borderRadius: BorderRadius.circular(8),

              boxShadow: [
                BoxShadow(
                  color: tBlue2.withOpacity(_isHovered ? 0.28 : 0),

                  blurRadius: _isHovered ? 14 : 0,

                  spreadRadius: _isHovered ? 1 : 0,

                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  'DATA SHEET',

                  style: GoogleFonts.manrope(
                    fontSize: 11,

                    fontWeight: FontWeight.w800,

                    color: tWhite,

                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(width: 7),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),

                  transform: Matrix4.translationValues(
                    _isHovered ? 3 : 0,
                    0,
                    0,
                  ),

                  child: SvgPicture.asset(
                    'icons/arrow.svg',

                    width: 14,
                    height: 14,

                    colorFilter: const ColorFilter.mode(
                      tWhite,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
