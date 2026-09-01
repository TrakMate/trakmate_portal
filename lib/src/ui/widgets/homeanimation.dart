import 'package:flutter/material.dart';

class HomeReveal extends StatefulWidget {
  final Widget child;

  /// Animation duration.
  final Duration duration;

  /// Delay after the widget enters the viewport.
  final Duration delay;
  final Offset beginOffset;
  final double beginScale;
  final Curve curve;
  final double visibilityThreshold;

  /// Whether the animation should happen only once.
  final bool once;

  const HomeReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.beginOffset = const Offset(0, 0.12),
    this.beginScale = 1.0,
    this.curve = Curves.easeOutCubic,
    this.visibilityThreshold = 0.08,
    this.once = true,
  });

  @override
  State<HomeReveal> createState() => _HomeRevealState();
}

class _HomeRevealState extends State<HomeReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool _hasAnimated = false;
  bool _isWaitingForDelay = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _createAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _checkVisibility();
    });
  }

  void _createAnimations() {
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(curvedAnimation);

    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(curvedAnimation);
  }

  void _checkVisibility() {
    if (!mounted) return;

    if (widget.once && _hasAnimated) {
      return;
    }

    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final size = renderObject.size;

    final position = renderObject.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;

    final widgetTop = position.dy;
    final widgetBottom = widgetTop + size.height;

    // Calculate how much of the widget is currently visible.
    final visibleTop = widgetTop.clamp(0.0, screenHeight);
    final visibleBottom = widgetBottom.clamp(0.0, screenHeight);

    final visibleHeight = (visibleBottom - visibleTop).clamp(0.0, size.height);

    final visibilityRatio = size.height > 0 ? visibleHeight / size.height : 0.0;

    final isVisible = visibilityRatio >= widget.visibilityThreshold;

    if (isVisible) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    if (!mounted) return;

    if (widget.once && _hasAnimated) {
      return;
    }

    if (_isWaitingForDelay) {
      return;
    }

    _isWaitingForDelay = true;

    if (widget.delay == Duration.zero) {
      _playAnimation();
      return;
    }

    Future.delayed(widget.delay, () {
      if (!mounted) return;

      _playAnimation();
    });
  }

  void _playAnimation() {
    if (!mounted) return;

    _isWaitingForDelay = false;
    _hasAnimated = true;

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification ||
            notification is UserScrollNotification) {
          _checkVisibility();
        }

        return false;
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HomeStaggeredReveal extends StatefulWidget {
  final List<Widget> children;

  /// Delay before the first item.
  final Duration initialDelay;

  /// Delay between each item.
  final Duration staggerDelay;

  /// Animation duration of each item.
  final Duration duration;

  /// Starting position.
  final Offset beginOffset;

  /// Starting scale.
  final double beginScale;

  /// Animation curve.
  final Curve curve;

  /// Viewport visibility threshold.
  final double visibilityThreshold;

  /// Whether the animation should happen only once.
  final bool once;

  const HomeStaggeredReveal({
    super.key,
    required this.children,
    this.initialDelay = Duration.zero,
    this.staggerDelay = const Duration(milliseconds: 80),
    this.duration = const Duration(milliseconds: 600),
    this.beginOffset = const Offset(0, 0.10),
    this.beginScale = 0.97,
    this.curve = Curves.easeOutCubic,
    this.visibilityThreshold = 0.05,
    this.once = true,
  });

  @override
  State<HomeStaggeredReveal> createState() => _HomeStaggeredRevealState();
}

class _HomeStaggeredRevealState extends State<HomeStaggeredReveal> {
  final GlobalKey _visibilityKey = GlobalKey();

  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted) return;

    if (widget.once && _hasStarted) {
      return;
    }

    final renderObject = _visibilityKey.currentContext?.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final size = renderObject.size;
    final position = renderObject.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;

    final widgetTop = position.dy;
    final widgetBottom = widgetTop + size.height;

    final visibleTop = widgetTop.clamp(0.0, screenHeight);
    final visibleBottom = widgetBottom.clamp(0.0, screenHeight);

    final visibleHeight = (visibleBottom - visibleTop).clamp(0.0, size.height);

    final ratio = size.height > 0 ? visibleHeight / size.height : 0.0;

    if (ratio >= widget.visibilityThreshold) {
      setState(() {
        _hasStarted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification ||
            notification is UserScrollNotification) {
          _checkVisibility();
        }

        return false;
      },
      child: Column(
        key: _visibilityKey,
        children: [
          for (int i = 0; i < widget.children.length; i++)
            HomeReveal(
              duration: widget.duration,
              delay: widget.initialDelay + (widget.staggerDelay * i),
              beginOffset: widget.beginOffset,
              beginScale: widget.beginScale,
              curve: widget.curve,
              visibilityThreshold: 0.0,
              once: widget.once,
              child: widget.children[i],
            ),
        ],
      ),
    );
  }
}

class HomeFade extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double beginOpacity;
  final bool once;

  const HomeFade({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.beginOpacity = 0.0,
    this.once = true,
  });

  @override
  State<HomeFade> createState() => _HomeFadeState();
}

class _HomeFadeState extends State<HomeFade>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: widget.beginOpacity,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted) return;

    if (widget.once && _hasAnimated) {
      return;
    }

    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final position = renderObject.localToGlobal(Offset.zero);
    final size = renderObject.size;

    final screenHeight = MediaQuery.of(context).size.height;

    final widgetTop = position.dy;
    final widgetBottom = widgetTop + size.height;

    if (widgetBottom > 0 && widgetTop < screenHeight) {
      _hasAnimated = true;

      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification) {
          _checkVisibility();
        }

        return false;
      },
      child: FadeTransition(opacity: _animation, child: widget.child),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HomeScaleReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double beginScale;
  final Curve curve;
  final bool once;

  const HomeScaleReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.beginScale = 0.94,
    this.curve = Curves.easeOutCubic,
    this.once = true,
  });

  @override
  State<HomeScaleReveal> createState() => _HomeScaleRevealState();
}

class _HomeScaleRevealState extends State<HomeScaleReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted) return;

    if (widget.once && _hasAnimated) {
      return;
    }

    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final position = renderObject.localToGlobal(Offset.zero);
    final size = renderObject.size;

    final screenHeight = MediaQuery.of(context).size.height;

    final widgetTop = position.dy;
    final widgetBottom = widgetTop + size.height;

    if (widgetBottom > 0 && widgetTop < screenHeight) {
      _hasAnimated = true;

      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification) {
          _checkVisibility();
        }

        return false;
      },
      child: ScaleTransition(scale: _animation, child: widget.child),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

enum HomeSlideDirection { up, down, left, right }

class HomeSlideReveal extends StatelessWidget {
  final Widget child;
  final HomeSlideDirection direction;
  final Duration duration;
  final Duration delay;
  final double distance;
  final double beginScale;
  final Curve curve;
  final bool once;

  const HomeSlideReveal({
    super.key,
    required this.child,
    this.direction = HomeSlideDirection.up,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.distance = 0.10,
    this.beginScale = 1.0,
    this.curve = Curves.easeOutCubic,
    this.once = true,
  });

  Offset get _offset {
    switch (direction) {
      case HomeSlideDirection.up:
        return Offset(0, distance);

      case HomeSlideDirection.down:
        return Offset(0, -distance);

      case HomeSlideDirection.left:
        return Offset(distance, 0);

      case HomeSlideDirection.right:
        return Offset(-distance, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeReveal(
      duration: duration,
      delay: delay,
      beginOffset: _offset,
      beginScale: beginScale,
      curve: curve,
      once: once,
      child: child,
    );
  }
}
