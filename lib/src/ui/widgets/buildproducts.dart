import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class BuildProductSection extends StatefulWidget {
  const BuildProductSection({super.key});

  @override
  State<BuildProductSection> createState() => _BuildProductSectionState();
}

class _BuildProductSectionState extends State<BuildProductSection> {
  int _selectedFilterIndex = 0;
  final GlobalKey _productsGridKey = GlobalKey();

  final List<_FilterTabData> _filterTabs = const [
    _FilterTabData(icon: Icons.grid_view_rounded, label: 'All Products'),
    _FilterTabData(icon: Icons.developer_board_rounded, label: 'IoT Devices'),
    _FilterTabData(icon: Icons.router_rounded, label: 'Gateways'),
    _FilterTabData(icon: Icons.gps_fixed_rounded, label: 'Trackers'),
    _FilterTabData(icon: Icons.memory_rounded, label: 'Embedded Modules'),
    _FilterTabData(icon: Icons.sensors_rounded, label: 'Sensors'),
    _FilterTabData(icon: Icons.build_rounded, label: 'Accessories'),
  ];

  final List<_ProductData> _products = const [
    _ProductData(
      image: 'images/trackx4G.png',
      badge: '4G',
      badgeColor: tBlue3,
      title: 'TMD024 / TMD004',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          'Compact 4G LTE tracker with real-time tracking, geo-fencing, and driver behavior monitoring.',
      features: [
        _ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        _ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        _ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    _ProductData(
      image: 'images/trackx4G.png',
      badge: 'NEW',
      badgeColor: newbadge,
      title: 'TMD006',
      subtitle: 'Industrial IoT Gateway',
      category: 'Gateways',
      description:
          'Powerful gateway for seamless data collection, protocol conversion and cloud connectivity.',
      features: [
        _ProductFeature(icon: Icons.hub_outlined, label: 'Multi-Protocol'),
        _ProductFeature(
          icon: Icons.developer_board_outlined,
          label: 'Edge Computing',
        ),
        _ProductFeature(icon: Icons.lock_outline, label: 'Secure MQTT'),
      ],
    ),
    _ProductData(
      image: 'images/trackx4G.png',
      badge: null,
      badgeColor: null,
      title: 'TMD364',
      subtitle: 'Embedded Controller',
      category: 'Embedded Modules',
      description:
          'High-performance embedded controller for industrial and IoT applications.',
      features: [
        _ProductFeature(icon: Icons.speed_rounded, label: 'High Performance'),
        _ProductFeature(icon: Icons.battery_saver_outlined, label: 'Low Power'),
        _ProductFeature(
          icon: Icons.settings_input_component_outlined,
          label: 'Multiple Interfaces',
        ),
      ],
    ),
    _ProductData(
      image: 'images/trackx4G.png',
      badge: null,
      badgeColor: null,
      title: 'TMD500 / TMD520-TMD510',
      subtitle: 'Smart IoT Sensor',
      category: 'Sensors',
      description:
          'Multi-parameter sensor for environment, asset and condition monitoring.',
      features: [
        _ProductFeature(icon: Icons.thermostat_outlined, label: 'Temperature'),
        _ProductFeature(icon: Icons.water_drop_outlined, label: 'Humidity'),
        _ProductFeature(
          icon: Icons.directions_run_rounded,
          label: 'Motion & More',
        ),
      ],
    ),
    _ProductData(
      image: 'images/trackx4G.png',
      badge: 'IP67',
      badgeColor: ipbadge,
      title: 'TMD320 / TMD310',
      subtitle: 'Vehicle Diagnostics',
      category: 'Trackers',
      description:
          'Plug & Play OBD-II tracker for vehicle diagnostics and real-time telemetry.',
      features: [
        _ProductFeature(icon: Icons.usb_rounded, label: 'OBD-II Interface'),
        _ProductFeature(
          icon: Icons.directions_car_outlined,
          label: 'Vehicle Data',
        ),
        _ProductFeature(
          icon: Icons.build_circle_outlined,
          label: 'Easy Installation',
        ),
      ],
    ),
    _ProductData(
      image: 'images/trackx4G.png',
      badge: '4G',
      badgeColor: tBlue3,
      title: '5-inch cluster-TFT',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          'Compact 4G LTE tracker with real-time tracking, geo-fencing, and driver behavior monitoring.',
      features: [
        _ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        _ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        _ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    _ProductData(
      image: 'images/trackx4G.png',
      badge: '4G',
      badgeColor: tBlue3,
      title: '7-inch cluster-Android',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          'Compact 4G LTE tracker with real-time tracking, geo-fencing, and driver behavior monitoring.',
      features: [
        _ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        _ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        _ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    _ProductData(
      image: 'images/trackx4G.png',
      badge: '4G',
      badgeColor: tBlue3,
      title: 'TMD410',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          'Compact 4G LTE tracker with real-time tracking, geo-fencing, and driver behavior monitoring.',
      features: [
        _ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        _ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        _ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
  ];

  final List<_CategoryData> _categories = const [
    _CategoryData(
      image: 'images/company.jpg',
      title: 'IoT Devices',
      description: 'Connected devices for monitoring & control',
    ),
    _CategoryData(
      image: 'images/company.jpg',
      title: 'Gateways',
      description: 'Reliable connectivity & data aggregation',
    ),
    _CategoryData(
      image: 'images/company.jpg',
      title: 'Trackers',
      description: 'Real-time tracking & asset visibility',
    ),
    _CategoryData(
      image: 'assets/images/categories/embedded_modules.jpg',
      title: 'Embedded Modules',
      description: 'Powerful modules for custom applications',
    ),
    _CategoryData(
      image: 'images/company.jpg',
      title: 'Sensors',
      description: 'Smart sensors for every environment',
    ),
    _CategoryData(
      image: 'images/company.jpg',
      title: 'Accessories',
      description: 'Add-ons for installation & integration',
    ),
  ];

  final List<_TrustItemData> _trustItems = const [
    _TrustItemData(
      icon: Icons.verified_outlined,
      title: 'Quality Assured',
      description: 'Rigorous testing for reliability & durability',
    ),
    _TrustItemData(
      icon: Icons.shield_outlined,
      title: 'Secure by Design',
      description: 'Built-in security for data & device protection',
    ),
    _TrustItemData(
      icon: Icons.public_rounded,
      title: 'Global Standards',
      description: 'Compliant with international quality',
    ),
    _TrustItemData(
      icon: Icons.settings_suggest_outlined,
      title: 'Made for Integration',
      description: 'Easy to integrate with your systems & platforms',
    ),
  ];

  List<_ProductData> get _filteredProducts {
    final selectedLabel = _filterTabs[_selectedFilterIndex].label;
    if (selectedLabel == 'All Products') return _products;
    return _products.where((p) => p.category == selectedLabel).toList();
  }

  int _countForLabel(String label) {
    if (label == 'All Products') return _products.length;
    return _products.where((p) => p.category == label).length;
  }

  void _selectFilterIndex(int index) {
    if (index == _selectedFilterIndex) return;

    setState(() => _selectedFilterIndex = index);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _productsGridKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      }
    });
  }

  void _selectCategory(String label) {
    final index = _filterTabs.indexWhere((tab) => tab.label == label);
    if (index != -1) _selectFilterIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),

        Transform.translate(
          offset: const Offset(0, -40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _buildFilterTabsBar(),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              _buildProductRangeHeader(),
              const SizedBox(height: 38),
              _buildProductsGrid(),
              const SizedBox(height: 55),
            ],
          ),
        ),
        //hereee
        _buildHowProductsWorkTogether(),

        // _buildCategoriesSection(),
        const SizedBox(height: 45),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _buildTrustBar(),
        ),
      ],
    );
  }

  // FILTER TABS BAR
  Widget _buildFilterTabsBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.12),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_filterTabs.length, (index) {
            final tab = _filterTabs[index];
            final bool isSelected = index == _selectedFilterIndex;
            final int count = _countForLabel(tab.label);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => _selectFilterIndex(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      gradient:
                          isSelected
                              ? LinearGradient(colors: [tBlue2, tBlue3])
                              : null,
                      color: isSelected ? null : tBlack1.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: tBlue3.withOpacity(0.30),
                                  blurRadius: 14,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                              : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tab.icon,
                          size: 15,
                          color: isSelected ? tWhite : tBlack.withOpacity(0.55),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          tab.label,
                          style: GoogleFonts.manrope(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color:
                                isSelected ? tWhite : tBlack.withOpacity(0.68),
                          ),
                        ),
                        const SizedBox(width: 6),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? tWhite.withOpacity(0.22)
                                    : tBlack.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$count',
                            style: GoogleFonts.manrope(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color:
                                  isSelected
                                      ? tWhite
                                      : tBlack.withOpacity(0.55),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProductRangeHeader() {
    return Column(
      children: [
        Text(
          'OUR PRODUCT RANGE',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Smart Products for a Connected World',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: tBlack,
          ),
        ),

        const SizedBox(height: 14),

        Container(width: 60, height: 3, color: tOrange1),
      ],
    );
  }

  Widget _buildProductsGrid() {
    final products = _filteredProducts;

    return AnimatedSwitcher(
      key: _productsGridKey,
      duration: const Duration(milliseconds: 250),
      child:
          products.isEmpty
              ? _buildEmptyState()
              : _ProductCarousel(
                key: ValueKey(_selectedFilterIndex),
                products: products,
              ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      key: const ValueKey('empty'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 36,
            color: tBlack.withOpacity(0.25),
          ),
          const SizedBox(height: 12),
          Text(
            'No products found in this category yet.',
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tBlack.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  // EXPLORE CATEGORIES
  Widget _buildCategoriesSection() {
    return Container(
      width: double.infinity,
      color: tBlue1.withOpacity(0.06),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 45),
      child: Column(
        children: [
          Text(
            'Explore Our Product Categories',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: tBlack,
            ),
          ),

          const SizedBox(height: 30),

          Row(
            children: List.generate(_categories.length, (index) {
              final isLast = index == _categories.length - 1;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 14),
                  child: _buildCategoryCard(_categories[index]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(_CategoryData data) {
    return Container(
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 90,
            child: Image.asset(
              data.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: tBlack.withOpacity(0.05),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 26,
                    color: tBlack.withOpacity(0.3),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: tBlack,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  data.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: tBlack.withOpacity(0.55),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 10),

                InkWell(
                  onTap: () => _selectCategory(data.title),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Explore',
                        style: GoogleFonts.manrope(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: tBlue3,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 12,
                        color: tBlue3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TRUST BAR
  Widget _buildTrustBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tBlue2,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: List.generate(_trustItems.length, (index) {
                final isLast = index == _trustItems.length - 1;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : 14),
                    child: _buildTrustItem(_trustItems[index]),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            flex: 3,
            child: Container(
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: tWhite.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                "icons/world_map.svg",
                height: 80,
                color: tBlue.withOpacity(0.2),
              ),
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trusted by businesses worldwide to build connected, intelligent and future-ready solutions.',
                  style: GoogleFonts.manrope(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: tWhite.withOpacity(0.85),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tBlue1,
                    foregroundColor: tWhite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Talk to Our Expert',
                    style: GoogleFonts.manrope(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
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

  Widget _buildTrustItem(_TrustItemData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(data.icon, size: 26, color: tOrange1),

        const SizedBox(height: 10),

        Text(
          data.title,
          style: GoogleFonts.manrope(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: tWhite,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          data.description,
          style: GoogleFonts.manrope(
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            color: tWhite.withOpacity(0.7),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _ProductCarousel extends StatefulWidget {
  final List<_ProductData> products;

  const _ProductCarousel({required Key key, required this.products})
    : super(key: key);

  @override
  State<_ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<_ProductCarousel> {
  static const double _cardWidth = 270;
  static const double _cardSpacing = 16;
  static const double _cardHeight = 420;

  static const double _arrowSize = 40;
  static const double _arrowSideSpace = 18;

  final ScrollController _scrollController = ScrollController();

  bool _showArrows = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateArrowVisibility();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _ProductCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (_scrollController.hasClients &&
          _scrollController.positions.length == 1) {
        _scrollController.jumpTo(0);
      }

      _updateArrowVisibility();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _contentWidth() {
    if (widget.products.isEmpty) return 0;

    return (widget.products.length * _cardWidth) +
        ((widget.products.length - 1) * _cardSpacing);
  }

  void _updateArrowVisibility() {
    if (!mounted) return;

    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox ||
        !renderObject.hasSize ||
        renderObject.size.width <= 0) {
      return;
    }

    final totalWidth = renderObject.size.width;

    // First determine whether the products overflow the normal
    // full-width card area.
    final shouldShow = _contentWidth() > totalWidth + 1;

    if (_showArrows != shouldShow) {
      setState(() {
        _showArrows = shouldShow;
      });
    }
  }

  void _scrollBy(double delta) {
    if (!_scrollController.hasClients) return;
    if (_scrollController.positions.length != 1) return;

    final position = _scrollController.position;

    final target = (_scrollController.offset + delta).clamp(
      0.0,
      position.maxScrollExtent,
    );

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;

        final double sideGutter =
            _showArrows ? _arrowSize + _arrowSideSpace : 0;

        final double availableCardWidth = (totalWidth - (sideGutter * 2)).clamp(
          0.0,
          totalWidth,
        );

        const double step = _cardWidth + _cardSpacing;

        final int cardsPerPage = ((availableCardWidth + _cardSpacing) / step)
            .floor()
            .clamp(1, products.length);

        final double cardViewportWidth =
            (cardsPerPage * _cardWidth) + ((cardsPerPage - 1) * _cardSpacing);

        final double pageDelta = step * cardsPerPage;

        return SizedBox(
          width: double.infinity,
          height: _cardHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: sideGutter,
                right: sideGutter,
                top: 0,
                bottom: 0,
                child: ClipRect(
                  child: ListView.separated(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: products.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: _cardSpacing);
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: _cardWidth,
                        child: _ProductCard(data: products[index]),
                      );
                    },
                  ),
                ),
              ),

              if (_showArrows)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _buildArrowButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () => _scrollBy(-pageDelta),
                    ),
                  ),
                ),

              if (_showArrows)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _buildArrowButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: () => _scrollBy(pageDelta),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: _arrowSize,
          height: _arrowSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tWhite,
            border: Border.all(color: tBlue3, width: 1),
            boxShadow: [
              BoxShadow(
                color: tBlack.withOpacity(0.10),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, size: 23, color: tBlue3),
        ),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final _ProductData data;

  const _ProductCard({required this.data});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _hovering = false;

  void _setHovering(bool value) {
    if (_hovering == value) return;
    setState(() => _hovering = value);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return MouseRegion(
      onEnter: (_) => _setHovering(true),
      onExit: (_) => _setHovering(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform:
            Matrix4.identity()
              ..translate(0.0, _hovering ? -8.0 : 0.0)
              ..scale(_hovering ? 1.03 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tBlack1.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(_hovering ? 0.16 : 0.05),
              blurRadius: _hovering ? 26 : 14,
              offset: Offset(0, _hovering ? 14 : 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Image.asset(
                    data.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: tBlack.withOpacity(0.05),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 32,
                          color: tBlack.withOpacity(0.3),
                        ),
                      );
                    },
                  ),
                ),

                if (data.badge != null)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: data.badgeColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data.badge!,
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: tWhite,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: tBlack,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    data.subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: tBlack.withOpacity(0.5),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    data.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: tBlack.withOpacity(0.6),
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...data.features.map(_buildFeatureItem),

                  const SizedBox(height: 6),

                  // InkWell(
                  //   onTap: () {},
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Text(
                  //         'View Details',
                  //         style: GoogleFonts.manrope(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w700,
                  //           color: tBlue3,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 4),
                  //       Icon(
                  //         Icons.arrow_forward_rounded,
                  //         size: 14,
                  //         color: tBlue3,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(_ProductFeature feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(feature.icon, size: 13, color: tBlue3),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              feature.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: tBlack.withOpacity(0.65),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildHowProductsWorkTogether() {
  final steps = [
    (
      number: '01',
      title: 'Sensors',
      description: 'Collect real-time data from the environment.',
      icon: Icons.sensors_rounded,
    ),
    (
      number: '02',
      title: 'Devices',
      description: 'Capture and process data from connected assets.',
      icon: Icons.devices_other_rounded,
    ),
    (
      number: '03',
      title: 'Gateways',
      description: 'Connect devices and securely transmit data.',
      icon: Icons.router_rounded,
    ),
    (
      number: '04',
      title: 'Cloud',
      description: 'Store and manage connected data centrally.',
      icon: Icons.cloud_outlined,
    ),
    (
      number: '05',
      title: 'Insights',
      description: 'Turn real-time data into actionable insights.',
      icon: Icons.insights_rounded,
    ),
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Column(
      children: [
        Text(
          'HOW OUR PRODUCTS WORK TOGETHER',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'From Data to Decisions',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: tBlack,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Connect devices, collect real-time data and turn it into actionable insights.',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.55),
          ),
        ),

        const SizedBox(height: 38),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(steps.length, (index) {
            final step = steps[index];

            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildIoTFlowCard(
                      number: step.number,
                      title: step.title,
                      description: step.description,
                      icon: step.icon,
                    ),
                  ),

                  if (index != steps.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 22,
                        color: tBlue3.withOpacity(0.22),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _buildIoTFlowCard({
  required String number,
  required String title,
  required String description,
  required IconData icon,
}) {
  return Container(
    height: 105,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      color: tWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tBlue3.withOpacity(0.10), width: 1),
      boxShadow: [
        BoxShadow(
          color: tBlue3.withOpacity(0.035),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: tBlue3,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: tBlue3.withOpacity(0.18),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: tWhite,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: tBlack,
                        ),
                      ),
                    ),

                    const SizedBox(width: 4),

                    // Icon(icon, size: 18, color: tBlue3.withOpacity(0.75)),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: tBlack.withOpacity(0.55),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _FilterTabData {
  final IconData icon;
  final String label;

  const _FilterTabData({required this.icon, required this.label});
}

class _ProductData {
  final String image;
  final String? badge;
  final Color? badgeColor;
  final String title;
  final String subtitle;
  final String category;
  final String description;
  final List<_ProductFeature> features;

  const _ProductData({
    required this.image,
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.description,
    required this.features,
  });
}

class _ProductFeature {
  final IconData icon;
  final String label;

  const _ProductFeature({required this.icon, required this.label});
}

class _CategoryData {
  final String image;
  final String title;
  final String description;

  const _CategoryData({
    required this.image,
    required this.title,
    required this.description,
  });
}

class _TrustItemData {
  final IconData icon;
  final String title;
  final String description;

  const _TrustItemData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
