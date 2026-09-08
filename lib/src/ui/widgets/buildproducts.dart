import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/process_section.dart';
import 'package:trakmate_portal/src/ui/widgets/product_details.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class BuildProductSection extends StatefulWidget {
  final Widget header;

  const BuildProductSection({super.key, required this.header});

  @override
  State<BuildProductSection> createState() => _BuildProductSectionState();
}

class _BuildProductSectionState extends State<BuildProductSection> {
  int _selectedFilterIndex = 0;
  bool _imagesLoading = true;
  final List<_FilterTabData> _filterTabs = const [
    _FilterTabData(icon: "icons/all.svg", label: 'All Products'),
    _FilterTabData(icon: "icons/trackers.svg", label: 'Vehicle Trackers'),
    _FilterTabData(icon: "icons/gateway.svg", label: 'Gateways'),
    _FilterTabData(icon: "icons/iot.svg", label: 'Clusters'),
    _FilterTabData(icon: "icons/car.svg", label: 'ADAS'),
  ];

  final List<ProductData> _products = const [
    ProductData(
      image: 'images/tmd104.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD104',
      subtitle: 'Advanced GPS Tracker',
      category: 'Vehicle Trackers',
      description:
          '4G LTE modem with 2G fallback, real-time tracking, geo-fencing, and  monitoring.',
      features: [
        ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    ProductData(
      image: 'images/tmd104.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD004',
      subtitle: 'Advanced GPS Tracker',
      category: 'Vehicle Trackers',
      description:
          '4G LTE modem with datalogging, CAN/BMS monitoring, BLE sensor integration, and FOTA support.',
      features: [
        ProductFeature(icon: Icons.hub_outlined, label: 'Multi-Protocol'),
        ProductFeature(
          icon: Icons.developer_board_outlined,
          label: 'Edge Computing',
        ),
        ProductFeature(icon: Icons.lock_outline, label: 'Secure MQTT'),
      ],
    ),
    ProductData(
      image: 'images/tmd104.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD024',
      subtitle: 'Advanced GPS Tracker',
      category: 'Vehicle Trackers',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      features: [
        ProductFeature(icon: Icons.hub_outlined, label: 'Multi-Protocol'),
        ProductFeature(
          icon: Icons.developer_board_outlined,
          label: 'Edge Computing',
        ),
        ProductFeature(icon: Icons.lock_outline, label: 'Secure MQTT'),
      ],
    ),
    ProductData(
      image: 'images/tmb024.png',
      badge: 'new',
      badgeColor: newbadge,
      title: 'TMB024',
      subtitle: 'Advanced GPS Tracker',
      category: 'Vehicle Trackers',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      features: [
        ProductFeature(icon: Icons.thermostat_outlined, label: 'Temperature'),
        ProductFeature(icon: Icons.water_drop_outlined, label: 'Humidity'),
        ProductFeature(
          icon: Icons.directions_run_rounded,
          label: 'Motion & More',
        ),
      ],
    ),

    ProductData(
      image: 'images/tmd400.png',
      badge: "OBD-II",
      badgeColor: ipbadge,
      title: 'TMD400',
      subtitle: 'Industrial IoT Gateway',
      category: 'Vehicle Trackers',
      description:
          'OBD vehicle diagnostics with Bluetooth 5.0, remote diagnostics, and error detection.',
      features: [
        ProductFeature(icon: Icons.thermostat_outlined, label: 'Temperature'),
        ProductFeature(icon: Icons.water_drop_outlined, label: 'Humidity'),
        ProductFeature(
          icon: Icons.directions_run_rounded,
          label: 'Motion & More',
        ),
      ],
    ),
    ProductData(
      image: 'images/tmd364-side1.png',
      image2: 'images/tmd364-top1.png',
      image3: 'images/tmd364-back1.png',
      image4: 'images/tmd364-part1.png',
      // image5: 'images/tmd364-side1.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD364',
      subtitle: 'Industrial IoT Gateway',
      category: 'Vehicle Trackers',
      description:
          '4G LTE with 2G fallback, CAN/RS232 interfaces, BLE 5.0, motion sensing, and IP67 protection.',
      features: [
        ProductFeature(icon: Icons.speed_rounded, label: 'High Performance'),
        ProductFeature(icon: Icons.battery_saver_outlined, label: 'Low Power'),
        ProductFeature(
          icon: Icons.settings_input_component_outlined,
          label: 'Multiple Interfaces',
        ),
      ],
    ),
    ProductData(
      image: 'images/tmd364-side1.png',
      image2: 'images/tmd364-top1.png',
      image3: 'images/tmd364-back1.png',
      image4: 'images/tmd364-part1.png',
      badge: 'AIS140',
      badgeColor: ipbadge,
      title: 'TMD 364-AIS140',
      subtitle: 'Industrial IoT Gateway',
      category: 'Vehicle Trackers',
      description:
          '4G LTE with 2G fallback, GNSS + IRNSS positioning, BLE 5.0, vehicle diagnostics, and IP67 protection.',
      features: [
        ProductFeature(icon: Icons.usb_rounded, label: 'OBD-II Interface'),
        ProductFeature(
          icon: Icons.directions_car_outlined,
          label: 'Vehicle Data',
        ),
        ProductFeature(
          icon: Icons.build_circle_outlined,
          label: 'Easy Installation',
        ),
      ],
    ),
    ProductData(
      image: 'images/tmd364-side1.png',
      image2: 'images/tmd364-top1.png',
      image3: 'images/tmd364-back1.png',
      image4: 'images/tmd364-part1.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU510',
      subtitle: 'Industrial IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, secure communication, ECU monitoring, SD card data logging.',
      features: [
        ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    ProductData(
      image: 'images/tmd364-side1.png',
      image2: 'images/tmd364-top1.png',
      image3: 'images/tmd364-back1.png',
      image4: 'images/tmd364-part1.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU520',
      subtitle: 'Industrial IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, dual-band Wi-Fi, secure communication, ECU monitoring.',
      features: [
        ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    ProductData(
      image: 'images/tmd364-side1.png',
      image2: 'images/tmd364-top1.png',
      image3: 'images/tmd364-back1.png',
      image4: 'images/tmd364-part1.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU550',
      subtitle: 'Industrial IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, Ethernet connectivity, CAN interfaces, GPS odometer.',
      features: [
        ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    ProductData(
      image: 'images/tmdcstrr-5.png',
      image2: 'images/tmdcstr-5-back.png',
      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-5',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '5-inch TFT display with 4G LTE Cat 1, 2G fallback, GNSS positioning, and vehicle monitoring',
      features: [
        ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    ProductData(
      image: 'images/tmdcstrr-7.png',
      image2: 'images/tmdcstr-7-side.png',
      image3: 'images/tmdcstr-7-back.png',

      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-7',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '7-inch TFT display with 4G LTE Cat 1, 2G fallback, GNSS positioning, and vehicle monitoring',
      features: [
        ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
    ProductData(
      image: 'images/a2.png',
      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-7A',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '7-inch TFT touchscreen with 4G LTE Cat 4,2G fallback, dual-band Wi-Fi, GNSS.',
      features: [
        ProductFeature(icon: Icons.wifi_rounded, label: '4G LTE'),
        ProductFeature(
          icon: Icons.notifications_active_outlined,
          label: 'Real-time Alerts',
        ),
        ProductFeature(icon: Icons.location_on_outlined, label: 'Geo-fencing'),
      ],
    ),
  ];

  final List<_TrustItemData> _trustItems = const [
    _TrustItemData(
      icon: "icons/quality1.svg",
      title: 'Quality Assured',
      description: 'Rigorous testing for reliability & durability',
    ),
    _TrustItemData(
      icon: "icons/secured.svg",
      title: 'Secure by Design',
      description: 'Built-in security for data & device protection',
    ),
    _TrustItemData(
      icon: "icons/globe.svg",
      title: 'Global Standards',
      description: 'Compliant with international quality',
    ),
    _TrustItemData(
      icon: "icons/integration.svg",
      title: 'Made for Integration',
      description: 'Easy to integrate with your systems & platforms',
    ),
  ];

  void _selectFilterIndex(int index) {
    if (index == _selectedFilterIndex) return;

    setState(() {
      _selectedFilterIndex = index;
    });
  }

  // void _selectCategory(String label) {
  //   final index = _filterTabs.indexWhere((tab) => tab.label == label);

  //   if (index != -1) {
  //     _selectFilterIndex(index);
  //   }
  // }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadProductImages();
    });
  }

  Future<void> _preloadProductImages() async {
    try {
      final imagePaths = _products.map((product) => product.image).toSet();

      await Future.wait(
        imagePaths.map((path) => precacheImage(AssetImage(path), context)),
      );
      await Future.delayed(
        const Duration(seconds: 3),
      ); //just fr testing purposes
    } catch (e) {
      debugPrint('Error preloading product images: $e');
    }

    if (!mounted) return;

    setState(() {
      _imagesLoading = false;
    });
  }

  // Future<void> _preloadProductImages() async {
  //   try {
  //     final imagePaths = _products.map((product) => product.image).toSet();

  //     debugPrint('🟡 Starting image preload...');
  //     debugPrint('🟡 Total unique images: ${imagePaths.length}');

  //     await Future.wait(
  //       imagePaths.map((path) => precacheImage(AssetImage(path), context)),
  //     );

  //     debugPrint('🎉 ALL PRODUCT IMAGES LOADED');

  //     // TESTING ONLY
  //     await Future.delayed(const Duration(seconds: 8));

  //     debugPrint('⏰ Test delay finished');

  //     debugPrint('🎉 ALL PRODUCT IMAGES LOADED');
  //   } catch (e) {
  //     debugPrint('❌ Error preloading product images: $e');
  //   }

  //   if (!mounted) return;

  //   setState(() {
  //     _imagesLoading = false;
  //   });

  //   debugPrint('🟢 _imagesLoading = false');
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 72),
              child: widget.header,
            ),
            // Positioned(
            //   left: 40,
            //   right: 40,
            //   bottom: 35,
            //   child: _buildFilterTabsBar(),
            // ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.15,
              right: MediaQuery.of(context).size.width * 0.15,
              bottom: 35,
              child: _buildFilterTabsBar(),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              _buildProductRangeHeader(),
              const SizedBox(height: 28),
              _buildProductsGrid(),
              const SizedBox(height: 55),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _buildTrustBar(),
        ),

        const SizedBox(height: 45),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _buildHowProductsWorkTogether(),
        ),
      ],
    );
  }

  // FILTER BAR
  Widget _buildFilterTabsBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.14),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_filterTabs.length, (index) {
          return Expanded(
            child: Center(
              child: _buildFilterTab(index: index, tab: _filterTabs[index]),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFilterTab({required int index, required _FilterTabData tab}) {
    final bool isSelected = index == _selectedFilterIndex;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        mouseCursor: SystemMouseCursors.click,
        onTap: () => _selectFilterIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? tBlue3.withOpacity(0.7) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                tab.icon,
                width: 22,
                height: 22,
                color: isSelected ? tBlue3 : tBlack.withOpacity(0.5),
              ),
              const SizedBox(width: 9),
              Text(
                tab.label,
                maxLines: 1,
                softWrap: false,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? tBlue3 : tBlack.withOpacity(0.65),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PRODUCT RANGE HEADER

  Widget _buildProductRangeHeader() {
    return Column(
      children: [
        Text(
          'OUR PRODUCT RANGE',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Smart Products for a Connected World',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),
      ],
    );
  }

  // PRODUCT GRID

  Widget _buildProductsGrid() {
    if (_imagesLoading) {
      return ProductShimmer();
    }

    final selectedLabel = _filterTabs[_selectedFilterIndex].label;

    // When "All Products" is selected,
    // display products grouped by their category.
    if (selectedLabel == 'All Products') {
      final categories = <String>[
        'Vehicle Trackers',
        'Gateways',
        'Clusters',
        'ADAS',
      ];

      return Column(
        children: [
          for (final category in categories)
            _buildCategorySection(
              category,
              _products.where((p) => p.category == category).toList(),
            ),
        ],
      );
    }

    // When a specific filter is selected,
    // show only that category with its heading.
    final products =
        _products.where((p) => p.category == selectedLabel).toList();

    if (products.isEmpty) {
      return _buildEmptyState();
    }

    return _buildCategorySection(selectedLabel, products);
  }

  Widget _buildCategorySection(String category, List<ProductData> products) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CATEGORY HEADING
          Padding(
            padding: const EdgeInsets.only(left: 75, bottom: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: GoogleFonts.manrope(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: tBlue2,
                  ),
                ),
                const SizedBox(height: 5),

                Container(width: 30, height: 2, color: tOrange1),
              ],
            ),
          ),
          // PRODUCT CARDS
          _buildCategoryProductsGrid(products),
        ],
      ),
    );
  }

  Widget _buildCategoryProductsGrid(List<ProductData> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;

        double cardWidth;

        if (screenWidth >= 1800) {
          cardWidth = 410;
        } else {
          cardWidth = 330;
        }

        return Column(
          children: [
            for (int i = 0; i < products.length; i += 4)
              Padding(
                padding: EdgeInsets.only(
                  bottom: i + 4 < products.length ? 16 : 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int j = i; j < i + 4 && j < products.length; j++)
                        Padding(
                          padding: EdgeInsets.only(
                            right:
                                j + 1 < i + 4 && j + 1 < products.length
                                    ? 16
                                    : 0,
                          ),
                          child: SizedBox(
                            width: cardWidth,
                            height: 390,
                            child: _ProductCard(data: products[j]),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      key: const ValueKey('empty'),
      width: double.infinity,
      height: 350,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tBlue3.withOpacity(0.08),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.inventory_2_outlined,
              size: 34,
              color: tBlue3.withOpacity(0.55),
            ),
          ),

          const SizedBox(height: 22),

          Text(
            'No products in this category yet',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: tBlack,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'We\'re expanding our lineup. Check back soon\nor browse our other product categories.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.5),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => _selectFilterIndex(0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: tBlue3,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All Products',
                      style: GoogleFonts.manrope(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: tWhite,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward_rounded, size: 15, color: tWhite),
                  ],
                ),
              ),
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
        SvgPicture.asset(data.icon, width: 30, height: 30, color: tOrange1),

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

  Widget _buildHowProductsWorkTogether() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ProcessSection(
        eyebrow: 'HOW OUR PRODUCTS WORK TOGETHER',
        title: 'From Data to Decisions',
        steps: const [
          ProcessStepData(
            number: '01',
            icon: 'icons/sensors.svg',
            title: 'Sensors',
            description: 'Collect real-time data from the environment.',
          ),
          ProcessStepData(
            number: '02',
            icon: 'icons/iot_device.svg',
            title: 'Devices',
            description: 'Capture and process data from connected assets.',
          ),
          ProcessStepData(
            number: '03',
            icon: 'icons/gateway.svg',
            title: 'Gateways',
            description: 'Connect devices and securely transmit data.',
          ),
          ProcessStepData(
            number: '04',
            icon: 'icons/iot_solutions.svg',
            title: 'Cloud',
            description: 'Store and manage connected data centrally.',
          ),
          ProcessStepData(
            number: '05',
            icon: 'icons/innovation.svg',
            title: 'Insights',
            description: 'Turn real-time data into actionable insights.',
          ),
        ],
      ),
    );
  }
}

class _ProductCarousel extends StatefulWidget {
  final List<ProductData> products;

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

    final shouldShow = _contentWidth() > totalWidth + 1;

    if (_showArrows != shouldShow) {
      setState(() {
        _showArrows = shouldShow;
      });
    }
  }

  void _scrollBy(double delta) {
    if (!_scrollController.hasClients) {
      return;
    }

    if (_scrollController.positions.length != 1) {
      return;
    }

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

        final contentWidth = _contentWidth();

        final bool needsScroll = contentWidth > totalWidth + 1;

        if (!needsScroll) {
          return SizedBox(
            width: double.infinity,
            height: _cardHeight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(products.length, (index) {
                    final isLast = index == products.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(
                        right: isLast ? 0 : _cardSpacing,
                      ),
                      child: SizedBox(
                        width: _cardWidth,
                        child: _ProductCard(data: products[index]),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }

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
  final ProductData data;

  const _ProductCard({required this.data});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _hovering = false;

  void _setHovering(bool value) {
    if (_hovering == value) return;

    setState(() {
      _hovering = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return MouseRegion(
      onEnter: (_) => _setHovering(true),
      onExit: (_) => _setHovering(false),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(product: data),
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform:
                Matrix4.identity()
                  ..translate(0.0, _hovering ? -8.0 : 0.0)
                  ..scale(_hovering ? 1.02 : 1.0),
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
                    Padding(
                      padding:
                      // data.title == 'TMDCSTR-7A'
                      //     ? const EdgeInsets.only(top: 11, left: 14, right: 14)
                      //     :
                      const EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius:
                            // data.title == 'TMDCSTR-7A'
                            //     ? BorderRadius.circular(14)
                            //     :
                            BorderRadius.zero,
                        child: SizedBox(
                          width: double.infinity,
                          height: 210,
                          child: Image.asset(
                            data.image,
                            fit: BoxFit.contain,
                            frameBuilder: (
                              context,
                              child,
                              frame,
                              wasSynchronouslyLoaded,
                            ) {
                              // Already decoded/in cache -> just show it, no flicker.
                              if (wasSynchronouslyLoaded) return child;

                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                child:
                                    frame != null
                                        ? child
                                        : const ShimmerBox(height: 210),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: tBlack.withOpacity(0.05),
                                alignment: Alignment.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // if (data.badge != null)
                    //   Positioned(
                    //     top: 10,
                    //     right: 10,
                    //     child: Container(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 10,
                    //         vertical: 4,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: data.badgeColor,
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       child: Text(
                    //         data.badge!,
                    //         style: GoogleFonts.manrope(
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.w700,
                    //           color: tWhite,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    if (data.badge != null || data.secondBadge != null)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Existing badge
                            if (data.badge != null)
                              Container(
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
                            const SizedBox(width: 3),
                            // Second badge
                            if (data.secondBadge != null) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: data.secondBadgeColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  data.secondBadge!,
                                  style: GoogleFonts.manrope(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: tWhite,
                                  ),
                                ),
                              ),
                            ],
                          ],
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
                          color: tBlue3,
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

                      SizedBox(
                        height: 50,
                        child: Text(
                          data.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: tBlack,
                            height: 1.45,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          mouseCursor: SystemMouseCursors.click,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ProductDetailsPage(product: data),
                              ),
                            );
                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 2,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'More Info',
                                  style: GoogleFonts.manrope(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: tOrange1,
                                  ),
                                ),

                                const SizedBox(width: 5),

                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 15,
                                  color: tOrange1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // const SizedBox(height: 12),

                      // // ...data.features.map(_buildFeatureItem),
                      // const SizedBox(height: 6),
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

  // Widget _buildImageShimmer() {
  //   return Shimmer.fromColors(
  //     baseColor: Colors.grey.shade300,
  //     highlightColor: Colors.grey.shade100,
  //     child: Container(
  //       width: double.infinity,
  //       height: 210,
  //       color: Colors.white,
  //     ),
  //   );
  // }
}

class _FilterTabData {
  final String icon;
  final String label;

  const _FilterTabData({required this.icon, required this.label});
}

class ProductData {
  final String image;
  final String? badge;
  final Color? badgeColor;
  final String? secondBadge;
  final Color? secondBadgeColor;
  final String title;
  final String subtitle;
  final String category;
  final String description;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final List<ProductFeature> features;

  const ProductData({
    required this.image,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    required this.badge,
    required this.badgeColor,
    this.secondBadge,
    this.secondBadgeColor,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.description,
    required this.features,
  });
}

class ProductFeature {
  final IconData icon;
  final String label;

  const ProductFeature({required this.icon, required this.label});
}

class _TrustItemData {
  final String icon;
  final String title;
  final String description;

  const _TrustItemData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
