import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Standalone "Our Offices" section matching the supplied TrakMate reference.
///
/// Add this widget wherever the offices section should appear:
///   const OfficesSection()
///
/// Replace the sample branch details and map links below with your real data.
/// The image paths currently use images/company.png for all three branches.
const Color _teal = tBlue3;
const Color _navy = tBlue2;
const Color _ink = Color(0xFF102A78);
const Color _muted = Color(0xFF526783);
const Color _sectionTop = Color(0xFFF8FCFF);
const Color _sectionBottom = Color(0xFFF0F8FC);

class _OfficeData {
  final String photo;
  final String tag;
  final String city;
  final String country;
  final String address;
  final String phone;
  final String email;
  final String mapQuery;
  final String? mapUrl;
  final bool isHq;
  final String flag;

  const _OfficeData({
    required this.photo,
    required this.tag,
    required this.city,
    required this.country,
    required this.address,
    required this.phone,
    required this.email,
    required this.mapQuery,
    required this.flag,
    this.mapUrl,
    this.isHq = false,
  });

  Uri get mapsUri => Uri.parse(
    mapUrl ??
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(mapQuery)}',
  );
}

class OfficesSection extends StatelessWidget {
  const OfficesSection({super.key});

  static const List<_OfficeData> _offices = [
    _OfficeData(
      photo: 'images/company.png',
      tag: 'HEADQUARTERS',
      city: 'Bengaluru',
      country: 'Karnataka, India',
      address:
          'TrakMate Design Solutions Pvt Ltd\n'
          // '17G/46-3 and 17G/46-3-1\n'
          '1st & 2nd floor, MEI Road, Industrial suburb, Yeshwanthpura, Bengaluru -560022',
      phone: '+91 80 41532112',
      email: 'info@trakmate.com',
      mapQuery: 'TrakMate Design Solutions Pvt Ltd',
      mapUrl:
          'https://www.google.com/maps?q=TrakMate+Design+Solutions+Pvt+Ltd,+17G%2F46-3+and+17G%2F46-3-1,+1st+%26+2nd+floor,+MEI+Road,+Industrial+Suburb,+Yeshwanthpura,+Bengaluru+560022&z=18',
      flag: '🇮🇳',
      // isHq: true,
    ),
    _OfficeData(
      photo: 'images/company.png',
      tag: 'MIDDLE EAST',
      city: 'Dubai',
      country: 'United Arab Emirates',
      address:
          'TrakMate Design Solutions Pvt Ltd\n'
          // '17G/46-3 and 17G/46-3-1\n'
          '1st & 2nd floor, MEI Road, Industrial suburb, Yeshwanthpura, Bengaluru -560022',
      phone: '+91 80 41532112',
      email: 'info@trakmate.com',
      mapQuery: 'TrakMate Design Solutions Pvt Ltd',
      mapUrl:
          'https://www.google.com/maps?q=TrakMate+Design+Solutions+Pvt+Ltd,+17G%2F46-3+and+17G%2F46-3-1,+1st+%26+2nd+floor,+MEI+Road,+Industrial+Suburb,+Yeshwanthpura,+Bengaluru+560022&z=18',
      flag: '🇦🇪',
    ),
    _OfficeData(
      photo: 'images/company.png',
      tag: 'NORTH AMERICA',
      city: 'Austin',
      country: 'Texas, USA',
      address:
          'TrakMate Design Solutions Pvt Ltd\n'
          // '17G/46-3 and 17G/46-3-1\n'
          '1st & 2nd floor, MEI Road, Industrial suburb, Yeshwanthpura, Bengaluru -560022',
      phone: '+91 80 41532112',
      email: 'info@trakmate.com',
      mapQuery: 'TrakMate Design Solutions Pvt Ltd',
      mapUrl:
          'https://www.google.com/maps?q=TrakMate+Design+Solutions+Pvt+Ltd,+17G%2F46-3+and+17G%2F46-3-1,+1st+%26+2nd+floor,+MEI+Road,+Industrial+Suburb,+Yeshwanthpura,+Bengaluru+560022&z=18',
      flag: '🇺🇸',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //container color
    return Container(
      width: double.infinity,
      clipBehavior: Clip.none,
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [_sectionTop, _sectionBottom, Colors.white],
      //   ),
      // ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // const Positioned.fill(child: _OfficeBackgroundDecoration()),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 20, 28, 24),
            child: Column(
              children: [
                Text(
                  'OUR OFFICES',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tOrange1,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                _buildTitle(),
                const SizedBox(height: 5),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Text(
                    'Operating across key global markets to deliver telematics and '
                    'IoT solutions with local expertise and support.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color: _muted,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 820) {
                      const gap = 16.0;
                      final cardWidth = (constraints.maxWidth - gap * 2) / 3;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < _offices.length; i++) ...[
                            if (i > 0) const SizedBox(width: gap),
                            SizedBox(
                              width: cardWidth,
                              child: _OfficeCard(office: _offices[i]),
                            ),
                          ],
                        ],
                      );
                    }

                    // TABLET: 2 cards per row (centered), wraps to 2nd row.
                    if (constraints.maxWidth >= 560) {
                      const gap = 16.0;
                      final cardWidth = (constraints.maxWidth - gap) / 2;
                      return Wrap(
                        alignment: WrapAlignment.center,
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          for (final office in _offices)
                            SizedBox(
                              width: cardWidth,
                              child: _OfficeCard(office: office),
                            ),
                        ],
                      );
                    }

                    // MOBILE: single column (same as before)
                    return Column(
                      children: [
                        for (var i = 0; i < _offices.length; i++) ...[
                          if (i > 0) const SizedBox(height: 18),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 460),
                            child: _OfficeCard(office: _offices[i]),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.manrope(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          // height: 1.15,
          // letterSpacing: -1.0,
          color: tBlue2,
        ),
        children: const [
          TextSpan(text: 'Global Presence, '),
          TextSpan(text: 'Local Support', style: TextStyle(color: tBlue2)),
        ],
      ),
    );
  }
}

class _OfficeCard extends StatefulWidget {
  final _OfficeData office;

  const _OfficeCard({required this.office});

  @override
  State<_OfficeCard> createState() => _OfficeCardState();
}

class _OfficeCardState extends State<_OfficeCard> {
  bool _hovered = false;

  Future<void> _openDirections() async {
    final office = widget.office;
    final uri = office.mapsUri;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final office = widget.office;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.97),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _hovered ? _teal.withOpacity(0.38) : const Color(0xFFEAF1F6),
          ),
          boxShadow: [
            BoxShadow(
              color: _navy.withOpacity(_hovered ? 0.12 : 0.065),
              blurRadius: _hovered ? 24 : 15,
              offset: Offset(0, _hovered ? 9 : 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPhotoHeader(office),
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 11, 17, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        office.flag,
                        style: const TextStyle(fontSize: 21, height: 1.1),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              office.city,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                color: _ink,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              office.country,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                color: _muted,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _infoRow('icons/location.svg', office.address, maxLines: 2),
                  const SizedBox(height: 8),
                  _infoRow('icons/phone.svg', office.phone),
                  const SizedBox(height: 8),
                  _infoRow('icons/mail.svg', office.email),
                  const SizedBox(height: 12),
                  _directionsButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoHeader(_OfficeData office) {
    return SizedBox(
      height: 160,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: const Color(0xFFDDEEF8),
            child: Image.asset(
              office.photo,
              fit: BoxFit.cover,
              cacheWidth: 800,
              errorBuilder:
                  (_, __, ___) => const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_navy, Color(0xFF148FA3)],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.apartment_rounded,
                        size: 48,
                        color: Colors.white70,
                      ),
                    ),
                  ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x180B286C),
                  Color(0x000B286C),
                  Color(0x500B286C),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 11,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: tBlue2,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: tWhite.withOpacity(0.25)),
                boxShadow: [
                  BoxShadow(
                    color: tBlack.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                office.tag,
                style: GoogleFonts.manrope(
                  color: tWhite,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.25,
                ),
              ),
            ),
          ),
          if (office.isHq)
            Positioned(
              right: 12,
              top: 11,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: tOrange1,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoRow(String iconPath, String value, {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 19,
          child: SvgPicture.asset(
            iconPath,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(_teal, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tBlack,
              fontSize: 11,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _directionsButton() {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _openDirections,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: _hovered ? tBlue2 : tBlue2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Directions',
                  style: GoogleFonts.manrope(
                    color: _hovered ? tWhite : tWhite,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // const Spacer(),
                const SizedBox(width: 20),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 17,
                  color: _hovered ? tWhite : tWhite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Soft geometric shapes echo the pale blue background in the reference.
class _OfficeBackgroundDecoration extends StatelessWidget {
  const _OfficeBackgroundDecoration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OfficeBackgroundPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _OfficeBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pale = Paint()..color = const Color(0xFFE0F3FC).withOpacity(0.72);
    final lighter = Paint()..color = Colors.white.withOpacity(0.65);
    final stroke =
        Paint()
          ..color = const Color(0xFFBCE6F7).withOpacity(0.45)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;

    void triangle(double x, double y, double w, double h, Paint paint) {
      final path =
          Path()
            ..moveTo(x, y + h)
            ..lineTo(x + w / 2, y)
            ..lineTo(x + w, y + h)
            ..close();
      canvas.drawPath(path, paint);
    }

    triangle(size.width * 0.035, 30, 32, 28, pale);
    triangle(size.width * 0.10, 54, 25, 22, pale);
    triangle(size.width * 0.145, 76, 20, 18, lighter);
    triangle(size.width * 0.065, 104, 26, 23, lighter);

    final topRight = Rect.fromCircle(
      center: Offset(size.width * 1.02, size.height * 0.20),
      radius: size.height * 0.72,
    );
    canvas.drawArc(topRight, 1.55, 3.1, false, stroke..strokeWidth = 24);
    final leftArc = Rect.fromCircle(
      center: Offset(-size.width * 0.02, size.height * 0.68),
      radius: size.height * 0.42,
    );
    canvas.drawArc(leftArc, -1.2, 2.1, false, stroke..strokeWidth = 18);

    final dots = Paint()..color = const Color(0xFFCBEAF8).withOpacity(0.7);
    for (final point in <Offset>[
      Offset(size.width * 0.22, size.height * 0.22),
      Offset(size.width * 0.78, size.height * 0.14),
      Offset(size.width * 0.87, size.height * 0.73),
      Offset(size.width * 0.30, size.height * 0.85),
    ]) {
      canvas.drawCircle(point, 2.2, dots);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
