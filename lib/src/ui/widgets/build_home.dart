import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/office_section.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

class _IndustryItemData {
  final String image;
  final String icon;
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

class _AnimatedOutlinedButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;

  const _AnimatedOutlinedButton({required this.label, this.onPressed});

  @override
  State<_AnimatedOutlinedButton> createState() =>
      _AnimatedOutlinedButtonState();
}

class _AnimatedOutlinedButtonState extends State<_AnimatedOutlinedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rippleController;

  late final Animation<double> _rippleScale;
  late final Animation<double> _rippleOpacity;

  bool _isAnimating = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _rippleScale = Tween<double>(begin: 0.0, end: 16.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOutCubic),
    );

    _rippleOpacity = Tween<double>(begin: 0.12, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (_isAnimating || widget.onPressed == null) return;

    setState(() {
      _isAnimating = true;
    });

    _rippleController.forward(from: 0.0);

    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    setState(() {
      _isAnimating = false;
    });

    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!_isHovered) {
          setState(() {
            _isHovered = true;
          });
        }
      },
      onExit: (_) {
        if (_isHovered) {
          setState(() {
            _isHovered = false;
          });
        }
      },
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          decoration: BoxDecoration(
            color: _isHovered ? tBlue3.withOpacity(0.035) : tWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: tBlue3, width: 1.2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // CLICK RIPPLE
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _rippleController,
                      builder: (context, child) {
                        return Center(
                          child: Opacity(
                            opacity: _rippleOpacity.value,
                            child: Transform.scale(
                              scale: _rippleScale.value,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: tBlue3,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // BUTTON CONTENT
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.label,
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: tBlue3,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 15, color: tBlue3),
                    ],
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

class IndustriesProductsSection extends StatefulWidget {
  final ValueChanged<int>? onNavigate;
  const IndustriesProductsSection({super.key, this.onNavigate});

  @override
  State<IndustriesProductsSection> createState() =>
      _IndustriesProductsSectionState();
}

class _IndustriesProductsSectionState extends State<IndustriesProductsSection>
    with TickerProviderStateMixin {
  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);
  bool get _isTouch => isMobile || isTablet;
  final List<_IndustryItemData> _industries = const [
    _IndustryItemData(
      image: "images/automotive.jpg",
      icon: "icons/car.svg",
      label: "Automotive",
    ),
    _IndustryItemData(
      image: "images/ev.jpg",
      icon: "icons/ev.svg",
      label: "EV Technology",
    ),
    _IndustryItemData(
      image: "images/fleet_logistics.jpg",
      icon: "icons/truck.svg",
      label: "Fleet & Logistics",
    ),
    _IndustryItemData(
      image: "images/industrial.jpg",
      icon: "icons/automation.svg",
      label: "Industrial",
    ),
    _IndustryItemData(
      image: "images/smartcity.jpg",
      icon: "icons/city.svg",
      label: "Smart Cities",
    ),
    _IndustryItemData(
      image: "images/agriculture.jpg",
      icon: "icons/agriculture.svg",
      label: "Agriculture",
    ),
    _IndustryItemData(
      image: "images/healthcare.png",
      icon: "icons/healthcare.svg",
      label: "Healthcare",
    ),
    _IndustryItemData(
      image: "images/supplychain.png",
      icon: "icons/supplychain.svg",
      label: "Supply Chain",
    ),
    _IndustryItemData(
      image: "images/retail1.png",
      icon: "icons/retail.svg",
      label: "Retail",
    ),
    _IndustryItemData(
      image: "images/energy.png",
      icon: "icons/utilities.svg",
      label: "Energy",
    ),
  ];
  late final List<ImageProvider> _industryProviders =
      _industries
          .map((e) => ResizeImage(AssetImage(e.image), width: 400))
          .toList();
  final List<_ProductItemData> _products = const [
    _ProductItemData(
      image: "images/tmd104(a).png",
      name: "TMD104",
      subtitle: "Advanced GPS Tracker",
    ),
    _ProductItemData(
      image: "images/tcu1550.png",
      name: "TCU550",
      subtitle: "Advanced Fleet Tracker",
    ),
    _ProductItemData(
      image: "images/tmdcstrr-5.png",
      name: "TMDCSTR-5",
      subtitle: "Intelligent Vehicle Cluster",
    ),
    _ProductItemData(
      image: "images/tmd400.png",
      name: "TMD400",
      subtitle: "Advanced OBD Tracker",
    ),
    _ProductItemData(
      image: "images/tmb024.png",
      name: "TMB024",
      subtitle: "Advanced Tracker",
    ),
    _ProductItemData(
      image: "images/tmdcstrr-7.png",
      name: "TMDCSTR-7",
      subtitle: "Smart Digital Cluster",
    ),
    _ProductItemData(
      image: "images/a2.png",
      name: "TMDCSTR-7A",
      subtitle: "Smart Vehicle Display",
    ),
    _ProductItemData(
      image: "images/tmd364-side1.png",
      name: "TMD364",
      subtitle: "Connected Vehicle Tracker",
    ),
  ];
  // Same size as cacheWidth used in the card, so precache == what is displayed
  late final List<ImageProvider> _productProviders =
      _products
          .map((e) => ResizeImage(AssetImage(e.image), width: 340))
          .toList();
  final List<_ServiceItemData> _services = const [
    _ServiceItemData(
      icon: "icons/product_engineering1.svg",
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
      icon: "icons/iot_solutions1.svg",
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

  final List<_ClientItemData> _clients = const [
    _ClientItemData(
      image: "icons/sp.svg",
      name: "Spiro",
      width: 90,
      height: 55,
    ),
    _ClientItemData(image: "icons/zf.svg", name: "ZF", width: 100, height: 55),
    _ClientItemData(
      image: "icons/cbak.svg",
      name: "cBak",
      width: 160,
      height: 100,
    ),
    _ClientItemData(
      image: "icons/greenway.svg",
      name: "Greenway",
      width: 150,
      height: 100,
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
      image: "icons/neshlive.svg",
      name: "Neshlive",
      width: 100,
      height: 55,
    ),
    _ClientItemData(
      image: "icons/jbm1.svg",
      name: "JBM",
      width: 100,
      height: 55,
    ),
    _ClientItemData(
      image: "icons/myjio.svg",
      name: "Jio",
      width: 100,
      height: 55,
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
  bool _industriesImagesLoaded = false;
  bool _productsImagesLoaded = false;
  final ScrollController _productsScrollController = ScrollController();
  final ScrollController _clientsScrollController = ScrollController();
  late final Ticker _clientsTicker;
  Duration _clientsLastElapsed = Duration.zero;
  double _clientsScrollOffset = 0.0;
  bool _isClientsHovered = false;
  static const double _clientsScrollSpeed = 40.0; // pixels per second
  static const int _maxFrameDeltaMs = 100; // caps any single jump
  final ScrollController _industriesScrollController = ScrollController();
  late final Ticker _industriesTicker;
  Duration _industriesLastElapsed = Duration.zero;
  double _industriesScrollOffset = 0.0;
  static const double _industriesScrollSpeed = 30.0; // pixels per second

  // ---- Responsive sizes (mobile values are smaller, tablet/desktop as before)
  double get _clientItemWidth => isMobile ? 150.0 : 200.0;
  double get _clientSeparatorWidth => isMobile ? 16.0 : 24.0;
  double get _industryItemWidth => isMobile ? 150.0 : 200.0;
  double get _industrySeparatorWidth => isMobile ? 10.0 : 12.0;

  void _scrollProducts(double delta) {
    if (!_productsScrollController.hasClients) return; // shimmer showing
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

  // ---- Mobile products: one card at a time, always centered ----
  static const double _mobileProductCardWidth = 180.0;
  static const double _mobileProductGap = 12.0;
  static const double _mobileProductStep =
      _mobileProductCardWidth + _mobileProductGap;
  int _mobileProductIndex = 0;

  void _animateToProductIndex(int index) {
    if (!_productsScrollController.hasClients) return;
    final int target = index.clamp(0, _products.length - 1);
    _mobileProductIndex = target;
    _productsScrollController.animateTo(
      target * _mobileProductStep,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  // Arrow tap: move exactly one card left (-1) or right (+1)
  void _scrollProductsMobile(int direction) {
    _animateToProductIndex(_mobileProductIndex + direction);
  }

  // After a swipe ends, settle on the nearest card so it sits in the middle
  void _snapProductsToNearest() {
    if (!_productsScrollController.hasClients) return;
    final double pixels = _productsScrollController.offset;
    final int nearest = (pixels / _mobileProductStep).round().clamp(
      0,
      _products.length - 1,
    );
    _mobileProductIndex = nearest;
    if ((pixels - nearest * _mobileProductStep).abs() > 1.0) {
      _animateToProductIndex(nearest);
    }
  }

  Widget _buildProductsList() {
    // ---------- MOBILE: snap-to-center, one card at a time ----------
    if (isMobile) {
      return LayoutBuilder(
        key: const ValueKey('products_list'),
        builder: (context, constraints) {
          // Side padding that lets the first and last cards reach the center
          final double sidePad =
              ((constraints.maxWidth - _mobileProductCardWidth) / 2).clamp(
                0.0,
                double.infinity,
              );

          return NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              if (notification.metrics.axis == Axis.horizontal) {
                _snapProductsToNearest();
              }
              return false;
            },
            child: ListView.separated(
              controller: _productsScrollController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: sidePad, vertical: 12),
              clipBehavior: Clip.hardEdge,
              itemCount: _products.length,
              separatorBuilder:
                  (_, __) => const SizedBox(width: _mobileProductGap),
              itemBuilder:
                  (context, index) => SizedBox(
                    width: _mobileProductCardWidth,
                    height: 210,
                    child: _buildProductCard(_products[index], index),
                  ),
            ),
          );
        },
      );
    }

    // ---------- TABLET / DESKTOP (unchanged) ----------
    return ListView.separated(
      key: const ValueKey('products_list'),
      controller: _productsScrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 12),
      clipBehavior: Clip.hardEdge,
      itemCount: _products.length,
      separatorBuilder: (_, __) => const SizedBox(width: 16),
      itemBuilder:
          (context, index) => SizedBox(
            width: 220,
            height: 210,
            child: _buildProductCard(_products[index], index),
          ),
    );
  }

  void _startClientsAutoScroll() {
    _clientsTicker = createTicker((elapsed) {
      if (!_clientsScrollController.hasClients) return;

      // PAUSE AUTO-SCROLL WHILE MOUSE IS OVER CLIENTS
      if (_isClientsHovered) {
        _clientsLastElapsed = elapsed;
        return;
      }

      // Computed every frame so it stays correct if the screen size changes
      final double singleSetWidth =
          _clients.length * (_clientItemWidth + _clientSeparatorWidth);

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

  void _startIndustriesAutoScroll() {
    _industriesTicker = createTicker((elapsed) {
      if (!_industriesScrollController.hasClients) return;
      // Tablet: stop the scroll while a tapped card is selected
      if (_isTouch && _hoveredIndustryIndex != null) {
        _industriesLastElapsed = elapsed;
        return;
      }
      final double singleSetWidth =
          _industries.length * (_industryItemWidth + _industrySeparatorWidth);

      final deltaMs = (elapsed - _industriesLastElapsed).inMilliseconds.clamp(
        0,
        _maxFrameDeltaMs,
      );
      _industriesLastElapsed = elapsed;

      _industriesScrollOffset += _industriesScrollSpeed * deltaMs / 1000;
      if (_industriesScrollOffset >= singleSetWidth) {
        _industriesScrollOffset -= singleSetWidth;
      }

      _industriesScrollController.jumpTo(_industriesScrollOffset);
    })..start();
  }

  Future<void> _preloadIndustryImages() async {
    await Future.wait(
      _industryProviders.map(
        (provider) => precacheImage(
          provider,
          context,
          onError: (e, s) => debugPrint('Failed to load $e'),
        ),
      ),
    );

    if (!mounted) return;
    setState(() => _industriesImagesLoaded = true);
  }

  Future<void> _preloadProductImages() async {
    try {
      await Future.wait(
        _productProviders.map(
          (provider) => precacheImage(
            provider,
            context,
            onError: (e, s) => debugPrint('Failed to load product image: $e'),
          ),
        ),
      ).timeout(const Duration(seconds: 10)); // never stay stuck on shimmer
    } catch (e) {
      // ignore
    }

    if (!mounted) return;
    setState(() => _productsImagesLoaded = true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startClientsAutoScroll();
      _startIndustriesAutoScroll();
      _preloadIndustryImages();
      _preloadProductImages();
    });
  }

  @override
  void dispose() {
    _productsScrollController.dispose();
    _clientsTicker.dispose();
    _clientsScrollController.dispose();
    _industriesTicker.dispose();
    _industriesScrollController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Shared heading helpers (mobile = smaller type, tablet/desktop unchanged)
  // ---------------------------------------------------------------------------
  Widget _sectionLabel(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.manrope(
        fontSize: isMobile ? 12 : 13,
        fontWeight: FontWeight.w700,
        color: tOrange1,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.manrope(
        fontSize: isMobile ? 20 : 25,
        fontWeight: FontWeight.w700,
        color: tBlue2,
        height: isMobile ? 1.25 : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = isMobile;
    final double sectionGap = mobile ? 40 : 60;

    return Container(
      width: double.infinity,
      color: tWhite,
      padding: EdgeInsets.only(
        left: mobile ? 16 : (isTablet ? 24 : 40),
        right: mobile ? 16 : (isTablet ? 24 : 40),
        top: mobile ? 24 : 30,
      ),
      child: Column(
        children: [
          _buildServicesSection(),
          SizedBox(height: sectionGap),
          _buildIndustriesSection(),
          SizedBox(height: sectionGap),
          _buildProductsSection(),
          SizedBox(height: sectionGap),
          // OfficesSection(),
          // SizedBox(height: sectionGap),
          _buildClientsSection(),
        ],
      ),
    );
  }

  // INDUSTRIES

  Widget _buildIndustriesSection() {
    final bool mobile = isMobile;

    return Column(
      children: [
        _sectionLabel("INDUSTRIES WE SERVE"),
        const SizedBox(height: 8),
        _sectionTitle("Empowering Industries with Technology"),
        SizedBox(height: mobile ? 20 : 25),
        SizedBox(
          height: mobile ? 205 : 240, // card height
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child:
                !_industriesImagesLoaded
                    ? const IndustriesShimmer(
                      key: ValueKey('industries_shimmer'),
                    )
                    : ListView.separated(
                      key: const ValueKey('industries_list'),
                      controller: _industriesScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      cacheExtent: 1000,
                      itemCount: _industries.length * 3,
                      separatorBuilder:
                          (_, __) => SizedBox(width: _industrySeparatorWidth),
                      itemBuilder: (context, index) {
                        final industry =
                            _industries[index % _industries.length];
                        return SizedBox(
                          width: _industryItemWidth,
                          child: _buildIndustryCard(
                            industry,
                            index % _industries.length,
                          ),
                        );
                      },
                    ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndustryCard(_IndustryItemData industry, int index) {
    // final bool mobile = isMobile;

    return MouseRegion(
      onEnter: (_) {
        if (_isTouch) return;
        setState(() => _hoveredIndustryIndex = index);
      },
      onExit: (_) {
        if (_isTouch) return;
        setState(() => _hoveredIndustryIndex = null);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:
            _isTouch
                ? () => setState(() {
                  _hoveredIndustryIndex =
                      _hoveredIndustryIndex == index ? null : index;
                })
                : null,
        child: AnimatedScale(
          scale: _hoveredIndustryIndex == index ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned.fill(
                        child: Image(
                          image: _industryProviders[index],
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          frameBuilder: (
                            context,
                            child,
                            frame,
                            wasSynchronouslyLoaded,
                          ) {
                            if (wasSynchronouslyLoaded) return child;
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                if (frame == null)
                                  const ShimmerBox(height: double.infinity),
                                AnimatedOpacity(
                                  opacity: frame == null ? 0 : 1,
                                  duration: const Duration(milliseconds: 300),
                                  child: child,
                                ),
                              ],
                            );
                          },
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  Container(color: tBlue3.withOpacity(0.15)),
                        ),
                      ),
                      Positioned(
                        left: isMobile ? 8 : 10,
                        bottom: isMobile ? 8 : 10,
                        child: Container(
                          width: isMobile ? 40 : 48,
                          height: isMobile ? 40 : 48,
                          decoration: BoxDecoration(
                            color: index.isEven ? tBlue2 : tOrange1,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: tBlack.withOpacity(0.18),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              industry.icon,
                              width: isMobile ? 21 : 25,
                              height: isMobile ? 21 : 25,
                              fit: BoxFit.contain,
                              color: tWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 8 : 10),
              Text(
                industry.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  fontSize: isMobile ? 12 : 12.5,
                  fontWeight: FontWeight.w600,
                  color: tBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PRODUCTS
  // ---------------------------------------------------------------------------
  Widget _buildProductsSection() {
    final bool mobile = isMobile;

    return Column(
      children: [
        _sectionLabel("FEATURED PRODUCTS"),
        const SizedBox(height: 8),
        _sectionTitle("Innovative Products for Smarter Tomorrow"),
        SizedBox(height: mobile ? 12 : 20),
        Row(
          children: [
            _buildArrowButton(
              icon: Icons.chevron_left_rounded,
              onTap:
                  () =>
                      mobile
                          ? _scrollProductsMobile(-1)
                          : _scrollProducts(-260),
            ),
            SizedBox(width: mobile ? 4 : (isTablet ? 2 : 12)),
            Expanded(
              child: SizedBox(
                height: 240,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child:
                      !_productsImagesLoaded
                          ? const FeaturedProductsShimmer(
                            key: ValueKey('products_shimmer'),
                          )
                          : _buildProductsList(),
                ),
              ),
            ),
            SizedBox(width: mobile ? 4 : (isTablet ? 2 : 12)),
            _buildArrowButton(
              icon: Icons.chevron_right_rounded,
              onTap:
                  () =>
                      mobile ? _scrollProductsMobile(1) : _scrollProducts(260),
            ),
          ],
        ),
        SizedBox(height: mobile ? 20 : 28),
        _AnimatedOutlinedButton(
          label: "View All Products",
          onPressed: () {
            widget.onNavigate?.call(3);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(_ProductItemData product, int index) {
    // final bool mobile = _isMobile;
    final double imgW = isMobile ? 140 : 170;
    final double imgH = isMobile ? 110 : 130;

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
      padding: EdgeInsets.all(isMobile ? 14 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Center(
                child: Image(
                  image: _productProviders[index],
                  fit: BoxFit.contain,
                  width: imgW,
                  height: imgH,
                  gaplessPlayback: true,
                  frameBuilder: (
                    context,
                    child,
                    frame,
                    wasSynchronouslyLoaded,
                  ) {
                    if (wasSynchronouslyLoaded) return child;
                    return SizedBox(
                      width: imgW,
                      height: imgH,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (frame == null)
                            const ShimmerBox(
                              height: double.infinity,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(milliseconds: 300),
                            child: child,
                          ),
                        ],
                      ),
                    );
                  },
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Container(color: tBlue3.withOpacity(0.1)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

  // ---------------------------------------------------------------------------
  // SERVICES
  // ---------------------------------------------------------------------------
  Widget _buildServicesSection() {
    final bool mobile = isMobile;

    return Container(
      width: double.infinity,
      color: tWhite,
      child: Column(
        children: [
          _sectionLabel("OUR SERVICES"),
          const SizedBox(height: 5),
          _sectionTitle("Complete Solutions Under One Roof"),
          const SizedBox(height: 4),
          Text(
            "We offer end-to-end services to bring your ideas to life with innovation, precision and quality.",
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              color: tBlack,
              fontSize: mobile ? 12.5 : 13,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: mobile ? 20 : 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mobile ? 0 : 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 16.0;
                final double w = constraints.maxWidth;

                // Mobile: 1 column on phones, 2 on very wide phones / foldables.
                // Tablet / desktop: 6 across on wide screens, 3 or 2 below that.
                final int columns =
                    mobile
                        ? (w >= 560 ? 2 : 1)
                        : (w > 1000 ? 6 : (w >= 760 ? 3 : 2));

                final double cardWidth =
                    (((w - spacing * (columns - 1)) / columns).floorToDouble())
                        .clamp(0.0, double.infinity);
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

  Widget _buildServiceCard(_ServiceItemData service, int index) {
    final bool mobile = isMobile;
    final bool isHovered = _hoveredServiceIndex == index;
    final Color accent = _serviceAccents[index % _serviceAccents.length];

    return MouseRegion(
      onEnter: (_) {
        if (_isTouch) return;
        setState(() => _hoveredServiceIndex = index);
      },
      onExit: (_) {
        if (_isTouch) return;
        setState(() => _hoveredServiceIndex = null);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:
            _isTouch
                ? () => setState(() {
                  _hoveredServiceIndex =
                      _hoveredServiceIndex == index ? null : index;
                })
                : null,
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
                  padding:
                      mobile
                          ? const EdgeInsets.fromLTRB(18, 18, 18, 14)
                          : const EdgeInsets.fromLTRB(20, 22, 20, 20),
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
                          SizedBox(width: mobile ? 16 : 20),
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
                      SizedBox(height: mobile ? 12 : 15),
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
                      SizedBox(height: mobile ? 4 : 10),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 220),
                        opacity: isHovered ? 1 : 0,
                        child: AnimatedSlide(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          offset:
                              isHovered ? Offset.zero : const Offset(0, 0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CLIENTS
  // ---------------------------------------------------------------------------
  Widget _buildClientsSection() {
    // final bool mobile = _isMobile;

    return Column(
      children: [
        _sectionLabel("OUR CLIENTS"),
        const SizedBox(height: 8),
        _sectionTitle("Trusted by Innovative Companies Worldwide"),
        SizedBox(height: isMobile ? 12 : 5),
        MouseRegion(
          onEnter: (_) {
            if (_isTouch) return;
            setState(() => _isClientsHovered = true);
          },
          onExit: (_) {
            if (_isTouch) return;
            setState(() => _isClientsHovered = false);
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap:
                _isTouch
                    ? () =>
                        setState(() => _isClientsHovered = !_isClientsHovered)
                    : null,
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                controller: _clientsScrollController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                // Prevents the logo from being cut
                clipBehavior: Clip.none,
                itemCount: _clients.length * 3,
                separatorBuilder:
                    (_, __) => SizedBox(width: _clientSeparatorWidth),
                itemBuilder: (context, index) {
                  final client = _clients[index % _clients.length];

                  return SizedBox(
                    width: _clientItemWidth,
                    height: isMobile ? 85 : 110,
                    child: _buildClientCard(client),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClientCard(_ClientItemData client) {
    // Logos are scaled down a little on mobile
    final double scale = isMobile ? 0.75 : 1.0;
    final double logoW = client.width * scale;
    final double logoH = client.height * scale;

    return SizedBox(
      width: 500,
      height: 300,
      child: Center(
        child: SizedBox(
          width: logoW,
          height: logoH,
          child: SvgPicture.asset(
            client.image,
            width: logoW,
            height: logoH,
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
