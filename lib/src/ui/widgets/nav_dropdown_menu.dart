import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';

// DATA MODEL — one entry in the dropdown

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
  // Tracks whichever dropdown is currently open, across ALL NavDropdownMenu
  // instances. Guarantees that hovering a second menu always closes the first,
  // even when the menus don't share a NavDropdownGroupController.
  static _NavDropdownMenuState? _activeMenu;

  bool _dropdownOpen = false;

  // Hover tracking: the menu stays open while the cursor is over EITHER the
  // trigger (label/arrow) or the dropdown panel.
  bool _hoverTrigger = false;
  bool _hoverPanel = false;
  Timer? _closeTimer;

  // Delay that lets the cursor cross the small gap between trigger and panel.
  static const Duration _closeDelay = Duration(milliseconds: 150);

  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();

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
    _closeTimer?.cancel();
    widget.groupController?.removeListener(_handleGroupChange);
    if (_activeMenu == this) _activeMenu = null;
    super.dispose();
  }

  void _handleGroupChange() {
    if (_dropdownOpen && widget.groupController!.openId != this) {
      _forceClose();
    }
  }

  void _open() {
    _closeTimer?.cancel();

    // Close any other dropdown that is still open.
    if (_activeMenu != null && _activeMenu != this) {
      _activeMenu!._forceClose();
    }
    _activeMenu = this;

    widget.groupController?.open(this);
    if (!_dropdownOpen) {
      setState(() => _dropdownOpen = true);
    }
    _overlayController.show();
  }

  void _forceClose() {
    _closeTimer?.cancel();
    _hoverTrigger = false;
    _hoverPanel = false;

    if (_activeMenu == this) _activeMenu = null;
    if (_dropdownOpen && mounted) {
      setState(() => _dropdownOpen = false);
    }
    _overlayController.hide();
  }

  void _close() {
    _forceClose();
    widget.groupController?.close(this);
  }

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

  // ---------------------------------------------------------------------------
  // HOVER HANDLING
  // ---------------------------------------------------------------------------

  void _onTriggerEnter() {
    _hoverTrigger = true;
    _closeTimer?.cancel();
    if (!_dropdownOpen) {
      _open();
    }
  }

  void _onTriggerExit() {
    _hoverTrigger = false;
    _scheduleClose();
  }

  void _onPanelEnter() {
    _hoverPanel = true;
    _closeTimer?.cancel();
  }

  void _onPanelExit() {
    _hoverPanel = false;
    _scheduleClose();
  }

  void _scheduleClose() {
    _closeTimer?.cancel();
    _closeTimer = Timer(_closeDelay, () {
      if (!mounted) return;
      if (!_hoverTrigger && !_hoverPanel && _dropdownOpen) {
        _close();
      }
    });
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
          child: CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            offset: const Offset(0, 8),

            child: TapRegion(
              groupId: this,
              child: Align(
                alignment: Alignment.topCenter,
                // Hover tracking for the panel itself.
                child: MouseRegion(
                  onEnter: (_) => _onPanelEnter(),
                  onExit: (_) => _onPanelExit(),
                  child: _buildDropdownMenu(),
                ),
              ),
            ),
          ),
        );
      },

      child: CompositedTransformTarget(
        link: _layerLink,

        child: TapRegion(
          groupId: this,
          onTapOutside: (event) {
            if (_dropdownOpen) _close();
          },
          child: MouseRegion(
            // Hover tracking for the trigger (label + arrow).
            onEnter: (_) => _onTriggerEnter(),
            onExit: (_) => _onTriggerExit(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // LABEL — tap navigates to the page
                      GestureDetector(
                        onTap: () {
                          _close();
                          widget.onLabelTap();
                        },
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

                      // ARROW — tap toggles the dropdown open/closed
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

                  Padding(
                    padding: const EdgeInsets.only(
                      right: 5 + 18.0,
                    ), //5 sizedbox+18 padding
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 2,
                      width: widget.isSelected ? 50 : 0,
                      decoration: const BoxDecoration(color: tOrange1),
                    ),
                  ),
                ],
              ),
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
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 34,
                height: 34,
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
            ],
          ),
        ),
      ),
    );
  }
}
