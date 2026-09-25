import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/ui/widgets/mobile_app.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart'; // NEW: for SolutionCardShimmer
import 'package:trakmate_portal/src/ui/widgets/web_app.dart';

import '../../utils/colors.dart';
import 'solutions_detail.dart';
// import 'mobile_app.dart';
// import 'web_app.dart';

class SolutionsHubPage extends StatefulWidget {
  const SolutionsHubPage({super.key});

  @override
  State<SolutionsHubPage> createState() => _SolutionsHubPageState();
}

class _SolutionsHubPageState extends State<SolutionsHubPage> {
  // NEW: mirrors _imagesLoading in BuildProductSection.
  bool _imagesLoading = true;

  final List<SolutionDetailsData> _solutions = <SolutionDetailsData>[
    // MOBILE APPS
    SolutionDetailsData(
      backgroundImage: 'images/mobileapps1.png',
      icon: 'icons/mobile.svg',
      iconBackgroundColor: tOrange1,
      eyebrow: 'MOBILE APPLICATIONS',
      title: 'Mobile Apps',
      description:
          'Powerful and intuitive mobile applications designed to connect users, devices and businesses on the go.',
      cards: const [
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/phone.svg',
          'Mobile App Development',
          'Custom mobile applications designed for smooth, intuitive and reliable user experiences.',
        ),
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/globe.svg',
          'Cloud Integration',
          'Connect mobile applications with cloud platforms, APIs and real-time business data.',
        ),
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/iot.svg',
          'Device Connectivity',
          'Connect mobile applications with connected devices, vehicles and IoT ecosystems.',
        ),
        SolutionCardData(
          'images/mobileapps.jpg',
          'icons/globe.svg',
          'Data & Analytics',
          'Present meaningful business information through dashboards, reports and analytics.',
        ),
      ],
    ),

    // WEB APPS
    SolutionDetailsData(
      backgroundImage: 'images/webapps1.png',
      icon: 'icons/laptop.svg',
      iconBackgroundColor: tBlue3,
      eyebrow: 'WEB APPLICATIONS',
      title: 'Web Apps',
      description:
          'Scalable and secure web applications that transform complex business processes into simple digital experiences.',
      cards: const [
        SolutionCardData(
          'images/trakfleet.png',
          'icons/laptop.svg',
          'TrakFleet',
          'Scalable web platforms built around your business workflows, users and operational requirements.',
        ),
        SolutionCardData(
          'images/trakfleet.png',
          'icons/globe.svg',
          'Trakblue',
          'Secure cloud-connected applications with centralized data and easy access from anywhere.',
        ),
        SolutionCardData(
          'images/trakfleet.png',
          'icons/iot.svg',
          'IoT Integration',
          'Connect web applications with devices, vehicles and real-time IoT data.',
        ),
        SolutionCardData(
          'images/trakfleet.png',
          'icons/globe.svg',
          'Dashboards & Analytics',
          'Transform business and device data into clear dashboards, reports and actionable insights.',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadSolutionImages();
    });
  }

  // NEW
  Future<void> _preloadSolutionImages() async {
    try {
      final imagePaths = _solutions.map((s) => s.backgroundImage).toSet();

      // await Future.wait(
      //   imagePaths.map((path) => precacheImage(AssetImage(path), context)),
      // );
      // await Future.delayed(const Duration(seconds: 3)); // fr testing
      await Future.wait([
        Future.wait(
          imagePaths.map((path) => precacheImage(AssetImage(path), context)),
        ),

        Future.delayed(const Duration(seconds: 2)),
      ]);
    } catch (e) {
      debugPrint('Error preloading solution images: $e');
    }

    if (!mounted) return;

    setState(() {
      _imagesLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: tWhite,
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 55),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 25,
            runSpacing: 25,

            children:
                _imagesLoading
                    ? List.generate(
                      _solutions.length,
                      (_) => const SizedBox(
                        width: 420, // same card width as the real cards
                        child: SolutionCardShimmer(),
                      ),
                    )
                    : _solutions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final solution = entry.value;

                      return SizedBox(
                        width: 420, // card width
                        child: _SolutionCard(
                          backgroundImage: solution.backgroundImage,
                          icon: solution.icon,
                          iconBackgroundColor: solution.iconBackgroundColor,
                          eyebrow: solution.eyebrow,
                          title: solution.title,
                          description: solution.description,

                          // NAVIGATION
                          onTap: () {
                            if (index == 0) {
                              // MOBILE APPS
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MobileApp(),
                                ),
                              );
                            } else if (index == 1) {
                              // WEB APPS
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const WebApp(),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SolutionCard extends StatefulWidget {
  final String backgroundImage, icon, eyebrow, title, description;
  final Color iconBackgroundColor;
  final VoidCallback onTap;

  const _SolutionCard({
    required this.backgroundImage,
    required this.icon,
    required this.iconBackgroundColor,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_SolutionCard> createState() => _SolutionCardState();
}

class _SolutionCardState extends State<_SolutionCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.identity()..translate(0.0, hovering ? -7.0 : 0.0),
          height: 390, // card height
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: tBlack.withOpacity(hovering ? .14 : .10),
                blurRadius: hovering ? 24 : 20,
                offset: Offset(0, hovering ? 10 : 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Image.asset(
                      widget.backgroundImage,
                      fit: BoxFit.cover,
                      frameBuilder: (
                        context,
                        child,
                        frame,
                        wasSynchronouslyLoaded,
                      ) {
                        // Already decoded/cached -> show immediately, no shimmer flash.
                        if (wasSynchronouslyLoaded) return child;

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          // Force non-positioned children to fill the Stack with TIGHT
                          // constraints (StackFit.expand), matching what the parent SizedBox
                          // gives us. Without this, Stack hands the child LOOSE constraints
                          // and Image sizes itself to the asset's own aspect ratio instead
                          // of filling 420x250 — that's what caused the narrower image on revisit.
                          layoutBuilder: (currentChild, previousChildren) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                ...previousChildren,
                                if (currentChild != null) currentChild,
                              ],
                            );
                          },
                          child:
                              frame != null
                                  ? SizedBox.expand(
                                    key: const ValueKey('image'),
                                    child: child,
                                  )
                                  : const SizedBox.expand(
                                    key: ValueKey('shimmer'),
                                    child: ShimmerBox(height: 250),
                                  ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(color: tBlue3),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 35, 22, 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 1),

                        Text(
                          widget.title,
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: tBlue2,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          widget.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 12.5,
                            color: tBlack.withOpacity(.6),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ICON
              Positioned(
                top: 225,
                left: 20,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.iconBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    widget.icon,
                    width: 26,
                    height: 26,
                    color: tWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
