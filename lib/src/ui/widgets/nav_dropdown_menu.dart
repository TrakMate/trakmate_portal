import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';

// ============================================================================
// DATA MODEL — one entry in the dropdown
// ============================================================================

class NavDropdownItem {
  final String label;
  final String icon;
  final VoidCallback onTap;

  const NavDropdownItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}

// ============================================================================
// GROUP CONTROLLER — ensures only one dropdown is open at a time
// ============================================================================

class NavDropdownGroupController extends ChangeNotifier {
  Object? _openId;

  Object? get openId => _openId;

  void open(Object id) {
    if (_openId != id) {
      _openId = id;
      notifyListeners();
    }
  }

  void close(Object id) {
    if (_openId == id) {
      _openId = null;
      notifyListeners();
    }
  }
}

// ============================================================================
// REUSABLE NAV DROPDOWN
// ============================================================================

class NavDropdownMenu extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onLabelTap;
  final List<NavDropdownItem> items;
  final double menuWidth;
  final NavDropdownGroupController? groupController;

  const NavDropdownMenu({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onLabelTap,
    required this.items,
    this.menuWidth = 245,
    this.groupController,
  });

  @override
  State<NavDropdownMenu> createState() => _NavDropdownMenuState();
}

class _NavDropdownMenuState extends State<NavDropdownMenu> {
  bool _dropdownOpen = false;

  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();

  // Key on the panel's own boundary — kept only so the panel can be built;
  // no manual hit-testing happens against it anymore.
  final GlobalKey _panelKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.groupController?.addListener(_handleGroupChange);
  }

  @override
  void didUpdateWidget(covariant NavDropdownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.groupController != widget.groupController) {
      oldWidget.groupController?.removeListener(_handleGroupChange);
      widget.groupController?.addListener(_handleGroupChange);
    }
  }

  @override
  void dispose() {
    widget.groupController?.removeListener(_handleGroupChange);
    super.dispose();
  }

  void _handleGroupChange() {
    if (_dropdownOpen && widget.groupController!.openId != this) {
      _forceClose();
    }
  }

  void _open() {
    widget.groupController?.open(this);
    if (!_dropdownOpen) {
      setState(() => _dropdownOpen = true);
    }
    _overlayController.show();
  }

  void _forceClose() {
    if (_dropdownOpen) {
      setState(() => _dropdownOpen = false);
    }
    _overlayController.hide();
  }

  void _close() {
    _forceClose();
    widget.groupController?.close(this);
  }

  // A short delay before the arrow's tap is allowed to toggle again. This
  // guards against the rare double pointer-event (down+up firing twice in
  // quick succession on some web/desktop backends) that was flipping the
  // menu open→closed→open on a single click. Purely a debounce, not a
  // behavior change.
  bool _toggleLocked = false;

  void _toggle() {
    if (_toggleLocked) return;
    _toggleLocked = true;
    Future.delayed(const Duration(milliseconds: 250), () {
      _toggleLocked = false;
    });

    if (_dropdownOpen) {
      _close();
    } else {
      _open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,

      overlayChildBuilder: (context) {
        final Size screenSize = MediaQuery.sizeOf(context);

        return SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          // No full-screen Listener anymore. TapRegion (below, on both the
          // trigger and the panel, sharing the same groupId) is the single
          // mechanism that detects outside taps — it's purpose-built for
          // this and, unlike a Listener/GestureDetector combo, it never
          // enters the tap gesture arena, so it can't race with the
          // arrow's onTap or a menu item's onTap.
          child: CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            offset: const Offset(0, 8),

            child: TapRegion(
              groupId: this,
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildDropdownMenu(),
              ),
            ),
          ),
        );
      },

      child: CompositedTransformTarget(
        link: _layerLink,

        // Opening/closing is purely click-driven: the arrow's onTap toggles
        // it, and TapRegion.onTapOutside (grouped with the panel above)
        // closes it when a tap lands on neither the trigger nor the panel.
        child: TapRegion(
          groupId: this,
          onTapOutside: (event) {
            if (_dropdownOpen) _close();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ----------------------------------------------------
                    // LABEL — tap navigates to the page
                    // ----------------------------------------------------
                    GestureDetector(
                      onTap: widget.onLabelTap,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: widget.isSelected ? tOrange1 : tBlack,
                          ),
                          child: Text(widget.label),
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    // ----------------------------------------------------
                    // ARROW — tap toggles the dropdown open/closed
                    // ----------------------------------------------------
                    GestureDetector(
                      onTap: _toggle,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedRotation(
                          turns: _dropdownOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: widget.isSelected ? tOrange1 : tBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 2,
                  width: widget.isSelected ? 50 : 0,
                  decoration: const BoxDecoration(color: tOrange1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // DROPDOWN MENU PANEL
  // ==========================================================================

  Widget _buildDropdownMenu() {
    return Material(
      key: _panelKey,
      color: Colors.transparent,
      child: Container(
        width: widget.menuWidth,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tBlack.withOpacity(0.08), width: 1),
          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(0.14),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < widget.items.length; i++) ...[
              _NavDropdownItemWidget(
                item: widget.items[i],
                onTap: () {
                  _close();
                  widget.items[i].onTap();
                },
              ),

              if (i != widget.items.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(height: 1, color: tBlack.withOpacity(0.06)),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SINGLE DROPDOWN ITEM ROW
// ============================================================================

class _NavDropdownItemWidget extends StatefulWidget {
  final NavDropdownItem item;
  final VoidCallback onTap;

  const _NavDropdownItemWidget({required this.item, required this.onTap});

  @override
  State<_NavDropdownItemWidget> createState() => _NavDropdownItemWidgetState();
}

class _NavDropdownItemWidgetState extends State<_NavDropdownItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),

      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? tBlue3.withOpacity(0.055) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color:
                      _hovered
                          ? tBlue3.withOpacity(0.09)
                          : tBlack.withOpacity(0.035),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    widget.item.icon,
                    width: 21,
                    height: 21,
                    colorFilter: ColorFilter.mode(
                      _hovered ? tBlue3 : tBlack.withOpacity(0.50),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 160),
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: _hovered ? FontWeight.w700 : FontWeight.w600,
                    color: _hovered ? tBlue3 : tBlack.withOpacity(0.72),
                  ),
                  child: Text(widget.item.label),
                ),
              ),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 160),
                opacity: _hovered ? 1 : 0,
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                  color: tOrange1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
