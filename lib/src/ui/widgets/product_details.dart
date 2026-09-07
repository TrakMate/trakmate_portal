import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/ui/widgets/buildproducts.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductData product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // EXPAND / COLLAPSE

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

  // PRODUCT IMAGE SLIDER

  late final PageController _imagePageController;

  int _currentImageIndex = 0;

  List<String> get _productImages {
    final List<String> images = [];

    // Image 1 is always available.
    if (product.image.isNotEmpty) {
      images.add(product.image);
    }

    // Add only images that were provided.
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

    // Safety fallback.
    if (images.isEmpty) {
      images.add(product.image);
    }

    return images;
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

            if (isCompact) {
              return _buildCompactLayout();
            }

            return _buildDesktopLayout();
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // BACK BUTTON
        _buildBackButton(),

        const SizedBox(height: 25),

        // MAIN PRODUCT + INFORMATION AREA
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT SECTION — FIXED
              Expanded(flex: 52, child: _buildLeftProductArea()),

              const SizedBox(width: 48),

              // RIGHT SECTION — SCROLLABLE
              Expanded(
                flex: 48,
                child: ClipRect(
                  child: SingleChildScrollView(
                    controller: _rightScrollController,
                    child: _buildRightInformationArea(),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // FULL WIDTH CTA — FIXED
        _buildTalkToTeamSection(),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // BACK BUTTON
        _buildBackButton(),

        const SizedBox(height: 22),

        // PRODUCT
        _buildLeftProductArea(),

        const SizedBox(height: 35),

        // INFORMATION
        _buildRightInformationArea(),

        const SizedBox(height: 35),

        // CTA
        _buildTalkToTeamSection(),
      ],
    );
  }

  // BACK BUTTON

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

  // LEFT PRODUCT AREA

  Widget _buildLeftProductArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // PRODUCT TITLE
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

        // PRODUCT IMAGE
        _buildProductImage(),

        const SizedBox(height: 14),

        // IMAGE LABEL
        Row(
          children: [
            Container(width: 90, height: 2, color: tOrange1),

            const SizedBox(width: 9),

            // Text(
            //   'CONNECTED TECHNOLOGY',
            //
            //   style: GoogleFonts.manrope(
            //     fontSize: 8.5,
            //     fontWeight: FontWeight.w600,
            //     color: tBlack.withOpacity(0.40),
            //     letterSpacing: 1.2,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  // PRODUCT IMAGE

  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: 530,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: tBlack.withOpacity(0.025)),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // SOFT ORANGE CIRCLE
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

          // SOFT BLUE CIRCLE
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

          // PRODUCT IMAGE SLIDER
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: PageView.builder(
                controller: _imagePageController,
                itemCount: _productImages.length,

                onPageChanged: (index) {
                  if (!mounted) return;

                  setState(() {
                    _currentImageIndex = index;
                  });
                },

                itemBuilder: (context, index) {
                  return Image.asset(
                    _productImages[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              size: 48,
                              color: tBlack.withOpacity(0.20),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              'Product Image',
                              style: GoogleFonts.manrope(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: tBlack.withOpacity(0.35),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // BACKWARD ARROW
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

          // FORWARD ARROW
          Positioned(
            right: 5,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildImageNavigationButton(
                icon: Icons.arrow_forward_ios_rounded,

                onTap: () {
                  if (_currentImageIndex < _productImages.length - 1) {
                    _imagePageController.nextPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                    );
                  }
                },

                enabled: _currentImageIndex < _productImages.length - 1,
              ),
            ),
          ),

          // PRODUCT BADGE
          // if (product.badge != null)
          //   Positioned(
          //     top: 18,
          //     right: 18,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 12,
          //         vertical: 6,
          //       ),
          //       decoration: BoxDecoration(
          //         color: product.badgeColor ?? tBlue3,
          //         borderRadius: BorderRadius.circular(4),
          //       ),
          //       child: Text(
          //         product.badge!,
          //         style: GoogleFonts.manrope(
          //           fontSize: 12,
          //           fontWeight: FontWeight.w800,
          //           color: tWhite,
          //         ),
          //       ),
          //     ),
          //   ),

          // SMALL IMAGE THUMBNAILS
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_productImages.length, (index) {
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

                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : 5,
                      right: index == _productImages.length - 1 ? 0 : 5,
                    ),

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
              }),
            ),
          ),

          // PRODUCT ID
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

  // IMAGE NAVIGATION BUTTON

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

      final double maxScroll = _rightScrollController.position.maxScrollExtent;

      final double clampedOffset = targetOffset.clamp(0.0, maxScroll);

      _rightScrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
  }
  // RIGHT INFORMATION AREA

  Widget _buildRightInformationArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // PRODUCT DESCRIPTION
        Text(
          'PRODUCT DESCRIPTION',
          style: GoogleFonts.manrope(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: tBlack,
          ),
        ),

        const SizedBox(height: 37),

        // BLUE LINE
        Container(width: 98, height: 2, color: tBlue2),

        const SizedBox(height: 27),

        // DESCRIPTION
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

        // USE CASES
        _buildUseCases(),

        const SizedBox(height: 36),

        // FEATURES
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

        // SPECIFICATIONS
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

        // CONNECTIVITY
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

        // APPLICATIONS
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

  // USE CASES

  Widget _buildUseCases() {
    final useCases = [
      'Electric and Hybrid Vehicles',
      'Road Safety',
      'Pedestrian Safety',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Use Cases',
          style: GoogleFonts.manrope(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: tBlack,
          ),
        ),

        const SizedBox(height: 14),

        ...useCases.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: tBlue2,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: tBlack.withOpacity(0.65),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // EXPANDABLE SECTION

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
          // HEADER
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

                    // AnimatedRotation(
                    //   duration: const Duration(milliseconds: 180),

                    //   turns: expanded ? 0.5 : 0,

                    //   child: Icon(
                    //     Icons.keyboard_arrow_down_rounded,

                    //     size: 21,

                    //     color: tBlack.withOpacity(0.45),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          // CONTENT
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

  // FEATURES

  Widget _buildFeaturesContent() {
    final features = [
      'Datalogging up to 15000 Location Records',
      'Vehicle / BMS monitoring using CAN / Serial Bus',
      'Configuration over SMS/GPRS',
      'Odometer (GPS & Pulse Count)',
      'Firmware Over The Air (FOTA)',
      'Battery Back-up',
      'IP65',
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

  // SPECIFICATIONS

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

  // CONNECTIVITY

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

  // APPLICATIONS

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

  // TALK TO OUR TEAM

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
                // Add your contact action here.
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
