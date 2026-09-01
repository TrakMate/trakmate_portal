import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class BuildProductSection extends StatefulWidget {
  final Widget header;

  const BuildProductSection({super.key, required this.header});

  @override
  State<BuildProductSection> createState() => _BuildProductSectionState();
}

class _BuildProductSectionState extends State<BuildProductSection> {
  int _selectedFilterIndex = 0;

  final List<_FilterTabData> _filterTabs = const [
    _FilterTabData(icon: "icons/all.svg", label: 'All Products'),
    _FilterTabData(icon: "icons/iot.svg", label: 'IoT Devices'),
    _FilterTabData(icon: "icons/gateway.svg", label: 'Gateways'),
    _FilterTabData(icon: "icons/gps.svg", label: 'Trackers'),
    _FilterTabData(icon: "icons/embedded.svg", label: 'Embedded Modules'),
    _FilterTabData(icon: "icons/sensors.svg", label: 'Sensors'),
    _FilterTabData(icon: "icons/accessories.svg", label: 'Accessories'),
  ];

  final List<_ProductData> _products = const [
    _ProductData(
      image: 'images/trackx4G.png',
      badge: '4G',
      badgeColor: tBlue3,
      title: 'TMD024',
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
      title: 'TMD500',
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
      title: 'TMD320',
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
      image: 'images/categories/embedded_modules.jpg',
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

  List<_ProductData> get _filteredProducts {
    final selectedLabel = _filterTabs[_selectedFilterIndex].label;

    if (selectedLabel == 'All Products') {
      return _products;
    }

    return _products.where((p) => p.category == selectedLabel).toList();
  }

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
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
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
              const SizedBox(height: 38),
              _buildProductsGrid(),
              const SizedBox(height: 55),
            ],
          ),
        ),

        _buildHowProductsWorkTogether(),

        const SizedBox(height: 45),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _buildTrustBar(),
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
                width: 19,
                height: 19,
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
    final products = _filteredProducts;

    return SizedBox(
      width: double.infinity,
      height: 420,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        child:
            products.isEmpty
                ? _buildEmptyState()
                : _ProductCarousel(
                  key: ValueKey(_selectedFilterIndex),
                  products: products,
                ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      key: const ValueKey('empty'),
      width: double.infinity,
      height: 420,
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
    final steps = [
      (
        number: '01',
        title: 'Sensors',
        label: 'DATA COLLECTION',
        description: 'Collect real-time data from the environment.',
        icon: Icons.sensors_rounded,
      ),
      (
        number: '02',
        title: 'Devices',
        label: 'EDGE PROCESSING',
        description: 'Capture and process data from connected assets.',
        icon: Icons.devices_other_rounded,
      ),
      (
        number: '03',
        title: 'Gateways',
        label: 'CONNECTIVITY',
        description: 'Connect devices and securely transmit data.',
        icon: Icons.router_rounded,
      ),
      (
        number: '04',
        title: 'Cloud',
        label: 'DATA PLATFORM',
        description: 'Store and manage connected data centrally.',
        icon: Icons.cloud_outlined,
      ),
      (
        number: '05',
        title: 'Insights',
        label: 'INTELLIGENCE',
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
              fontWeight: FontWeight.w700,
              color: tOrange1,
              letterSpacing: 1.4,
            ),
          ),

          const SizedBox(height: 11),

          Text(
            'From Data to Decisions',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: tBlue2,
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

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 17),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // tBlue3.withOpacity(0.025),
                  // tWhite,
                  // tBlue3.withOpacity(0.018),
                  tBlue2,
                  tBlue3,
                ],
              ),
              border: Border.all(color: tBlue3.withOpacity(0.07)),
            ),
            child: Stack(
              children: [
                // Positioned(
                //   left: 25,
                //   right: 25,
                //   top: 62,
                //   child: Container(height: 1, color: tBlue3.withOpacity(0.055)),
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(steps.length * 2 - 1, (index) {
                    if (index.isEven) {
                      final stepIndex = index ~/ 2;
                      final step = steps[stepIndex];

                      return Expanded(
                        child: _buildIoTFlowCard(
                          number: step.number,
                          title: step.title,
                          label: step.label,
                          description: step.description,
                          icon: step.icon,
                          isLast: stepIndex == steps.length - 1,
                        ),
                      );
                    }

                    return const SizedBox(
                      width: 40,
                      child: _AnimatedFlowConnector(),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 17),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tOrange1,
                  boxShadow: [
                    BoxShadow(color: tOrange1.withOpacity(0.35), blurRadius: 8),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Text(
                'REAL-TIME DATA FLOW',
                style: GoogleFonts.manrope(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  color: tBlue3.withOpacity(0.55),
                  letterSpacing: 1.3,
                ),
              ),

              const SizedBox(width: 10),

              Container(width: 32, height: 1, color: tBlue3.withOpacity(0.15)),

              const SizedBox(width: 10),

              Text(
                'END-TO-END CONNECTIVITY',
                style: GoogleFonts.manrope(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  color: tBlack.withOpacity(0.32),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIoTFlowCard({
    required String number,
    required String title,
    required String label,
    required String description,
    required IconData icon,
    bool isLast = false,
  }) {
    return _IoTFlowCard(
      number: number,
      title: title,
      label: label,
      description: description,
      icon: icon,
      isLast: isLast,
    );
  }
}

class _IoTFlowCard extends StatefulWidget {
  final String number;
  final String title;
  final String label;
  final String description;
  final IconData icon;
  final bool isLast;

  const _IoTFlowCard({
    required this.number,
    required this.title,
    required this.label,
    required this.description,
    required this.icon,
    required this.isLast,
  });

  @override
  State<_IoTFlowCard> createState() => _IoTFlowCardState();
}

class _IoTFlowCardState extends State<_IoTFlowCard> {
  bool _hovering = false;

  void _setHovering(bool value) {
    if (_hovering == value) return;

    setState(() {
      _hovering = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => _setHovering(true),
      onExit: (_) => _setHovering(false),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          top: _hovering ? 0 : 6,
          bottom: _hovering ? 6 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: 150,
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color:
                  _hovering
                      ? tBlue3.withOpacity(0.20)
                      : tBlue3.withOpacity(0.09),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: tBlue3.withOpacity(_hovering ? 0.10 : 0.045),
                blurRadius: _hovering ? 24 : 16,
                offset: Offset(0, _hovering ? 10 : 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 3,
                width: _hovering ? 110 : 52,
                decoration: BoxDecoration(
                  color: tOrange1,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(14, 17, 14, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: 39,
                          height: 39,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [tOrange1, tOrange1.withOpacity(0.82)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: tOrange1.withOpacity(
                                  _hovering ? 0.32 : 0.22,
                                ),
                                blurRadius: _hovering ? 16 : 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.number,
                            style: GoogleFonts.manrope(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              color: tWhite,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Row(
                            children: [
                              // AnimatedContainer(
                              //   // duration: const Duration(milliseconds: 220),
                              //   // width: 31,
                              //   // height: 31,
                              //   // decoration: BoxDecoration(
                              //   //   color: tBlue3.withOpacity(
                              //   //     _hovering ? 0.12 : 0.065,
                              //   //   ),
                              //   //   borderRadius: BorderRadius.circular(9),
                              //   // ),
                              //   alignment: Alignment.center,
                              //   // child: Icon(
                              //   //   widget.icon,
                              //   //   size: 17,
                              //   //   color: _hovering ? tOrange1 : tBlue3,
                              //   // ),
                              // ),
                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  widget.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: tBlue2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: _hovering ? 7 : 5,
                          height: _hovering ? 7 : 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: tOrange1,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Text(
                          widget.label,
                          style: GoogleFonts.manrope(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: tBlue3.withOpacity(0.75),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      height: 1,
                      color: tBlack.withOpacity(0.055),
                    ),

                    const SizedBox(height: 9),

                    Expanded(
                      child: Text(
                        widget.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: tBlack.withOpacity(0.52),
                          height: 1.4,
                        ),
                      ),
                    ),

                    // Row(
                    //   children: [
                    //     Icon(
                    //       widget.isLast
                    //           ? Icons.auto_awesome_rounded
                    //           : Icons.arrow_forward_rounded,
                    //       size: 11,
                    //       color: tOrange1,
                    //     ),

                    //     // const SizedBox(width: 5),

                    //     // Text(
                    //     //   widget.isLast ? 'Actionable output' : 'Data flow',
                    //     //   style: GoogleFonts.manrope(
                    //     //     fontSize: 9,
                    //     //     fontWeight: FontWeight.w700,
                    //     //     color: tBlue3.withOpacity(0.58),
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ANIMATED FLOW CONNECTOR

class _AnimatedFlowConnector extends StatefulWidget {
  const _AnimatedFlowConnector();

  @override
  State<_AnimatedFlowConnector> createState() => _AnimatedFlowConnectorState();
}

class _AnimatedFlowConnectorState extends State<_AnimatedFlowConnector>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(40, 24),
              painter: _FlowConnectorPainter(progress: _controller.value),
            );
          },
        ),
      ),
    );
  }
}

// FLOW CONNECTOR PAINTER

class _FlowConnectorPainter extends CustomPainter {
  final double progress;

  const _FlowConnectorPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;

    // DASHED LINE

    final dotPaint =
        Paint()
          ..color = tWhite
          ..style = PaintingStyle.fill;

    const double dotSize = 1.0;
    const double dotSpacing = 6.0;

    double x = 2;

    while (x < size.width - 10) {
      canvas.drawCircle(Offset(x, centerY), dotSize, dotPaint);

      x += dotSpacing;
    }

    // ARROW HEAD

    final arrowPaint =
        Paint()
          ..color = tWhite
          ..strokeWidth = 1.7
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final arrow = Path();

    arrow.moveTo(size.width - 9, centerY - 6);

    arrow.lineTo(size.width - 2, centerY);

    arrow.lineTo(size.width - 9, centerY + 6);

    canvas.drawPath(arrow, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant _FlowConnectorPainter oldDelegate) {
    return false;
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
  final _ProductData data;

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

class _FilterTabData {
  final String icon;
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
  final String icon;
  final String title;
  final String description;

  const _TrustItemData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
