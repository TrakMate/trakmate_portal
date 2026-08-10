import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class AboutusSection extends StatefulWidget {
  const AboutusSection({super.key});

  @override
  State<AboutusSection> createState() => _AboutusSectionState();
}

class _AboutusSectionState extends State<AboutusSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAboutUsHeader(),
          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: tBlue1.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: buildMissionVisionCard(
                      icon: 'icons/impact.svg',
                      title: 'Our Mission',
                      description:
                          'To deliver innovative and reliable engineering solutions that empower businesses and improve lives through technology and excellence.',
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    width: 3,
                    height: 100,
                    color: tOrange1,
                  ),
                  const SizedBox(height: 30),

                  Expanded(
                    child: buildMissionVisionCard(
                      icon: 'icons/vision.svg',
                      title: 'Our Vision',
                      description:
                          'To become a global leader in engineering innovation, driving sustainable growth and creating lasting value for our customers.',
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [tBlue2, tBlue3],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: tOrange1, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildAchievementsCard(
                    icon: 'icons/collaboration.svg',
                    title: '110+',
                    subtitle: 'Team Members',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/badge.svg',
                    title: '12+',
                    subtitle: 'Years of excellence',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/globe.svg',
                    title: '6+',
                    subtitle: 'Countries Served',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/delivery.svg',
                    title: '750+',
                    subtitle: 'Products Delivered',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/manufacture.svg',
                    title: '2L+',
                    subtitle: 'Units Manufactured',
                  ),
                  _divider(),
                  buildAchievementsCard(
                    icon: 'icons/handshake.svg',
                    title: '25+',
                    subtitle: 'Happy Clients',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _storyContent()),

                const SizedBox(width: 40),

                Expanded(flex: 3, child: _storyImage()),

                const SizedBox(width: 40),

                Expanded(flex: 3, child: _timeline()),
              ],
            ),
          ),

          SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              children: [
                Text(
                  "Meet Our Leadership",
                  style: GoogleFonts.manrope(
                    color: tBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "Experienced Leaders. Inspired Vision.",
                  style: GoogleFonts.manrope(
                    color: tBlack,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: buildTeamCard(
                        image: "images/img2.jpg",
                        name: "NL Srinivas",
                        designation: "Co-Founder & CEO",
                      ),
                    ),

                    const SizedBox(width: 30),

                    Expanded(
                      child: buildTeamCard(
                        image: "images/img1.jpg",
                        name: "M Pramod",
                        designation: "Co-Founder & COO",
                      ),
                    ),

                    const SizedBox(width: 30),

                    Expanded(
                      child: buildTeamCard(
                        image: "images/img2.jpg",
                        name: "S Srinivasa",
                        designation: "Co-Founder & CTO",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 40),

          FooterSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, width: 30, height: 30, color: tOrange1),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.manrope(
              color: tWhite,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: tWhite.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tBlue2, tBlue3],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About TrakMate',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: tOrange1,
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.manrope(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      color: tWhite,
                    ),
                    children: [
                      const TextSpan(text: "Engineering Innovation.\n"),
                      TextSpan(
                        text: "Building a Smarter Tomorrow.",
                        style: TextStyle(
                          color: tOrange1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  'TrakMate is a product engineering and manufacturing company delivering end-to-end solutions in IoT, Embedded Systems, Software, Hardware Design and Manufacturing.',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    color: tWhite,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeaderIntroCard(
                      icon: 'icons/innovation.svg',
                      title: 'Innovation',
                      description: 'At the core of everything we do',
                    ),
                    _buildHeaderIntroCard(
                      icon: 'icons/integrity.svg',
                      title: 'Integrity',
                      description: 'We build trust through transparency',
                    ),
                    _buildHeaderIntroCard(
                      icon: 'icons/collaboration.svg',
                      title: 'Collaboration',
                      description: 'Stronger together, better outcomes',
                    ),
                    _buildHeaderIntroCard(
                      icon: 'icons/impact.svg',
                      title: 'Impact',
                      description: 'Technology that makes a difference',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 40),
          Expanded(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/company.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomRight: Radius.circular(75),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMissionVisionCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: tBlue3,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(icon, width: 35, height: 35, color: tWhite),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: tBlue3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: GoogleFonts.manrope(
                  color: tBlue3,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAchievementsCard({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon, width: 40, height: 40, color: tOrange1),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.manrope(
                color: tWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.manrope(
                color: tWhite,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: 2,
      height: 65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.25),
            tOrange1,
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
      ),
    );
  }

  Widget _storyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Story",
          style: GoogleFonts.manrope(
            color: tBlue,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Built on Passion.\nDriven by Purpose.",
          style: GoogleFonts.manrope(
            color: tBlack,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),

        const SizedBox(height: 10),
        Container(
          width: 75,
          height: 2,
          decoration: BoxDecoration(color: tOrange1),
        ),

        const SizedBox(height: 20),

        Text(
          "TrakMate was founded with a simple idea – use technology to solve real-world problems and create meaningful connections. What started as a small team of engineers and dreamers has grown into a technology partner for businesses across the globe.",
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: tBlack,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "From building intelligent IoT devices to developing robust embedded systems and scalable software platforms, our journey is fueled by innovation, trust, and a relentless focus on our customers.",
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: tBlack,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _storyImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/workspace.jpg"),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(75),
          bottomRight: Radius.circular(75),
        ),
      ),
    );
  }

  Widget _timeline() {
    return Column(
      children: [
        _timelineItem(
          "2014",
          "The Beginning",
          "TrakMate was founded with a vision to innovate",
          false,
        ),

        _timelineItem(
          "2016",
          "Expanding Solutions",
          "Launched IoT products and embedded solutions",
          false,
        ),

        _timelineItem(
          "2019",
          "Global Growth",
          "Expanded into international markets and built strong partnerships",
          false,
        ),

        _timelineItem(
          "Today",
          "Shaping the Future",
          "Continuously innovating to build a smarter, connected world",
          false,
        ),
      ],
    );
  }

  Widget _timelineItem(
    String year,
    String title,
    String description,
    bool first,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: tTransparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: tBlue, width: 1),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: tBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              if (!first)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          tBlue.withOpacity(0.4),
                          tBlue,
                          tBlue.withOpacity(0.4),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: tBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: tBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    description,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: tBlack,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTeamCard({
    required String image,
    required String name,
    required String designation,
  }) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Section
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.asset(image, fit: BoxFit.cover),
            ),

            // Name & Designation Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              color: tWhite,
              child: Column(
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: tBlack,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    designation,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: tOrange1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
