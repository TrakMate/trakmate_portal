import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/pages/main_page.dart';
import 'package:trakmate_portal/src/ui/widgets/nav_footer.dart';
import 'package:trakmate_portal/src/ui/widgets/process_section.dart';
import 'package:trakmate_portal/src/ui/widgets/product_details.dart';
import 'package:trakmate_portal/src/ui/widgets/product_filter_controller.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/ui/widgets/solutions_hub.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

// Used only to close the product filter overlay when another modal/dialog opens.
final ValueNotifier<int> productFilterCloseSignal = ValueNotifier<int>(0);

// Remembers the last selected filter tab. If the page is ever rebuilt with a
// brand-new State, it reads this to start on the tab the user just chose.
int _lastSelectedFilterIndex = 0;

// Survive page rebuilds so a new State never re-shows the shimmer
// or resets the tab bar scroll position.
bool _productImagesPreloaded = false;
double _lastTabsScrollOffset = 0;

class _BelowHeaderClipper extends CustomClipper<Rect> {
  final double headerHeight;
  const _BelowHeaderClipper(this.headerHeight);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      headerHeight,
      size.width,
      (size.height - headerHeight).clamp(0.0, double.infinity),
    );
  }

  @override
  bool shouldReclip(covariant _BelowHeaderClipper oldClipper) =>
      oldClipper.headerHeight != headerHeight;
}

class BuildProductSection extends StatefulWidget {
  final Widget header;
  const BuildProductSection({super.key, required this.header});

  @override
  State<BuildProductSection> createState() => _BuildProductSectionState();
}

class _BuildProductSectionState extends State<BuildProductSection> {
  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  // Horizontal page padding for the content blocks below the header
  double get _hPad => isMobile ? 16 : (isTablet ? 24 : 40);

  int _selectedFilterIndex = 0;
  bool _imagesLoading = !_productImagesPreloaded;
  final GlobalKey _productRangeKey = GlobalKey();
  final GlobalKey _filterButtonKey = GlobalKey();
  final GlobalKey _productCardsKey = GlobalKey();
  final GlobalKey _filterBarKey = GlobalKey();

  // Attribute filter state (connectivity + vehicle type + new-arrivals)
  final Set<String> _selectedConnectivity = {};
  final Set<String> _selectedVehicleTypes = {};
  bool _newOnly = false;

  // Small filter icon button + its floating dropdown panel
  OverlayEntry? _filterMenuOverlay;
  bool _filterMenuOpen = false;
  int _lastFilterCloseSignal = 0;

  Offset? _filterButtonPosition;
  Size? _filterButtonSize;

  ScrollPosition? _scrollPosition;

  // Filter tabs bar: horizontal scrolling + "more tabs" hints on both sides
  // (the hint arrows are only shown on tablet / mobile).
  final ScrollController _tabsScrollController = ScrollController(
    initialScrollOffset: _lastTabsScrollOffset,
  );
  final ValueNotifier<bool> _tabsCanScrollRight = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _tabsCanScrollLeft = ValueNotifier<bool>(false);

  static const double _kStickyHeaderHeight = 84;

  int get _activeFilterCount =>
      _selectedConnectivity.length +
      _selectedVehicleTypes.length +
      (_newOnly ? 1 : 0);

  static const List<String> _connectivityOptions = ['4G', '2G'];
  static const List<String> _vehicleTypeOptions = [
    '2 Wheeler',
    '3 Wheeler',
    '4 Wheeler',
    'Commercial Vehicles',
  ];

  final List<_FilterTabData> _filterTabs = const [
    _FilterTabData(icon: "icons/all.svg", label: 'All Products'),
    _FilterTabData(icon: "icons/trackers1.svg", label: 'Telematics'),
    _FilterTabData(icon: "icons/diagnostics.svg", label: 'Diagnostics'),

    _FilterTabData(icon: "icons/gateways1.svg", label: 'Gateways'),
    _FilterTabData(icon: "icons/cluster.svg", label: 'Clusters'),
    _FilterTabData(icon: "icons/car.svg", label: 'ADAS'),
    _FilterTabData(icon: "icons/solution_hub.svg", label: 'Solutions Hub'),
  ];

  final List<ProductData> _products = const [
    ProductData(
      image: 'images/tmd104b.png',
      image1: 'images/tmd104b.png',
      image2: 'images/tmd104b.png',
      image3: 'images/tmd024-top-view.png',
      image4: 'images/tmd024_isometric3.png',
      image5: 'images/tmd024-vertical-view.png',
      image6: 'images/tmd024-part.png',
      specBadges: ['icons/4gg1.svg', 'icons/evv1.svg'],

      specsStyle: SpecsSlideStyle(
        imagePadding: 108,
        badgeWidth: 120,
        badgeRightOffset: 120,
        badgeGap: 25,
      ),
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD001',
      subtitle: 'Advanced GPS Tracker',
      category: 'Telematics',
      description:
          '4G LTE modem with 2G fallback, real-time tracking, geo-fencing, and  monitoring.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler'],
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
      image: 'images/tmd006_isometric.png',
      image1: 'images/tmd006_isometric.png',
      image2: 'images/tmd006_isometric.png',
      image3: 'images/tmd006-back.png',
      image4: 'images/tmd006-side.png',
      image5: 'images/tmd006-bottom.png',
      specBadges: ['icons/4gg1.svg', 'icons/ble1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 118,
        badgeWidth: 120,
        badgeRightOffset: 100,
        badgeHeight: 70,
        badgeVerticalAlign: 0,
        badgeGap: 25,
      ),
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: 'new',
      secondBadgeColor: newbadge,
      // thirdbadge: 'new',
      // thirdbadgeColor: newbadge,
      title: 'TMD006',
      subtitle: 'Advanced GPS Tracker',
      category: 'Telematics',
      description:
          '4G LTE Cat 1, CAN/BMS monitoring, datalogging, and driver behavior support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler'],
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
      image: 'images/tmd104b.png',
      image1: 'images/tmd104b.png',
      image2: 'images/tmd104b.png',
      image3: 'images/tmd024-bottom-view.png',
      image4: 'images/tmd024_isometric3.png',
      image6: 'images/tmd024-part.png',
      specBadges: ['icons/4gg.svg', 'icons/evv1.svg', 'icons/ble1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 108,
        badgeWidth: 120,
        badgeRightOffset: 120,
        badgeGap: 25,
        badgeHeight: 70,
      ),
      badge: '4G',
      badgeColor: tBlue3,
      // No 2G badge because TMD004 is 4G only.
      secondBadgeColor: tOrange1,
      title: 'TMD004',
      subtitle: 'Advanced GPS Tracker',
      category: 'Telematics',
      description:
          '4G LTE modem with datalogging, CAN/BMS monitoring, BLE sensor integration, and FOTA support.',

      // FIX: TMD004 is 4G only.
      connectivity: ['4G'],

      vehicleTypes: ['2 Wheeler', '3 Wheeler'],
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
      image: 'images/tmd104b.png',
      image1: 'images/tmd104b.png',
      image2: 'images/tmd104b.png',
      image3: 'images/tmd024-bottom-view.png',
      image4: 'images/tmd024_isometric3.png',
      image7: 'images/tmd024-part.png',
      specsStyle: SpecsSlideStyle(
        imagePadding: 108,
        badgeWidth: 120,
        badgeRightOffset: 120,
        badgeGap: 25,
      ),
      specBadges: ['icons/4gg1.svg', 'icons/evv1.svg', 'icons/ble1.svg'],
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD024',
      subtitle: 'Advanced GPS Tracker',
      category: 'Telematics',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['3 Wheeler', '4 Wheeler'],
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
      image: 'images/tmdnew_isometric.png',
      image1: 'images/tmdnew_isometric.png',
      image2: 'images/tmdnew_top.png',
      image3: 'images/tmdnew_back.png',
      image4: 'images/tmdnew_part.png',
      image7: 'images/tmdnew_part1.png',
      // specsStyle: SpecsSlideStyle(
      //   imagePadding: 108,
      //   badgeWidth: 120,
      //   badgeRightOffset: 120,
      //   badgeGap: 25,
      // ),
      // specBadges: ['icons/4gg1.svg', 'icons/evv1.svg', 'icons/ble1.svg'],
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD026',
      subtitle: 'Advanced GPS Tracker',
      category: 'Telematics',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['3 Wheeler', '4 Wheeler'],
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
      image1: 'images/tmb024.png',
      image2: 'images/tmb024.png',
      specBadges: ['icons/4gg1.svg', 'icons/evv1.svg', 'icons/ble1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 128,
        badgeWidth: 120,
        badgeRightOffset: 190,
        badgeHeight: 70,
        badgeGap: 25,
        badgeVerticalAlign: 0,
      ),
      badge: 'new',
      badgeColor: newbadge,
      title: 'TMB024',
      subtitle: 'Advanced GPS Tracker',
      category: 'Telematics',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['3 Wheeler', '4 Wheeler'],
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

      image1: 'images/tmd400.png',
      image2: 'images/tmd400.png',
      specBadges: ['icons/ble1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 118,
        badgeWidth: 120,
        badgeRightOffset: 100,
        badgeHeight: 70,
        badgeGap: 25,
        badgeVerticalAlign: -0.4,
      ),
      badge: "OBD-II",
      badgeColor: ipbadge,
      title: 'TMD400',
      subtitle: 'Advanced IoT Gateway',
      category: 'Diagnostics',
      description:
          'OBD vehicle diagnostics with Bluetooth 5.0, remote diagnostics, and error detection.',
      connectivity: [], // wired OBD-II / Bluetooth — no cellular modem
      vehicleTypes: ['4 Wheeler'],
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
      image: 'images/tmd300.png',
      image2: 'images/tmd300.png',
      specBadges: ['icons/ble1.svg', 'icons/evv1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 118,
        badgeWidth: 120,
        badgeRightOffset: 100,
        badgeHeight: 70,
        badgeGap: 25,
        badgeVerticalAlign: -0.4,
      ),
      badge: "OBD-II",
      badgeColor: ipbadge,
      secondBadge: 'new',
      secondBadgeColor: newbadge,
      title: 'TMD300',
      subtitle: 'Advanced Vehicle Diagnostics',
      category: 'Diagnostics',
      description:
          '16Pin OBD2 Connector OBDii 16 Pin Adaptor OBD II Male Plug J1962 Car Connector.',
      connectivity: [], // wired OBD-II connector — no cellular modem
      vehicleTypes: ['4 Wheeler'],
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
      image1: 'images/tmd364-side1.png',
      image2: 'images/tmd364-side1.png',
      image3: 'images/tmd364-top1.png',
      image4: 'images/tmd364-back1.png',
      image5: 'images/tmd364-part1.png',
      specBadges: ['icons/4gg1.svg', 'icons/evv1.svg', 'icons/ble1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 128,
        badgeWidth: 120,
        badgeRightOffset: 90,
        badgeHeight: 70,
        badgeVerticalAlign: 0,
        badgeGap: 25,
      ),
      video: 'video/tmd364.webm',
      videoPadding: 40,
      videoOffsetY: -45,
      datasheet: 'datasheets/tmd364_datasheet.pdf',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD364',
      subtitle: 'Advanced GPS Tracker',
      category: 'Telematics',
      description:
          '4G LTE with 2G fallback, CAN/RS232 interfaces, BLE 5.0, motion sensing, and IP67 protection.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['4 Wheeler'],
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
      image1: 'images/tmd364-side1.png',
      image2: 'images/tmd364-side1.png',
      image3: 'images/tmd364-top1.png',
      image4: 'images/tmd364-back1.png',
      image5: 'images/tmd364-part1.png',
      specBadges: [
        'icons/4gg1.svg',
        'icons/evv1.svg',
        'icons/ble1.svg',
        'icons/linux1.svg',
      ],
      specsStyle: SpecsSlideStyle(
        imagePadding: 128,
        badgeWidth: 120,
        badgeRightOffset: 90,
        badgeHeight: 70,
        badgeVerticalAlign: 0,
        badgeGap: 25,
      ),
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU510',
      subtitle: 'Advanced IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, secure communication, ECU monitoring, SD card data logging.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['Commercial Vehicles'],
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
      image1: 'images/tmd364-side1.png',
      image2: 'images/tmd364-side1.png',
      image3: 'images/tmd364-top1.png',
      image4: 'images/tmd364-back1.png',
      image5: 'images/tmd364-part1.png',
      specBadges: [
        'icons/4gg1.svg',
        'icons/evv1.svg',
        'icons/ble1.svg',
        'icons/linux1.svg',
        'icons/wifi1.svg',
      ],
      specsStyle: SpecsSlideStyle(
        imagePadding: 128,
        badgeRightOffset: 90,
        badgeVerticalAlign: 0,
        topRowCount: 3,
        badgeGap: 25,
      ),
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU520',
      subtitle: 'Advanced IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, dual-band Wi-Fi, secure communication, ECU monitoring.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['Commercial Vehicles'],
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
      image: 'images/tcu550-side2-view.png',
      image1: 'images/tcu550-side2-view.png',
      image2: 'images/tcu550-side2-view.png',
      image3: 'images/tcu1550.png',
      image4: 'images/tcu550-part.png',
      specBadges: [
        'icons/4gg1.svg',
        'icons/evv1.svg',
        'icons/ble1.svg',
        'icons/wifi1.svg',
        'icons/linux1.svg',
        'icons/ethernet1.svg',
      ],
      specsStyle: SpecsSlideStyle(
        imagePadding: 128, //168
        imagePaddingSmall: 168,
        badgeWidth: 120,
        badgeRightOffset: 70,
        badgeHeight: 90,
        badgeVerticalAlign: 0,
        badgeGap: 25,
        topRowCount: 4,
      ),
      video: 'video/tcu550.webm',
      videoPadding: 40,
      videoOffsetY: -45,
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU550',
      subtitle: 'Advanced IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, Ethernet connectivity, CAN interfaces, GPS odometer.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['Commercial Vehicles'],
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
      image1: 'images/tmdcstrr-5.png',
      image2: 'images/tmdcstrr-5.png',
      image3: 'images/pigtail.jpg',
      specBadges: ['icons/4gg1.svg', 'icons/evv1.svg', 'icons/ble1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 128,
        badgeWidth: 120,
        badgeRightOffset: 70,
        badgeGap: 25,
        badgeVerticalAlign: 0,
      ),
      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-5',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '5-inch TFT display with 4G LTE Cat 1, 2G fallback, GNSS positioning, and vehicle monitoring',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler'],
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
      image1: 'images/tmdcstrr-7.png',
      image2: 'images/tmdcstrr-7.png',
      image3: 'images/tmdcstr-7-side.png',
      image4: 'images/tmdcstr-7-back.png',
      image5: 'images/tmdcstr-7_specs.png',
      specBadges: ['icons/4gg1.svg', 'icons/evv1.svg', 'icons/ble1.svg'],
      specsStyle: SpecsSlideStyle(
        imagePadding: 138,
        badgeWidth: 120,
        badgeRightOffset: 50,
        badgeGap: 25,
        badgeVerticalAlign: 0,
      ),
      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-7',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '7-inch TFT display with 4G LTE Cat 1, 2G fallback, GNSS positioning, and vehicle monitoring',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['3 Wheeler'],
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
      image1: 'images/a2.png',
      image2: 'images/a2.png',
      specBadges: [
        'icons/4gg1.svg',
        'icons/evv1.svg',
        'icons/ble1.svg',
        'icons/android1.svg',
        'icons/hd1.svg',
        'icons/wifi1.svg',
      ],
      specsStyle: SpecsSlideStyle(
        imagePadding: 148,
        imagePaddingSmall: 168,
        badgeWidth: 120,
        badgeRightOffset: 50,
        badgeGap: 25,
        badgeVerticalAlign: 0,
        topRowCount: 4,
        topRowTopOffset: 25,
      ),
      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-7A',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '7-inch TFT touchscreen with 4G LTE Cat 4,2G fallback, dual-band Wi-Fi, GNSS.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['3 Wheeler'],
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
      icon: "icons/integration1.svg",
      title: 'Made for Integration',
      description: 'Easy to integrate with your systems & platforms',
    ),
  ];

  static const Map<String, String> _footerKeyToFilterLabel = {
    'All Products': 'All Products',
    'Telematics': 'Telematics',
    'Vehicle Diagnostics': 'Diagnostics',
    'Gateways': 'Gateways',
    'Clusters': 'Clusters',
    'ADAS': 'ADAS',
    'Solution Hub': 'Solutions Hub',
  };

  // Tab label -> URL. Must match the paths used in MainPage.
  static const Map<String, String> _filterLabelToPath = {
    'All Products': '/products',
    'Telematics': '/products/telematics',
    'Diagnostics': '/products/diagnostics',
    'Gateways': '/products/gateways',
    'Clusters': '/products/clusters',
    'ADAS': '/products/adas',
    'Solutions Hub': '/solutions-hub',
  };

  // Tab taps only switch the tab locally (setState) and update the browser URL.
  // No context.go(), so go_router never rebuilds the page and there is no
  // shimmer, no image reload and no scroll reset.
  void _onFilterTabTap(int index) {
    if (index == _selectedFilterIndex) return;

    _selectFilterIndex(index);

    final String? path = _filterLabelToPath[_filterTabs[index].label];
    if (path != null) {
      // If your Flutter version rejects `uri:`, use `location: path` instead.
      SystemNavigator.routeInformationUpdated(
        uri: Uri.parse(path),
        replace: true,
      );
    }
  }

  void _selectFilterIndex(int index) {
    _lastSelectedFilterIndex = index;

    if (index == _selectedFilterIndex) return;

    setState(() {
      _selectedFilterIndex = index;
    });
  }

  // Attribute filter toggles -------------------------------------
  // Each toggle updates the main grid via setState, and also nudges the
  // floating dropdown panel (a separate Overlay entry) to rebuild so its
  // chips reflect the new selection immediately.

  void _toggleConnectivity(String value) {
    setState(() {
      if (_selectedConnectivity.contains(value)) {
        _selectedConnectivity.remove(value);
      } else {
        _selectedConnectivity.add(value);
      }
    });
    _filterMenuOverlay?.markNeedsBuild();
  }

  void _toggleVehicleType(String value) {
    setState(() {
      if (_selectedVehicleTypes.contains(value)) {
        _selectedVehicleTypes.remove(value);
      } else {
        _selectedVehicleTypes.add(value);
      }
    });
    _filterMenuOverlay?.markNeedsBuild();
  }

  void _toggleNewOnly() {
    setState(() {
      _newOnly = !_newOnly;
    });
    _filterMenuOverlay?.markNeedsBuild();
  }

  void _clearAttributeFilters() {
    setState(() {
      _selectedConnectivity.clear();
      _selectedVehicleTypes.clear();
      _newOnly = false;
    });
    _filterMenuOverlay?.markNeedsBuild();
  }

  void _openFilterMenu() {
    if (_filterMenuOverlay != null) return;

    final RenderBox? buttonBox =
        _filterButtonKey.currentContext?.findRenderObject() as RenderBox?;

    if (buttonBox == null || !buttonBox.hasSize) return;

    final Offset position = buttonBox.localToGlobal(Offset.zero);
    final Size size = buttonBox.size;

    _filterButtonPosition = position;
    _filterButtonSize = size;

    final OverlayState? overlay = Overlay.of(context);
    if (overlay == null) return;

    _filterMenuOverlay = OverlayEntry(
      builder: (overlayContext) {
        final mediaSize = MediaQuery.sizeOf(overlayContext);
        final position = _filterButtonPosition ?? Offset.zero;
        final buttonSize = _filterButtonSize ?? Size.zero;

        const double panelWidth = 270;
        const double panelGap = 10;

        double left = position.dx + buttonSize.width - panelWidth;

        left = left.clamp(12.0, mediaSize.width - panelWidth - 12.0);

        final double top = position.dy + buttonSize.height + panelGap;

        // MOBILE: if the panel is taller than the space under the button,
        // let it scroll instead of running off the bottom of the screen.
        final bool mobileOverlay = ResponsiveLayout.isMobile(overlayContext);
        final double maxPanelHeight = (mediaSize.height - top - 12).clamp(
          160.0,
          double.infinity,
        );

        return ClipRect(
          clipper: const _BelowHeaderClipper(_kStickyHeaderHeight),
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _closeFilterMenu,
                ),
              ),
              Positioned(
                left: left,
                top: top,
                width: panelWidth,
                child: Material(
                  color: tTransparent,
                  child:
                      mobileOverlay
                          ? ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: maxPanelHeight,
                            ),
                            child: SingleChildScrollView(
                              child: _buildFilterDropdownPanel(),
                            ),
                          )
                          : _buildFilterDropdownPanel(),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(_filterMenuOverlay!);

    _scrollPosition = Scrollable.maybeOf(context)?.position;
    _scrollPosition?.addListener(_onAncestorScroll);

    if (!mounted) return;
    setState(() => _filterMenuOpen = true);
  }

  void _onAncestorScroll() {
    _updateFilterButtonGeometry();
  }

  void _updateFilterButtonGeometry() {
    if (_filterMenuOverlay == null) return;

    final RenderBox? buttonBox =
        _filterButtonKey.currentContext?.findRenderObject() as RenderBox?;

    if (buttonBox == null || !buttonBox.hasSize || !buttonBox.attached) {
      _closeFilterMenu();
      return;
    }

    _filterButtonPosition = buttonBox.localToGlobal(Offset.zero);
    _filterButtonSize = buttonBox.size;
    _filterMenuOverlay?.markNeedsBuild();
  }

  void _handleExternalFilterClose() {
    if (_lastFilterCloseSignal == productFilterCloseSignal.value) {
      return;
    }

    _lastFilterCloseSignal = productFilterCloseSignal.value;

    if (_filterMenuOverlay != null) {
      _closeFilterMenu();
    }
  }

  void _closeFilterMenu() {
    // Detach the scroll listener whenever the menu closes.
    _scrollPosition?.removeListener(_onAncestorScroll);
    _scrollPosition = null;

    _filterMenuOverlay?.remove();
    _filterMenuOverlay = null;
    _filterButtonPosition = null;
    _filterButtonSize = null;

    if (!mounted) return;
    setState(() => _filterMenuOpen = false);
  }

  void _toggleFilterMenu() {
    if (_filterMenuOpen) {
      _closeFilterMenu();
    } else {
      _openFilterMenu();
    }
  }

  bool get _hasActiveAttributeFilters =>
      _selectedConnectivity.isNotEmpty ||
      _selectedVehicleTypes.isNotEmpty ||
      _newOnly;

  bool _matchesAttributeFilters(ProductData product) {
    if (_selectedConnectivity.isNotEmpty) {
      final Set<String> displayedConnectivityBadges = {
        if (product.badge == '4G' || product.badge == '2G') product.badge!,
        if (product.secondBadge == '4G' || product.secondBadge == '2G')
          product.secondBadge!,
      };

      final bool hasAllSelectedConnectivity = _selectedConnectivity.every(
        displayedConnectivityBadges.contains,
      );

      if (!hasAllSelectedConnectivity) {
        return false;
      }
    }

    if (_selectedVehicleTypes.isNotEmpty &&
        !product.vehicleTypes.any(_selectedVehicleTypes.contains)) {
      return false;
    }

    if (_newOnly &&
        product.badge != 'new' &&
        product.secondBadge != 'new' &&
        product.thirdbadge != 'new') {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    // Start on the tab the user last chose (survives a page rebuild).
    _selectedFilterIndex = _lastSelectedFilterIndex;

    // Remember the tab bar scroll offset across page rebuilds.
    _tabsScrollController.addListener(() {
      if (_tabsScrollController.hasClients) {
        _lastTabsScrollOffset = _tabsScrollController.offset;
      }
    });

    SectionScrollBus.instance.pendingKey.addListener(_handleFooterNavigation);
    ProductFilterController.selectedCategory.addListener(
      _handleProductFilterNavigation,
    );
    productFilterCloseSignal.addListener(_handleExternalFilterClose);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadProductImages();
      _handleFooterNavigation();
      _handleProductFilterNavigation();
    });
  }

  @override
  void dispose() {
    SectionScrollBus.instance.pendingKey.removeListener(
      _handleFooterNavigation,
    );
    ProductFilterController.selectedCategory.removeListener(
      _handleProductFilterNavigation,
    );
    productFilterCloseSignal.removeListener(_handleExternalFilterClose);
    _tabsScrollController.dispose();
    _tabsCanScrollRight.dispose();
    _tabsCanScrollLeft.dispose();
    // Make sure the scroll listener doesn't outlive this State.
    _scrollPosition?.removeListener(_onAncestorScroll);
    _filterMenuOverlay?.remove();
    _filterMenuOverlay = null;
    super.dispose();
  }

  void _handleFooterNavigation() {
    final request = SectionScrollBus.instance.pendingKey.value;
    if (request == null) return;

    final filterLabel = _footerKeyToFilterLabel[request.key];
    if (filterLabel == null)
      return; // not meant for this section, leave it alone

    final targetIndex = _filterTabs.indexWhere(
      (tab) => tab.label == filterLabel,
    );
    if (targetIndex != -1) {
      _selectFilterIndex(targetIndex);
    }

    SectionScrollBus.instance.pendingKey.value = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _productRangeKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          alignment: 0.05,
        );
      }
    });
  }

  void _handleProductFilterNavigation() {
    final String? category = ProductFilterController.selectedCategory.value;
    if (category == null) return;

    final int targetIndex = _filterTabs.indexWhere(
      (tab) => tab.label == category,
    );

    // If the tab is already selected (user just tapped it in the bar),
    // don't scroll the page again.
    final bool alreadySelected = targetIndex == _selectedFilterIndex;

    if (targetIndex != -1) {
      _selectFilterIndex(targetIndex);
    }

    // Clear the value AFTER the frame, not immediately. Clearing it right away
    // starves any other live listener (e.g. the outgoing page while the router
    // swaps pages), which is what sent the tab back to "All Products".
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ProductFilterController.selectedCategory.value == category) {
        ProductFilterController.selectedCategory.value = null;
      }
    });

    if (!alreadySelected) {
      _scrollToProductCards();
    }
  }

  // Scrolls the page so the product cards section is at the top.
  void _scrollToProductCards() {
    // Wait until the tab switch + filter change have been laid out.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final ctx = _filterBarKey.currentContext;
      if (ctx == null) return;

      Scrollable.ensureVisible(
        ctx,

        duration: const Duration(milliseconds: 500),

        curve: Curves.easeInOut,

        alignment: 0.0, // 0.0 = cards header at very top of the viewport
      );
    });
  }

  Future<void> _preloadProductImages() async {
    // Already loaded once in this session: no shimmer, no waiting.
    if (_productImagesPreloaded) {
      if (mounted && _imagesLoading) {
        setState(() => _imagesLoading = false);
      }
      return;
    }

    try {
      final imagePaths = _products.map((product) => product.image).toSet();

      await Future.wait(
        imagePaths.map((path) => precacheImage(AssetImage(path), context)),
      );

      // await Future.delayed(const Duration(seconds: 3));//fr testing
    } catch (e) {
      // debugPrint('Error preloading product images: $e');
    }

    _productImagesPreloaded = true;

    if (!mounted) return;

    setState(() {
      _imagesLoading = false;
    });
  }

  // Desktop card rows need 75 + 4*330 + 3*16 = 1443px, plus 40px page
  // padding on each side = 1523px.
  static const double _kMinContentWidth = 1523;

  // Only on desktop and only when the screen is narrower than needed,
  // the content slides sideways. Otherwise it is returned unchanged.
  Widget _scrollIfNeeded(double screenW, Widget child) {
    if (isMobile || isTablet || screenW >= _kMinContentWidth) {
      return child;
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: SizedBox(width: _kMinContentWidth, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final bool mobile = _isMobile;
    final double screenW = MediaQuery.of(context).size.width;
    final double barSide = isMobile ? 12 : 24;

    return Column(
      children: [
        Stack(
          key: _productRangeKey,
          clipBehavior: Clip.none,
          children: [
            Padding(
              // room for the part of the filter bar that overlaps the header
              padding: EdgeInsets.only(bottom: isMobile ? 56 : 72),
              child: widget.header,
            ),

            // Category tabs bar + the attribute filter icon button,
            // laid out side by side.
            Positioned(
              left: barSide,
              right: barSide,
              bottom: isMobile ? 20 : 35,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: (screenW - barSide * 2).clamp(
                      0.0,
                      double.infinity,
                    ),
                  ),
                  // 1310 = original 1250 tabs-bar budget + 46 icon button + 14 gap
                  child: SizedBox(
                    key: _filterBarKey,
                    width: 1310,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: _buildFilterTabsBar()),
                        SizedBox(width: isMobile ? 10 : 14),

                        _buildAttributeFilterButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Only the heading + product cards slide sideways (when needed).
        _scrollIfNeeded(
          screenW,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _hPad),
            child: Column(
              children: [
                _buildProductRangeHeader(),
                SizedBox(height: isMobile ? 20 : 28),
                _buildProductsGrid(),
                SizedBox(height: isMobile ? 24 : 55),
              ],
            ),
          ),
        ),

        // Trust bar and everything below: never scrolls sideways.
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _hPad),
          child: _buildTrustBar(),
        ),

        SizedBox(height: isMobile ? 32 : 45),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: _hPad),
          child: _buildHowProductsWorkTogether(),
        ),
      ],
    );
  }

  // FILTER BAR
  Widget _buildFilterTabsBar() {
    // final bool mobile = _isMobile;

    return Container(
      width: double.infinity,
      padding:
          isMobile
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
              : const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 16),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.14),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final Widget scroller = SingleChildScrollView(
            controller: _tabsScrollController,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth.clamp(0.0, double.infinity),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_filterTabs.length * 2 - 1, (index) {
                  if (index.isOdd) {
                    return SizedBox(
                      width: isMobile ? 12 : (isTablet ? 28 : 65),
                    ); //gap
                  }

                  final int tabIndex = index ~/ 2;
                  return _buildFilterTab(
                    index: tabIndex,
                    tab: _filterTabs[tabIndex],
                  );
                }),
              ),
            ),
          );

          // Desktop: no scroll hints, exactly as before.
          if (!(isMobile || isTablet)) return scroller;

          // Tablet + mobile: scroll hint arrows at both ends of the bar.
          // Left arrow shows only after the bar has been scrolled; right
          // arrow shows only while there are more tabs to the right.
          return Stack(
            children: [
              NotificationListener<ScrollMetricsNotification>(
                onNotification: (n) {
                  _tabsCanScrollRight.value = n.metrics.extentAfter > 1;
                  _tabsCanScrollLeft.value = n.metrics.extentBefore > 1;
                  return false;
                },
                child: NotificationListener<ScrollNotification>(
                  onNotification: (n) {
                    if (n.metrics.axis == Axis.horizontal) {
                      _tabsCanScrollRight.value = n.metrics.extentAfter > 1;
                      _tabsCanScrollLeft.value = n.metrics.extentBefore > 1;
                    }
                    return false;
                  },
                  child: scroller,
                ),
              ),

              // LEFT hint
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _tabsCanScrollLeft,
                  builder: (context, canScroll, _) {
                    return IgnorePointer(
                      ignoring: !canScroll,
                      child: AnimatedOpacity(
                        opacity: canScroll ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: _buildTabsScrollHint(left: true),
                      ),
                    );
                  },
                ),
              ),

              // RIGHT hint
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _tabsCanScrollRight,
                  builder: (context, canScroll, _) {
                    return IgnorePointer(
                      ignoring: !canScroll,
                      child: AnimatedOpacity(
                        opacity: canScroll ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: _buildTabsScrollHint(left: false),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Small arrow (with a soft white fade behind it) shown at the left or right
  // end of the filter tabs on tablet / mobile. Tap = scroll the tabs by one
  // step in that direction.
  Widget _buildTabsScrollHint({required bool left}) {
    return Container(
      width: 44,
      alignment: left ? Alignment.centerLeft : Alignment.centerRight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: left ? Alignment.centerRight : Alignment.centerLeft,
          end: left ? Alignment.centerLeft : Alignment.centerRight,
          colors: [tWhite.withOpacity(0), tWhite, tWhite],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: Material(
        color: tBlue3,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            if (!_tabsScrollController.hasClients) return;
            final position = _tabsScrollController.position;
            final double delta = left ? -180 : 180;
            final double target = (_tabsScrollController.offset + delta).clamp(
              0.0,
              position.maxScrollExtent,
            );
            _tabsScrollController.animateTo(
              target,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          child: SizedBox(
            width: 26,
            height: 26,
            child: Icon(
              left ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              size: 20,
              color: tWhite,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab({required int index, required _FilterTabData tab}) {
    final bool isSelected = index == _selectedFilterIndex;
    // final bool mobile = _isMobile;

    return Material(
      color: tTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        mouseCursor: SystemMouseCursors.click,
        onTap: () => _onFilterTabTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 6,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: tTransparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? tBlue3.withOpacity(0.7) : tTransparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                tab.icon,
                width: isMobile ? 20 : 22,
                height: isMobile ? 20 : 22,
                color: isSelected ? tBlue3 : tBlack.withOpacity(0.5),
              ),
              SizedBox(width: isMobile ? 7 : 9),
              Text(
                tab.label,
                maxLines: 1,
                softWrap: false,
                style: GoogleFonts.manrope(
                  fontSize: isMobile ? 12.5 : 13,
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

  // SMALL FILTER ICON BUTTON — sits right next to the tabs bar and
  // opens a floating dropdown panel with every attribute filter inside it.
  Widget _buildAttributeFilterButton() {
    final bool highlighted = _filterMenuOpen || _hasActiveAttributeFilters;
    final double btnSize = isMobile ? 44 : 46;

    return Container(
      key: _filterButtonKey,
      child: Material(
        color: tTransparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          mouseCursor: SystemMouseCursors.click,
          onTap: _toggleFilterMenu,
          child: Container(
            width: btnSize,
            height: btnSize,
            decoration: BoxDecoration(
              color: highlighted ? tOrange1 : tWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: tBlack.withOpacity(0.14),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'icons/filter.svg',
                    width: 20,
                    height: 20,
                    color: highlighted ? tWhite : tOrange1,
                  ),
                ),
                if (_activeFilterCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 17,
                        minHeight: 17,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: tOrange1,
                        shape: BoxShape.circle,
                        border: Border.all(color: tWhite, width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$_activeFilterCount',
                        style: GoogleFonts.manrope(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: tWhite,
                        ),
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

  // The floating panel itself — rendered inside an OverlayEntry, anchored
  // below-right of the icon button via a measured global position.
  Widget _buildFilterDropdownPanel() {
    return Container(
      width: 270,
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: tBlack.withOpacity(0.18),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'FILTER PRODUCTS',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: tBlack,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Material(
                color: tTransparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  mouseCursor: SystemMouseCursors.click,
                  onTap: _closeFilterMenu,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: tBlack.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildPanelSectionLabel('CONNECTIVITY'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _connectivityOptions
                    .map(
                      (option) => _buildFilterChip(
                        label: option,
                        selected: _selectedConnectivity.contains(option),
                        onTap: () => _toggleConnectivity(option),
                      ),
                    )
                    .toList(),
          ),

          const SizedBox(height: 18),

          _buildPanelSectionLabel('VEHICLE TYPE'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _vehicleTypeOptions
                    .map(
                      (option) => _buildFilterChip(
                        label: option,
                        selected: _selectedVehicleTypes.contains(option),
                        onTap: () => _toggleVehicleType(option),
                      ),
                    )
                    .toList(),
          ),

          const SizedBox(height: 18),

          _buildPanelSectionLabel('OTHER'),
          const SizedBox(height: 8),
          _buildFilterChip(
            label: 'New Arrivals',
            selected: _newOnly,
            onTap: _toggleNewOnly,
            icon: Icons.auto_awesome_rounded,
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              if (_hasActiveAttributeFilters)
                Material(
                  color: tTransparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    mouseCursor: SystemMouseCursors.click,
                    onTap: _clearAttributeFilters,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Clear all',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: tOrange1,
                        ),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              Material(
                color: tBlue3,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  mouseCursor: SystemMouseCursors.click,
                  onTap: _closeFilterMenu,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 9,
                    ),
                    child: Text(
                      'Done',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: tWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPanelSectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.manrope(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        color: tBlack.withOpacity(0.4),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return Material(
      color: tTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        mouseCursor: SystemMouseCursors.click,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? tBlue3 : tWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? tBlue3 : tBlack.withOpacity(0.12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 13,
                  color: selected ? tWhite : tBlack.withOpacity(0.5),
                ),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: selected ? tWhite : tBlack.withOpacity(0.65),
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
    // final bool mobile = _isMobile;

    return Column(
      key: _productCardsKey,
      children: [
        Text(
          'OUR PRODUCT RANGE',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: isMobile ? 8 : 12),

        Text(
          'Smart Products for a Connected World',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 20 : 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
            height: isMobile ? 1.25 : null,
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

    final String selectedLabel = _filterTabs[_selectedFilterIndex].label;

    // SOLUTIONS HUB
    //
    // Solutions Hub is a separate page/widget, not a ProductData
    // category. The tab remains visible because build() still builds
    // the header and filter bar before this content.
    //
    if (selectedLabel == 'Solutions Hub') {
      return SolutionsHubPage();
    }
    if (_imagesLoading) {
      return ProductShimmer();
    }
    // ALL PRODUCTS — apply the attribute filters within each category.

    if (selectedLabel == 'All Products') {
      final List<String> categories = [
        'Telematics',
        'Diagnostics',
        'Gateways',
        'Clusters',
        'ADAS',
      ];

      final List<Widget> sections = [];
      for (final category in categories) {
        final List<ProductData> categoryProducts =
            _products
                .where(
                  (product) =>
                      product.category == category &&
                      _matchesAttributeFilters(product),
                )
                .toList();

        if (categoryProducts.isNotEmpty) {
          sections.add(_buildCategorySection(category, categoryProducts));
        }
      }

      if (sections.isEmpty) {
        return _hasActiveAttributeFilters
            ? _buildNoFilterMatchState()
            : _buildEmptyState();
      }

      return Column(children: sections);
    }

    // INDIVIDUAL CATEGORY — apply the attribute filters on top of the tab.

    final List<ProductData> products =
        _products
            .where((product) => product.category == selectedLabel)
            .toList();

    if (products.isEmpty) {
      return _buildEmptyState();
    }

    final List<ProductData> filteredProducts =
        products.where(_matchesAttributeFilters).toList();

    if (filteredProducts.isEmpty) {
      return _buildNoFilterMatchState();
    }

    return _buildCategorySection(selectedLabel, filteredProducts);
  }

  Widget _buildCategorySection(String category, List<ProductData> products) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    // final bool mobile = _isMobile;

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 36 : 52),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CATEGORY HEADING
          Padding(
            padding: EdgeInsets.only(
              left: (isTablet || isMobile) ? 0 : 75,
              bottom: isMobile ? 20 : 28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: GoogleFonts.manrope(
                    fontSize: isMobile ? 20 : 22,
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
          _buildCategoryProductsGrid(products, category: category),
        ],
      ),
    );
  }

  Widget _buildCategoryProductsGrid(
    List<ProductData> products, {
    required String category,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;

        // MOBILE: 1 card per row on phones, 2 on very wide phones.
        if (isMobile) {
          const double gap = 16;
          final int columns = screenWidth >= 560 ? 2 : 1;
          final double w = ((screenWidth - gap * (columns - 1)) / columns)
              .floorToDouble()
              .clamp(0.0, double.infinity);
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final p in products)
                SizedBox(width: w, height: 390, child: _ProductCard(data: p)),
            ],
          );
        }

        // TABLET: 2 cards per row, sized from the available width.
        if (isTablet) {
          const double gap = 16;
          final double w = ((screenWidth - gap) / 2).floorToDouble();
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final p in products)
                SizedBox(width: w, height: 390, child: _ProductCard(data: p)),
            ],
          );
        }

        double cardWidth;

        if (screenWidth >= 1800) {
          cardWidth = 410;
        } else {
          cardWidth = 330;
        }

        final int cardsPerRow = category == 'Solutions Hub' ? 2 : 4;

        return Column(
          children: [
            for (int i = 0; i < products.length; i += cardsPerRow)
              Padding(
                padding: EdgeInsets.only(
                  bottom: i + cardsPerRow < products.length ? 16 : 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (
                        int j = i;
                        j < i + cardsPerRow && j < products.length;
                        j++
                      )
                        Padding(
                          padding: EdgeInsets.only(
                            right:
                                j + 1 < i + cardsPerRow &&
                                        j + 1 < products.length
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
            'Products Coming Soon',
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
            color: tTransparent,
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

  // Shown when a category has products, but none match the active
  // Connectivity / Vehicle Type / New Arrivals filters.
  Widget _buildNoFilterMatchState() {
    return Container(
      key: const ValueKey('no-filter-match'),
      width: double.infinity,
      height: 300,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tOrange1.withOpacity(0.08),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.filter_alt_off_outlined,
              size: 30,
              color: tOrange1.withOpacity(0.6),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'No products match the selected filters',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: tBlack,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Try removing a filter to see more products.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.5),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          Material(
            color: tTransparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: _clearAttributeFilters,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: tOrange1,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Clear Filters',
                  style: GoogleFonts.manrope(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: tWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TRUST BAR
  // Used by tablet (unchanged) and mobile (tighter padding, full-width button).
  Widget _buildTrustBarTablet() {
    // final bool mobile = _isMobile;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tBlue2,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: EdgeInsets.all(isMobile ? 18 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, c) {
              final double gap = isMobile ? 16 : 20;
              final double w = ((c.maxWidth - gap) / 2).floorToDouble();
              return Wrap(
                spacing: gap,
                runSpacing: isMobile ? 20 : 22,
                children: [
                  for (final item in _trustItems)
                    SizedBox(width: w, child: _buildTrustItem(item)),
                ],
              );
            },
          ),
          SizedBox(height: isMobile ? 20 : 24),
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
          SizedBox(
            width: isMobile ? double.infinity : null,
            child: ElevatedButton(
              onPressed:
                  () => showGetInTouchDialog(
                    context,
                    recipientEmail: 'sales@trakmate.co.in',
                  ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBar() {
    if (isTablet || isMobile) return _buildTrustBarTablet();

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
                  onPressed: () {
                    showGetInTouchDialog(
                      context,
                      recipientEmail: 'sales@trakmate.co.in',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tBlue1,
                    foregroundColor: tWhite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
      padding: EdgeInsets.symmetric(
        horizontal: (isTablet || isMobile) ? 0 : 40,
      ),
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
      color: tTransparent,
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

  // No hover effect on tablet / mobile layouts
  bool get _isTouch =>
      ResponsiveLayout.isMobile(context) || ResponsiveLayout.isTablet(context);

  bool get _noHover => _isTouch || MediaQuery.of(context).size.width < 1523;
  void _setHovering(bool value) {
    if (_noHover) return;
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
        color: tTransparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          hoverColor: _noHover ? tTransparent : null,
          mouseCursor:
              _isTouch ? SystemMouseCursors.basic : SystemMouseCursors.click,
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
                      padding: const EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.zero,
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

                    if (data.badge != null ||
                        data.secondBadge != null ||
                        data.thirdbadge != null)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // 4G + 2G
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
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
                                if (data.secondBadge != null) ...[
                                  const SizedBox(width: 3),
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

                            // NEW badge below 4G + 2G
                            if (data.thirdbadge != null) ...[
                              const SizedBox(height: 3),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: data.thirdbadgeColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  data.thirdbadge!,
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
                        color: tTransparent,
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

class _FilterTabData {
  final String icon;
  final String label;

  const _FilterTabData({required this.icon, required this.label});
}

class SpecsSlideStyle {
  final double imagePadding;
  final double badgeWidth;
  final double badgeHeight;
  final double badgeGap;
  final double badgeRightOffset;
  final double badgeVerticalAlign;
  final double?
  imagePaddingSmall; // top gap on smaller screens (null = no change)
  // How many of the FIRST specBadges go in a top row.
  // 0 = all badges stay in the column (current behaviour).
  final int topRowCount;
  final double topRowGap; // space between badges in the top row
  final double topRowTopOffset; // distance from top edge of the slide
  final double topRowAlignX; // -1 = left, 0 = center, 1 = right
  final double topRowSideOffset; // push the row in from the left/right edge

  const SpecsSlideStyle({
    this.imagePadding = 108,
    this.badgeWidth = 110,
    this.badgeHeight = 70,
    this.badgeGap = 9,
    this.badgeRightOffset = 10,
    this.badgeVerticalAlign = 0,
    this.topRowCount = 0,
    this.topRowGap = 12,
    this.topRowTopOffset = 24,
    this.topRowAlignX = 0,
    this.topRowSideOffset = 0,
    this.imagePaddingSmall,
  });
}

class ProductData {
  final String image;
  final String? image1;
  final String? badge;
  final Color? badgeColor;
  final String? secondBadge;
  final Color? secondBadgeColor;
  final String? thirdbadge;
  final Color? thirdbadgeColor;
  final String title;
  final String subtitle;
  final String category;
  final String description;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final String? image6;
  final String? image7;
  final List<String> specBadges;
  final String? video;
  final double? videoPadding;
  final double videoOffsetY;
  final String? datasheet; // e.g. 'datasheets/TMD104.pdf'
  final SpecsSlideStyle specsStyle;
  // Used by the attribute filter bar (Connectivity + Vehicle Type)
  final List<String> connectivity; // e.g. ['4G', '2G']
  final List<String> vehicleTypes; // e.g. ['2 Wheeler', '3 Wheeler', ...]

  final List<ProductFeature> features;

  const ProductData({
    required this.image,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.video,
    this.videoPadding,
    this.videoOffsetY = 0.0,
    this.datasheet,
    required this.badge,
    required this.badgeColor,
    this.secondBadge,
    this.secondBadgeColor,
    this.thirdbadge,
    this.thirdbadgeColor,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.description,
    this.connectivity = const [],
    this.vehicleTypes = const [],
    required this.features,
    this.specBadges = const [],
    this.specsStyle = const SpecsSlideStyle(),
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
