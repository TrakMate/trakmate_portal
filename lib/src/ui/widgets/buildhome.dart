import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/homeanimation.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class _IndustryItemData {
  final String image;
  final IconData icon;
  final String label;

  const _IndustryItemData({
    required this.image,
    required this.icon,
    required this.label,
  });
}

class _ProductItemData {
  final String image;
  final String name;
  final String subtitle;

  const _ProductItemData({
    required this.image,
    required this.name,
    required this.subtitle,
  });
}

class _ServiceItemData {
  final String icon;
  final String title;
  final List<String> points;

  const _ServiceItemData({
    required this.icon,
    required this.title,
    required this.points,
  });
}

// class _ClientItemData {
//   final String image;
//   final String name;

//   const _ClientItemData({required this.image, required this.name});
// }
class _ClientItemData {
  final String image;
  final String name;
  final double width;
  final double height;

  const _ClientItemData({
    required this.image,
    required this.name,
    required this.width,
    required this.height,
  });
}

class IndustriesProductsSection extends StatefulWidget {
  final ValueChanged<int>? onNavigate;
  const IndustriesProductsSection({super.key, this.onNavigate});

  @override
  State<IndustriesProductsSection> createState() =>
      _IndustriesProductsSectionState();
}

class _IndustriesProductsSectionState extends State<IndustriesProductsSection>
    with SingleTickerProviderStateMixin {
  final List<_IndustryItemData> _industries = const [
    _IndustryItemData(
      image: "images/smartcity.jpg",
      icon: CupertinoIcons.building_2_fill,
      label: "Smart Cities",
    ),
    _IndustryItemData(
      image: "images/ev.jpg",
      icon: CupertinoIcons.car_detailed,
      label: "EV & E-Mobility",
    ),
    _IndustryItemData(
      image: "images/fleetmanagement.jpg",
      icon: CupertinoIcons.bus,
      label: "Fleet Management",
    ),
    _IndustryItemData(
      image: "images/automation.jpg",
      icon: Icons.precision_manufacturing_rounded,
      label: "Industrial Automation",
    ),
    // _IndustryItemData(
    //   image: "images/infrastructure.png",
    //   icon: Icons.location_city_rounded,
    //   label: "Smart Cities",
    // ),
    _IndustryItemData(
      image: "images/agri2.jpg",
      icon: Icons.agriculture_rounded,
      label: "Agriculture",
    ),
    _IndustryItemData(
      image: "images/retail.png",
      icon: CupertinoIcons.bag_fill,
      label: "Retail",
    ),
    _IndustryItemData(
      image: "images/logistics.jpg",
      icon: CupertinoIcons.cube_box_fill,
      label: "Logistics",
    ),
  ];

  final List<_ProductItemData> _products = const [
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "TMD024",
      subtitle: "Advanced GPS Tracker",
    ),
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "TMD364",
      subtitle: "Industrial IoT Gateway",
    ),
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "TMD500",
      subtitle: "Smart IoT Sensor",
    ),
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "TMD320",
      subtitle: "Embedded Controller",
    ),
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "5-inch cluster-TFT",
      subtitle: "Vehicle Diagnostics",
    ),
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "7-inch cluster-Android",
      subtitle: "Bluetooth Low Energy Beacon",
    ),
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "TMD410",
      subtitle: "Bluetooth Low Energy Beacon",
    ),
    _ProductItemData(
      image: "images/trackx4G.png",
      name: "TMD006",
      subtitle: "Bluetooth Low Energy Beacon",
    ),
    // _ProductItemData(
    //   image: "images/trackx4G.png",
    //   name: "TMD006",
    //   subtitle: "Bluetooth Low Energy Beacon",
    // ),
  ];

  final List<_ServiceItemData> _services = const [
    _ServiceItemData(
      icon: "icons/product_engineering.svg",
      title: "Product Engineering",
      points: [
        "CAD Design",
        "Industrial Design",
        "Mechanical Engineering",
        "Product Development",
      ],
    ),
    _ServiceItemData(
      icon: "icons/electronics_design.svg",
      title: "Electronics Design",
      points: [
        "PCB Design",
        "Schematic Design",
        "Hardware Development",
        "Prototype Development",
      ],
    ),
    _ServiceItemData(
      icon: "icons/embedded_systems.svg",
      title: "Embedded Systems",
      points: [
        "Firmware Development",
        "RTOS / Linux",
        "Driver Development",
        "Testing & Validation",
      ],
    ),
    _ServiceItemData(
      icon: "icons/iot_solutions.svg",
      title: "IoT Solutions",
      points: [
        "GPS / BLE / WIFI / LoRa",
        "NB-IoT / 4G / LTE-M",
        "Cloud Integration",
        "MQTT & Analytics",
      ],
    ),
    _ServiceItemData(
      icon: "icons/software_solutions.svg",
      title: "Software Solutions",
      points: [
        "Web Applications",
        "Mobile Apps",
        "Cloud Platforms",
        "APIs & Integrations",
      ],
    ),
    _ServiceItemData(
      icon: "icons/manufacturing.svg",
      title: "Manufacturing",
      points: [
        "PCB Assembly (PCBA)",
        "Product Assembly",
        "Testing & Quality",
        "Mass Productions",
      ],
    ),
  ];
  // Accent colors cycled across the service cards for a bit of visual rhythm.
  static const List<Color> _serviceAccents = [
    tOrange1,
    tBlue3,
    tOrange1,
    tBlue3,
    tOrange1,
    tBlue3,
  ];
  // final List<_ClientItemData> _clients = const [
  //   _ClientItemData(image: "icons/tata.svg", name: "Tata Exlsi"),
  //   _ClientItemData(image: "icons/tata.svg", name: "fallback"),
  //   _ClientItemData(image: "icons/tata.svg", name: "fallback"),
  //   _ClientItemData(image: "icons/tata.svg", name: "fallback"),
  //   _ClientItemData(image: "icons/tata.svg", name: "fallback"),
  //   _ClientItemData(image: "icons/tata.svg", name: "fallback"),
  //   _ClientItemData(image: "icons/tata.svg", name: "fallback"),
  //   _ClientItemData(image: "icons/tata.svg", name: "fallback"),
  // ];

  final List<_ClientItemData> _clients = const [
    _ClientItemData(
      image: "icons/tata.svg",
      name: "Tata Exlsi",
      width: 100,
      height: 55,
    ),
    _ClientItemData(
      image: "icons/sp.svg",
      name: "Spiro",
      width: 90,
      height: 55,
    ),
    _ClientItemData(
      image: "icons/esync.svg",
      name: "eSync",
      width: 125,
      height: 75,
    ),
    _ClientItemData(
      image: "icons/tafe.svg",
      name: "TAFE",
      width: 95,
      height: 60,
    ),
    _ClientItemData(
      image: "icons/blueenergy.svg",
      name: "Blue Energy",
      width: 100,
      height: 60,
    ),
    _ClientItemData(
      image: "icons/neshlive.svg",
      name: "Neshlive",
      width: 100,
      height: 55,
    ),

    _ClientItemData(image: "icons/zf.svg", name: "ZF", width: 100, height: 55),
    //from heree
    _ClientItemData(
      image: "icons/jbm1.svg",
      name: "JBM",
      width: 100,
      height: 55,
    ),
    _ClientItemData(
      image: "icons/bajaj.svg",
      name: "Bajaj",
      width: 100,
      height: 55,
    ),
    _ClientItemData(
      image: "icons/jio.svg",
      name: "Jio",
      width: 100,
      height: 55,
    ),
    _ClientItemData(
      image: "icons/ampace.svg",
      name: "Ampace",
      width: 200,
      height: 100,
    ),
    _ClientItemData(
      image: "icons/fieldbee.svg",
      name: "Field Bee",
      width: 150,
      height: 100,
    ),
    _ClientItemData(
      image: "icons/enginecal.svg",
      name: "EngineCal",
      width: 100,
      height: 90,
    ),
    _ClientItemData(
      image: "icons/zippin.svg",
      name: "Zippin",
      width: 100,
      height: 90,
    ),
    _ClientItemData(
      image: "icons/trinetra.svg",
      name: "Trinetra",
      width: 100,
      height: 90,
    ),
    _ClientItemData(image: "icons/e3.svg", name: "E3", width: 100, height: 90),
  ];
  int? _hoveredServiceIndex;
  int? _hoveredIndustryIndex;
  final ScrollController _productsScrollController = ScrollController();
  final ScrollController _clientsScrollController = ScrollController();
  // Timer? _clientsAutoScrollTimer;
  late final AnimationController _clientsAutoScrollController;
  late final Ticker _clientsTicker;
  Duration _clientsLastElapsed = Duration.zero;
  double _clientsScrollOffset = 0.0;

  static const double _clientItemWidth = 200.0;
  static const double _clientSeparatorWidth = 24.0;
  static const double _clientsScrollSpeed = 40.0; // pixels per second
  static const int _maxFrameDeltaMs = 100; // caps any single jump
  void _scrollProducts(double delta) {
    final target = (_productsScrollController.offset + delta).clamp(
      0.0,
      _productsScrollController.position.maxScrollExtent,
    );
    _productsScrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _startClientsAutoScroll() {
    final singleSetWidth =
        _clients.length * (_clientItemWidth + _clientSeparatorWidth);

    _clientsTicker = createTicker((elapsed) {
      if (!_clientsScrollController.hasClients) return;

      final deltaMs = (elapsed - _clientsLastElapsed).inMilliseconds.clamp(
        0,
        _maxFrameDeltaMs,
      );
      _clientsLastElapsed = elapsed;

      _clientsScrollOffset += _clientsScrollSpeed * deltaMs / 1000;
      if (_clientsScrollOffset >= singleSetWidth) {
        _clientsScrollOffset -= singleSetWidth;
      }

      _clientsScrollController.jumpTo(_clientsScrollOffset);
    })..start();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startClientsAutoScroll();
    });
  }

  @override
  void dispose() {
    _productsScrollController.dispose();
    _clientsTicker.dispose();
    _clientsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: tWhite,
      // padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
      child: Column(
        children: [
          HomeReveal(
            delay: const Duration(milliseconds: 300),
            child: _buildServicesSection(),
          ),
          const SizedBox(height: 60),
          _buildIndustriesSection(),
          const SizedBox(height: 60),
          _buildProductsSection(),
          const SizedBox(height: 60),
          _buildClientsSection(),
        ],
      ),
    );
  }

  Widget _buildIndustriesSection() {
    return Column(
      children: [
        Text(
          "INDUSTRIES WE SERVE",
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Empowering Industries with Technology",
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            for (int i = 0; i < _industries.length; i++) ...[
              if (i != 0) const SizedBox(width: 12),
              Expanded(child: _buildIndustryCard(_industries[i], i)),
            ],
          ],
        ),
        const SizedBox(height: 28),
        _buildOutlinedButton(
          "View All Industries",
          onPressed: () => widget.onNavigate?.call(5), // Industries tab index
        ),
      ],
    );
  }

  Widget _buildIndustryCard(_IndustryItemData industry, int index) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoveredIndustryIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredIndustryIndex = null;
        });
      },
      child: AnimatedScale(
        scale: _hoveredIndustryIndex == index ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      industry.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              Container(color: tBlue3.withOpacity(0.15)),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tBlue3.withOpacity(0.9),
                      ),
                      child: Icon(industry.icon, color: tOrange1, size: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              industry.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: tBlue2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsSection() {
    return Column(
      children: [
        Text(
          "FEATURED PRODUCTS",
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Innovative Products for Smarter Tomorrow",
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildArrowButton(
              icon: Icons.chevron_left_rounded,
              onTap: () => _scrollProducts(-260),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 240,
                child: ListView.separated(
                  controller: _productsScrollController,
                  scrollDirection: Axis.horizontal,
                  // Space for the card shadow at top and bottom
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  clipBehavior: Clip.hardEdge,
                  itemCount: _products.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder:
                      (context, index) => SizedBox(
                        width: 220,
                        height: 210,
                        child: _buildProductCard(_products[index]),
                      ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            _buildArrowButton(
              icon: Icons.chevron_right_rounded,
              onTap: () => _scrollProducts(260),
            ),
          ],
        ),
        const SizedBox(height: 28),
        _buildOutlinedButton(
          "View All Products",
          onPressed: () => widget.onNavigate?.call(4), // Products tab index
        ),
      ],
    );
  }

  Widget _buildProductCard(_ProductItemData product) {
    return Container(
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: tBlue3.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Container(color: tBlue3.withOpacity(0.1)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: tBlue2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: tBlue2.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tWhite,
          border: Border.all(color: tBlue3, width: 1.2),
        ),
        child: Icon(icon, color: tBlue3, size: 20),
      ),
    );
  }

  Widget _buildOutlinedButton(String label, {VoidCallback? onPressed}) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: tBlue3, width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tBlue3,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_forward, size: 15, color: tBlue3),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Container(
      width: double.infinity,
      color: tWhite,
      // padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      child: Column(
        children: [
          Text(
            "OUR SERVICES",
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.manrope(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: tBlue2,
              ),
              children: [
                const TextSpan(text: "Complete Solutions Under "),
                TextSpan(
                  text: "One Roof",
                  style: GoogleFonts.manrope(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: tOrange1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "We offer end-to-end services to bring your ideas to life with innovation, precision and quality.",
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              color: tBlack,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 25),
          // const SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive: 6 across on wide screens, wraps on narrower ones.
                const spacing = 16.0;
                final isWide = constraints.maxWidth > 1000;
                final cardWidth =
                    isWide
                        ? (constraints.maxWidth - spacing * 5) / 6
                        : (constraints.maxWidth - spacing) / 2;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children:
                      _services
                          .asMap()
                          .entries
                          .map(
                            (entry) => SizedBox(
                              width: cardWidth,
                              child: _buildServiceCard(entry.value, entry.key),
                            ),
                          )
                          .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildServiceCard(_ServiceItemData service, int index) {
  //   return MouseRegion(
  //     onEnter: (_) {
  //       setState(() {
  //         _hoveredServiceIndex = index;
  //       });
  //     },
  //     onExit: (_) {
  //       setState(() {
  //         _hoveredServiceIndex = null;
  //       });
  //     },

  //     child: AnimatedScale(
  //       scale: _hoveredServiceIndex == index ? 1.03 : 1.0,
  //       duration: const Duration(milliseconds: 220),
  //       curve: Curves.easeOut,

  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 180),
  //         curve: Curves.easeOut,
  //         child: Container(
  //           padding: const EdgeInsets.all(20),
  //           decoration: BoxDecoration(
  //             color: tWhite,
  //             borderRadius: BorderRadius.circular(14),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: tBlue3.withOpacity(
  //                   _hoveredServiceIndex == index ? 0.30 : 0.20,
  //                 ),
  //                 blurRadius: _hoveredServiceIndex == index ? 18 : 12,
  //                 offset: Offset(0, _hoveredServiceIndex == index ? 7 : 4),
  //               ),
  //             ],
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 width: 48,
  //                 height: 48,
  //                 decoration: BoxDecoration(
  //                   color: tBlue.withOpacity(0.08),
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Center(
  //                   child: SvgPicture.asset(
  //                     service.icon,
  //                     width: 24,
  //                     height: 24,
  //                     colorFilter: const ColorFilter.mode(
  //                       tOrange1,
  //                       BlendMode.srcIn,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               Text(
  //                 service.title,
  //                 style: GoogleFonts.manrope(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w700,
  //                   color: tBlue2,
  //                 ),
  //               ),
  //               const SizedBox(height: 12),
  //               Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children:
  //                     service.points
  //                         .map(
  //                           (point) => Padding(
  //                             padding: const EdgeInsets.only(bottom: 6),
  //                             child: Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                     top: 6,
  //                                     right: 8,
  //                                   ),
  //                                   child: Container(
  //                                     width: 4,
  //                                     height: 4,
  //                                     decoration: const BoxDecoration(
  //                                       shape: BoxShape.circle,
  //                                       color: tBlack,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Text(
  //                                   point,
  //                                   style: GoogleFonts.manrope(
  //                                     fontSize: 12.5,
  //                                     fontWeight: FontWeight.w500,
  //                                     color: tBlack,
  //                                     height: 1.4,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                         .toList(),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildServiceCard(_ServiceItemData service, int index) {
    final bool isHovered = _hoveredServiceIndex == index;
    final Color accent = _serviceAccents[index % _serviceAccents.length];

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoveredServiceIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredServiceIndex = null;
        });
      },
      child: AnimatedScale(
        scale: isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isHovered
                      ? accent.withOpacity(0.55)
                      : tBlue3.withOpacity(0.08),
              width: 1.3,
            ),
            color: tWhite,
            boxShadow: [
              BoxShadow(
                color: (isHovered ? accent : tBlue3).withOpacity(
                  isHovered ? 0.22 : 0.12,
                ),
                blurRadius: isHovered ? 22 : 12,
                offset: Offset(0, isHovered ? 10 : 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: isHovered ? 5 : 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accent, accent.withOpacity(0.4)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                accent.withOpacity(isHovered ? 0.22 : 0.12),
                                accent.withOpacity(isHovered ? 0.10 : 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              service.icon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                accent,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 10),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            service.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: tBlue2,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Container(
                    //   width: 28,
                    //   height: 2.5,
                    //   margin: const EdgeInsets.only(bottom: 12),
                    //   decoration: BoxDecoration(
                    //     color: accent.withOpacity(0.5),
                    //     borderRadius: BorderRadius.circular(2),
                    //   ),
                    // ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          service.points
                              .map(
                                (point) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 6,
                                          right: 8,
                                        ),
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          size: 12,
                                          color: accent.withOpacity(0.75),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          point,
                                          style: GoogleFonts.manrope(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w500,
                                            color: tBlack,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 10),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: isHovered ? 1 : 0,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        offset: isHovered ? Offset.zero : const Offset(0, 0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientsSection() {
    return Column(
      children: [
        Text(
          "OUR CLIENTS",
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Trusted by Innovative Companies Worldwide",
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 100,
          child: ListView.separated(
            controller: _clientsScrollController,
            scrollDirection: Axis.horizontal,

            physics: const NeverScrollableScrollPhysics(),

            // Gives the logos some breathing space
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

            // Prevents the logo from being cut
            clipBehavior: Clip.none,

            itemCount: _clients.length * 3,

            separatorBuilder: (_, __) => const SizedBox(width: 24),

            itemBuilder: (context, index) {
              final client = _clients[index % _clients.length];

              return SizedBox(
                width: 200,
                height: 110,
                child: _buildClientCard(client),
              );
            },
          ),
        ),

        // const SizedBox(height: 5),

        // _buildOutlinedButton("View All Clients"),
      ],
    );
  }

  // Widget _buildClientCard(_ClientItemData client) {
  //   return Container(
  //     alignment: Alignment.center,
  //     child: SvgPicture.asset(
  //       client.image,
  //       width: 70,
  //       height: 70,
  //       placeholderBuilder:
  //           (context) => Text(
  //             client.name,
  //             textAlign: TextAlign.center,
  //             style: GoogleFonts.manrope(
  //               fontSize: 13,
  //               fontWeight: FontWeight.w700,
  //               color: tBlue3,
  //             ),
  //           ),
  //     ),
  //   );
  // }
  Widget _buildClientCard(_ClientItemData client) {
    return SizedBox(
      width: 500,
      height: 300,
      child: Center(
        child: SizedBox(
          width: client.width,
          height: client.height,
          child: SvgPicture.asset(
            client.image,
            width: client.width,
            height: client.height,
            fit: BoxFit.contain,
            alignment: Alignment.center,
            placeholderBuilder:
                (context) => Text(
                  client.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tBlue3,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
