import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/navfooter.dart';
import 'package:trakmate_portal/src/ui/widgets/process_section.dart';
import 'package:trakmate_portal/src/ui/widgets/product_details.dart';
import 'package:trakmate_portal/src/ui/widgets/product_filter_controller.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import 'package:trakmate_portal/src/ui/widgets/solutions_hub.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
// import 'package:video_player/video_player.dart';

// -----------------------------------------------------------------------
// INTEGRATED: the secondary "attribute" filter bar (Connectivity + Vehicle
// Type + New Arrivals) has been merged in from the other version of this
// file, on top of this file's own product data / image field layout
// (image1..image6, no ProductFilterController). Behavior matches exactly:
//
// - ProductData gained two new fields: `connectivity` and `vehicleTypes`,
//   both defaulted to const [] so existing call sites without them still
//   compile. Values below are INFERRED from each product's description/
//   category — double check them against the real datasheets.
// - Filtering logic: OR within a group (e.g. 4G OR 2G), AND across groups
//   (connectivity AND vehicleType AND newOnly), on top of the active
//   category tab.
// - A small circular filter icon button sits to the right of the category
//   tabs bar and opens a floating dropdown panel (positioned via a
//   measured global offset + OverlayEntry, not Composited
//   Transform/Follower, to avoid Flutter Web leader/follower issues).
// - While open, the panel tracks the button's live position on every
//   ancestor-scroll tick (both directions), so it scrolls together with
//   the page instead of staying pinned to the screen. There is
//   deliberately NO clamping on its vertical position — it always
//   anchors directly below the button.
// - FIX: because an OverlayEntry paints above everything (including the
//   sticky top nav bar), the panel is wrapped in a ClipRect
//   (`_BelowHeaderClipper`) using the nav bar's height, so it never
//   visually stacks on top of the nav bar — it appears to scroll behind
//   it instead, while still tracking the button continuously/gradually.
//   See `_kStickyHeaderHeight` below; adjust it to your real header
//   height, or measure it dynamically with a GlobalKey if it varies.
// - The panel only closes via the filter icon toggle, the Done button,
//   or tapping outside it — never automatically from scrolling.
//
// NEW (nav dropdown integration): the top nav's "Products & Solutions"
// dropdown (see MainPage/_navigateToProductTab in nav_page.dart) sets
// `selectedIndex = 3` (this section) AND calls
// `ProductFilterController.select(filterKey)` with the clicked item's
// label — e.g. 'All Products', 'Trackers', 'Diagnostics', 'Gateways',
// 'Clusters', 'ADAS', 'Solutions Hub'. Those labels are an exact 1:1
// match with this widget's own `_filterTabs` labels, so no translation
// table is needed (unlike the footer's `_footerKeyToFilterLabel`, whose
// footer key names differ from the tab labels).
//
// `_handleProductFilterNavigation()` below listens to that same
// ValueNotifier, jumps the tab bar to the matching tab, consumes the
// value (sets it back to null) so the same category can be picked again
// later and still fire, and then — exactly like `_handleFooterNavigation`
// already does — calls `Scrollable.ensureVisible` on the product-range
// key so the hero/header collapses out of view and the tab bar + grid
// fill the screen. Because `IndexedStack` keeps this section mounted even
// while another tab is showing, this fires immediately on click with no
// extra wiring needed on the nav side.
// -----------------------------------------------------------------------

/// Clips overlay content so nothing paints over the sticky top nav bar.
/// The floating filter panel's `top`/`left` are still computed with NO
/// clamping (so it keeps tracking the filter button and scrolling
/// gradually with the page); anything above [headerHeight] in screen
/// coordinates is simply not painted (or hit-tested), so the panel never
/// stacks visually on top of the nav bar — it scrolls behind it instead.
///
/// If your nav bar's height changes across breakpoints, measure it
/// dynamically with a GlobalKey on the header widget instead of using a
/// constant.
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
  int _selectedFilterIndex = 0;
  bool _imagesLoading = true;
  final GlobalKey _productRangeKey = GlobalKey();
  final GlobalKey _filterButtonKey = GlobalKey();

  // NEW: attribute filter state (connectivity + vehicle type + new-arrivals)
  final Set<String> _selectedConnectivity = {};
  final Set<String> _selectedVehicleTypes = {};
  bool _newOnly = false;

  // NEW: small filter icon button + its floating dropdown panel
  OverlayEntry? _filterMenuOverlay;
  bool _filterMenuOpen = false;

  // Global position of the filter button, used to position the popup.
  // This avoids CompositedTransformTarget/Follower issues on Flutter Web.
  Offset? _filterButtonPosition;
  Size? _filterButtonSize;

  // NEW: the ancestor ScrollPosition we listen to while the menu is open,
  // so the panel can re-track the button's position as the page scrolls.
  ScrollPosition? _scrollPosition;

  // Height (in logical pixels) of the sticky top nav bar. The floating
  // filter panel is clipped so it never paints on top of this region —
  // it scrolls "behind" it instead of stacking over it. Tweak this to
  // match your real nav bar height, or measure it dynamically via a
  // GlobalKey if it isn't fixed across breakpoints.
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
    'Truck',
  ];

  final List<_FilterTabData> _filterTabs = const [
    _FilterTabData(icon: "icons/all.svg", label: 'All Products'),
    _FilterTabData(icon: "icons/trackers1.svg", label: 'Trackers'),
    _FilterTabData(icon: "icons/diagnostics.svg", label: 'Diagnostics'),

    _FilterTabData(icon: "icons/gateways1.svg", label: 'Gateways'),
    _FilterTabData(icon: "icons/cluster.svg", label: 'Clusters'),
    _FilterTabData(icon: "icons/car.svg", label: 'ADAS'),
    _FilterTabData(icon: "icons/solution_hub.svg", label: 'Solutions Hub'),
  ];

  final List<ProductData> _products = const [
    ProductData(
      image: 'images/tmd104(a).png',
      image1: 'images/tmd104_specs.png',
      image2: 'images/tmd104(a).png',
      image3: 'images/tmd024-top-view.png',
      image4: 'images/tmd024-bottom-view.png',
      image5: 'images/tmd024-vertical-view.png',
      image6: 'images/tmd024-part.png',

      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD104',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          '4G LTE modem with 2G fallback, real-time tracking, geo-fencing, and  monitoring.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler', '4 Wheeler', 'Truck'],
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
      image: 'images/tmd104(a).png',
      image1: 'images/tmd004-24_specs.png',
      image2: 'images/tmd104(a).png',
      image3: 'images/tmd024-bottom-view.png',
      image4: 'images/tmd024-vertical-view.png',
      image5: 'images/tmd024-part.png',
      image6: 'images/tmd024-top-view.png',
      badge: '4G',
      badgeColor: tBlue3,
      // secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD004',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          '4G LTE modem with datalogging, CAN/BMS monitoring, BLE sensor integration, and FOTA support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler', '4 Wheeler', 'Truck'],
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
      image: 'images/tmd104(a).png',
      image1: 'images/tmd004-024_specs.png',
      image2: 'images/tmd104(a).png',
      image3: 'images/tmd024-bottom-view.png',
      image4: 'images/tmd024-vertical-view.png',
      image5: 'images/tmd024_isometric1.png',
      image6: 'images/tmd024_isometric2.png',
      image7: 'images/tmd024-part.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD024',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler', '4 Wheeler', 'Truck'],
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
      image: 'images/tmd006_isometric.png',
      // image2: 'images/tmd006_front.png',
      image2: 'images/tmd006-back.png',
      image3: 'images/tmd006-side.png',
      // image5: 'images/tmd006-bottom.png',
      badge: 'new',
      badgeColor: newbadge,
      title: 'TMD006',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler', '4 Wheeler', 'Truck'],
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
      image: 'images/tmb024.png',
      image1: 'images/tmb024_specs.png',
      image2: 'images/tmb024.png',
      badge: 'new',
      badgeColor: newbadge,
      title: 'TMB024',
      subtitle: 'Advanced GPS Tracker',
      category: 'Trackers',
      description:
          '4G LTE Cat 1 with 2G fallback, CAN/BMS monitoring, datalogging, and driver behavior support.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler'],
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

      image1: 'images/tmd400_specs.png',
      image2: 'images/tmd400.png',
      badge: "OBD-II",
      badgeColor: ipbadge,
      title: 'TMD400',
      subtitle: 'Industrial IoT Gateway',
      category: 'Diagnostics',
      description:
          'OBD vehicle diagnostics with Bluetooth 5.0, remote diagnostics, and error detection.',
      connectivity: [], // wired OBD-II / Bluetooth — no cellular modem
      vehicleTypes: ['4 Wheeler', 'Truck'],
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
      badge: "OBD-II",
      badgeColor: ipbadge,
      title: 'TMD300',
      subtitle: 'Industrial Vehicle Diagnostics',
      category: 'Diagnostics',
      description:
          '16Pin OBD2 Connector OBDii 16 Pin Adaptor OBD II Male Plug J1962 Car Connector.',
      connectivity: [], // wired OBD-II connector — no cellular modem
      vehicleTypes: ['4 Wheeler', 'Truck'],
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
      image1: 'images/tmd364_specs.png',
      image2: 'images/tmd364-side1.png',
      image3: 'images/tmd364-top1.png',
      image4: 'images/tmd364-back1.png',
      image5: 'images/tmd364-part1.png',
      // image5: 'images/tmd364-side1.png',
      video: 'video/tmd364_demo.mp4',

      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TMD364',
      subtitle: 'Industrial IoT Gateway',
      category: 'Trackers',
      description:
          '4G LTE with 2G fallback, CAN/RS232 interfaces, BLE 5.0, motion sensing, and IP67 protection.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler', '4 Wheeler', 'Truck'],
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
      image1: 'images/tcu510_specs.png',
      image2: 'images/tmd364-side1.png',
      image3: 'images/tmd364-top1.png',
      image4: 'images/tmd364-back1.png',
      image5: 'images/tmd364-part1.png',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU510',
      subtitle: 'Industrial IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, secure communication, ECU monitoring, SD card data logging.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['4 Wheeler', 'Truck'],
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
      image1: 'images/tcu520_specs.png',
      image2: 'images/tmd364-side1.png',
      image3: 'images/tmd364-top1.png',
      image4: 'images/tmd364-back1.png',
      image5: 'images/tmd364-part1.png',

      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU520',
      subtitle: 'Industrial IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, dual-band Wi-Fi, secure communication, ECU monitoring.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['4 Wheeler', 'Truck'],
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
      image1: 'images/tcu550_specs.png',
      image2: 'images/tmd364-side1.png',
      image3: 'images/tmd364-top1.png',
      image4: 'images/tmd364-back1.png',
      image5: 'images/tmd364-part1.png',
      video: 'video/tcu550_demo.mp4',
      badge: '4G',
      badgeColor: tBlue3,
      secondBadge: '2G',
      secondBadgeColor: tOrange1,
      title: 'TCU550',
      subtitle: 'Industrial IoT Gateway',
      category: 'Gateways',
      description:
          '4G LTE with 2G fallback, Ethernet connectivity, CAN interfaces, GPS odometer.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['4 Wheeler', 'Truck'],
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
      image1: 'images/tmdcstr-5_specs.png',
      image2: 'images/tmdcstrr-5.png',
      image3: 'images/pigtail.jpg',
      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-5',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '5-inch TFT display with 4G LTE Cat 1, 2G fallback, GNSS positioning, and vehicle monitoring',
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
      image: 'images/tmdcstrr-7.png',
      image1: 'images/tmdcstr-7_specs.png',
      image2: 'images/tmdcstrr-7.png',
      image3: 'images/tmdcstr-7-side.png',
      image4: 'images/tmdcstr-7-back.png',
      // image4: 'images/tmdcstr-7-top.png',
      image5: 'images/tmdcstr-7_specs.png',

      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-7',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '7-inch TFT display with 4G LTE Cat 1, 2G fallback, GNSS positioning, and vehicle monitoring',
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
      image: 'images/a2.png',
      image5: 'images/tmdcstr-7a_specs.png',
      badge: null,
      badgeColor: null,
      title: 'TMDCSTR-7A',
      subtitle: 'Smart Display Cluster',
      category: 'Clusters',
      description:
          '7-inch TFT touchscreen with 4G LTE Cat 4,2G fallback, dual-band Wi-Fi, GNSS.',
      connectivity: ['4G', '2G'],
      vehicleTypes: ['2 Wheeler', '3 Wheeler', '4 Wheeler'],
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
    'Vehicle Trackers': 'Trackers',
    'Vehicle Diagnostics': 'Diagnostics',
    'Gateways': 'Gateways',
    'Clusters': 'Clusters',
    'ADAS': 'ADAS',
    'Solution Hub': 'Solutions Hub',
  };
  void _selectFilterIndex(int index) {
    if (index == _selectedFilterIndex) return;

    setState(() {
      _selectedFilterIndex = index;
    });
  }

  // NEW: attribute filter toggles -------------------------------------
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

  // NEW: open / close the floating filter dropdown ----------------------
  //
  // The filter button's global position is measured directly and the
  // overlay is placed with Positioned, avoiding CompositedTransform
  // Target/Follower (which can throw on Flutter Web).
  //
  // While the menu is open we also attach a listener to the nearest
  // ancestor Scrollable's position. Every scroll notification re-measures
  // the button's current global position (and size) and triggers the
  // overlay to rebuild, so the panel visually tracks the button as the
  // page scrolls in BOTH directions (up and down) — it moves together
  // with the page instead of staying pinned to the screen.
  //
  // FIX: the whole overlay Stack is wrapped in a ClipRect using
  // _BelowHeaderClipper, so the panel's paint (and hit-testing) is
  // suppressed above the sticky nav bar's height. The position math
  // itself has NO clamping on `top` — the panel keeps tracking the button
  // and scrolling gradually with the page; it just no longer stacks
  // visually on top of the nav bar once it scrolls that far.

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

        // Align the popup's right edge with the button's right edge.
        double left = position.dx + buttonSize.width - panelWidth;

        // Keep the popup inside the viewport horizontally only.
        left = left.clamp(12.0, mediaSize.width - panelWidth - 12.0);

        // Always anchor the panel BELOW the button, and always at the
        // button's exact current position — no clamping on `top` at all.
        // This is what makes the popup scroll together with the page: on
        // every scroll tick `_filterButtonPosition` is re-measured (see
        // `_updateFilterButtonGeometry`) and the panel is redrawn at that
        // exact offset, so it moves up when the page scrolls up and down
        // when the page scrolls down, in lock-step with the button, the
        // same way the rest of the page content does. It is never glued
        // or held in place — if the button scrolls off the top of the
        // screen, the panel scrolls off with it.
        final double top = position.dy + buttonSize.height + panelGap;

        // FIX: clip everything (barrier + panel) to the area below the
        // sticky nav bar, so the panel never paints on top of it while
        // still scrolling continuously/gradually with the page above.
        return ClipRect(
          clipper: const _BelowHeaderClipper(_kStickyHeaderHeight),
          child: Stack(
            children: [
              // Invisible barrier — tapping anywhere outside the panel closes it.
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
                  child: _buildFilterDropdownPanel(),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(_filterMenuOverlay!);

    // NEW: track the nearest scrollable ancestor so we can keep the panel
    // glued to the button (moving with it) as the user scrolls up/down.
    _scrollPosition = Scrollable.maybeOf(context)?.position;
    _scrollPosition?.addListener(_onAncestorScroll);

    if (!mounted) return;
    setState(() => _filterMenuOpen = true);
  }

  // NEW: fired on every scroll delta of the ancestor Scrollable while the
  // menu is open.
  void _onAncestorScroll() {
    _updateFilterButtonGeometry();
  }

  // NEW: re-measures the filter button's current global position/size and
  // asks the overlay to rebuild so the panel follows it, scrolling up and
  // down together with the page. If the button is no longer attached to
  // the render tree at all (e.g. its whole subtree was disposed), the
  // menu is closed instead of showing a stale panel. Scrolling the button
  // behind the app bar no longer closes the menu, and — with the FIX
  // above — no longer stacks the panel over the app bar either; the
  // ClipRect just stops painting the part that would overlap it. Closing
  // only happens via the filter icon toggle, the Done button, or tapping
  // outside the panel.
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

  void _closeFilterMenu() {
    // NEW: detach the scroll listener whenever the menu closes.
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

  // The Connectivity (4G / 2G) filter matches against the badges actually
  // displayed on the card (`badge` / `secondBadge`), so a product shows
  // up under "4G" or "2G" only when that badge is present — not merely
  // because `connectivity` lists it.
  bool _matchesAttributeFilters(ProductData product) {
    if (_selectedConnectivity.isNotEmpty) {
      final Set<String> displayedConnectivityBadges = {
        if (product.badge == '4G' || product.badge == '2G') product.badge!,
        if (product.secondBadge == '4G' || product.secondBadge == '2G')
          product.secondBadge!,
      };
      if (!displayedConnectivityBadges.any(_selectedConnectivity.contains)) {
        return false;
      }
    }
    if (_selectedVehicleTypes.isNotEmpty &&
        !product.vehicleTypes.any(_selectedVehicleTypes.contains)) {
      return false;
    }
    if (_newOnly && product.badge != 'new') {
      return false;
    }
    return true;
  }

  // ---------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    SectionScrollBus.instance.pendingKey.addListener(_handleFooterNavigation);
    // NEW: react to the top-nav "Products & Solutions" dropdown.
    ProductFilterController.selectedCategory.addListener(
      _handleProductFilterNavigation,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadProductImages();
      _handleFooterNavigation();
      // NEW: in case a category was already selected before this section
      // finished its first frame (e.g. very first navigation into the
      // Products tab), pick it up immediately as well.
      _handleProductFilterNavigation();
    });
  }

  @override
  void dispose() {
    SectionScrollBus.instance.pendingKey.removeListener(
      _handleFooterNavigation,
    );
    // NEW
    ProductFilterController.selectedCategory.removeListener(
      _handleProductFilterNavigation,
    );
    // NEW: make sure the scroll listener doesn't outlive this State.
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

    // Mark it handled so other sections' listeners don't also react to it.
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

  // NEW: reacts to the top-nav "Products & Solutions" dropdown items
  // (All Products / Trackers / Diagnostics / Gateways / Clusters / ADAS /
  // Solutions Hub). `_navigateToProductTab` in MainPage already switches
  // the IndexedStack to this section and calls
  // `ProductFilterController.select(filterKey)` — the labels it passes
  // are an exact match for `_filterTabs` labels, so we jump straight to
  // the matching tab and then scroll the hero/header out of view exactly
  // like the footer navigation does, so the tab bar + grid take over the
  // full screen.
  void _handleProductFilterNavigation() {
    final String? category = ProductFilterController.selectedCategory.value;
    if (category == null) return;

    final int targetIndex = _filterTabs.indexWhere(
      (tab) => tab.label == category,
    );
    if (targetIndex != -1) {
      _selectFilterIndex(targetIndex);
    }

    // Consume it so picking the same category again later still fires.
    ProductFilterController.selectedCategory.value = null;

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

  Future<void> _preloadProductImages() async {
    try {
      final imagePaths = _products.map((product) => product.image).toSet();

      await Future.wait(
        imagePaths.map((path) => precacheImage(AssetImage(path), context)),
      );

      await Future.delayed(const Duration(seconds: 3));
    } catch (e) {
      debugPrint('Error preloading product images: $e');
    }

    if (!mounted) return;

    setState(() {
      _imagesLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          key: _productRangeKey,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 72),
              child: widget.header,
            ),

            // UPDATED: category tabs bar + the new attribute filter icon
            // button, laid out side by side.
            Positioned(
              left: 24,
              right: 24, //gap(filter bar)
              bottom: 35,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 48,
                  ),
                  // 1310 = original 1250 tabs-bar budget + 46 icon button + 14 gap
                  child: SizedBox(
                    width: 1310,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: _buildFilterTabsBar()),
                        const SizedBox(width: 14),
                        _buildAttributeFilterButton(),
                      ],
                    ),
                  ),
                ),
              ),
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
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(_filterTabs.length * 2 - 1, (index) {
          if (index.isOdd) {
            return const SizedBox(width: 65); //gap
          }

          final int tabIndex = index ~/ 2;
          return _buildFilterTab(index: tabIndex, tab: _filterTabs[tabIndex]);
        }),
      ),
    );
  }

  Widget _buildFilterTab({required int index, required _FilterTabData tab}) {
    final bool isSelected = index == _selectedFilterIndex;

    return Material(
      color: tTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        mouseCursor: SystemMouseCursors.click,
        onTap: () => _selectFilterIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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

  // NEW: SMALL FILTER ICON BUTTON — sits right next to the tabs bar and
  // opens a floating dropdown panel with every attribute filter inside it.

  Widget _buildAttributeFilterButton() {
    final bool highlighted = _filterMenuOpen || _hasActiveAttributeFilters;

    return Container(
      key: _filterButtonKey,
      child: Material(
        color: tTransparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          mouseCursor: SystemMouseCursors.click,
          onTap: _toggleFilterMenu,
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: highlighted ? tBlue3 : tWhite,
              shape: BoxShape.circle,
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
                  child: Icon(
                    Icons.tune_rounded,
                    size: 20,
                    color: highlighted ? tWhite : tBlue3,
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
        borderRadius: BorderRadius.circular(16),
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

    // ALL PRODUCTS — apply the attribute filters within each category.

    if (selectedLabel == 'All Products') {
      final List<String> categories = [
        'Trackers',
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

  // NEW: shown when a category has products, but none match the active
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
        color: tTransparent,
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

class ProductData {
  final String image;
  final String? image1;
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
  final String? image6;
  final String? image7;
  final String? video; // ADD THIS

  // NEW: used by the attribute filter bar (Connectivity + Vehicle Type)
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
    this.video, // ADD THIS
    required this.badge,
    required this.badgeColor,
    this.secondBadge,
    this.secondBadgeColor,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.description,
    this.connectivity = const [],
    this.vehicleTypes = const [],
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
