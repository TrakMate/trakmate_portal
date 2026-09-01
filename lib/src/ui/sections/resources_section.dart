import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

// import '../pages/blog.dart';
// import '../pages/case_studies.dart';
// import '../pages/documentation.dart';
// import '../pages/faq.dart';
// import '../pages/whitepapers.dart';
// import '../pages/webinar.dart';

class ResourcesSection extends StatefulWidget {
  final ValueChanged<int>? onNavigate;

  const ResourcesSection({super.key, this.onNavigate});

  @override
  State<ResourcesSection> createState() => _ResourcesSectionState();
}

class _ResourcesSectionState extends State<ResourcesSection> {
  // ============================================================
  // POPULAR RESOURCES
  // ============================================================

  final List<_ResourceCardData> _popularResources = const [
    _ResourceCardData(
      type: 'BLOG',
      title: 'The Future of IoT: Trends Shaping 2025 and Beyond',
      description:
          'Explore emerging IoT trends and how they are transforming industries.',
      action: 'Read More',
      image: 'images/future_iot.png',
      icon: Icons.article_outlined,
      accent: tOrange1,
    ),
    _ResourceCardData(
      type: 'WHITEPAPER',
      title: 'Building Secure IoT Solutions: A Comprehensive Guide',
      description:
          'Best practices for designing, building and securing IoT solutions.',
      action: 'Explore Now',
      image: 'images/secure_iot.png',
      icon: Icons.description_outlined,
      accent: tBlue3,
    ),
    _ResourceCardData(
      type: 'CASE STUDY',
      title: 'How We Helped a Logistics Company Improve Efficiency by 30%',
      description:
          'Real-time tracking, route optimization and actionable insights.',
      action: 'View Case Study',
      image: 'images/casestudy.png',
      icon: Icons.local_shipping_outlined,
      accent: tBlue2,
    ),
    _ResourceCardData(
      type: 'WEBINAR',
      title: 'IoT & AI: Driving Smarter Operations',
      description:
          'Watch our expert webinar on leveraging IoT and AI for business growth.',
      action: 'Watch Now',
      image: 'images/webinar.png',
      icon: Icons.ondemand_video_outlined,
      accent: tOrange1,
    ),
    _ResourceCardData(
      type: 'DOCUMENTATION',
      title: 'MA IoT Platform Developer Guide',
      description:
          'Step-by-step guides and API references to build on our platform.',
      action: 'View Docs',
      image: 'images/documentation.png',
      icon: Icons.menu_book_outlined,
      accent: tBlue3,
    ),
  ];

  // ============================================================
  // RESOURCE CATEGORIES
  // ============================================================

  final List<_ResourceCategoryData> _categories = const [
    _ResourceCategoryData(
      title: 'Blog',
      description: 'Insights, opinions and announcements',
      icon: Icons.article_outlined,
    ),
    _ResourceCategoryData(
      title: 'Case Studies',
      description: 'Real solutions. Real results.',
      icon: Icons.business_center_outlined,
    ),
    _ResourceCategoryData(
      title: 'Whitepapers',
      description: 'In-depth research and industry reports',
      icon: Icons.description_outlined,
    ),
    _ResourceCategoryData(
      title: 'Webinars',
      description: 'Expert talks and on-demand sessions',
      icon: Icons.co_present_outlined,
    ),
    _ResourceCategoryData(
      title: 'Documentation',
      description: 'Guides, API references and manuals',
      icon: Icons.library_books_outlined,
    ),
    _ResourceCategoryData(
      title: 'FAQs',
      description: 'Find answers to frequently asked questions',
      icon: Icons.help_outline_rounded,
    ),
  ];

  // ============================================================
  // LATEST ARTICLES
  // ============================================================

  final List<_LatestArticleData> _latestArticles = const [
    _LatestArticleData(
      title: 'Smart Cities and IoT: Building a Connected Future',
      description:
          'How IoT technologies are enabling smarter infrastructure, better services and sustainable urban living.',
      date: 'May 06, 2024',
      image: 'icons/city.svg',
    ),
    _LatestArticleData(
      title: 'IoT Security: 7 Best Practices to Protect Your Devices',
      description:
          'Security is critical in IoT. Discover practical steps to safeguard your devices, data and users.',
      date: 'Apr 22, 2024',
      image: 'icons/secured.svg',
    ),
    _LatestArticleData(
      title: 'Industrial IoT: Improving Productivity and Efficiency',
      description:
          'How IoT solutions help manufacturers reduce downtime, optimize operations and increase ROI.',
      date: 'Apr 10, 2024',
      image: 'icons/industry.svg',
    ),
  ];

  int _selectedResource = 0;

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedType = 'All Resources';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // FILTER
  // ============================================================

  List<_ResourceCardData> get _filteredResources {
    final query = _searchQuery.trim().toLowerCase();

    return _popularResources.where((resource) {
      final matchesType =
          _selectedType == 'All Resources' ||
          resource.type.toLowerCase() == _selectedType.toLowerCase();

      if (!matchesType) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return resource.title.toLowerCase().contains(query) ||
          resource.description.toLowerCase().contains(query) ||
          resource.type.toLowerCase().contains(query);
    }).toList();
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void _performSearch() {
    setState(() {
      _searchQuery = _searchController.text.trim();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _selectedType = 'All Resources';
    });
  }

  // ============================================================
  // BLOG POPUP
  // ============================================================

  void _showBlogPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: tBlack.withOpacity(0.55),
      builder: (context) {
        return _buildPopupDialog(
          icon: Icons.article_outlined,
          iconColor: tOrange1,
          type: 'BLOG',
          title: 'The Future of IoT',
          child: Text(
            '''
This is placeholder blog content.

You can add your complete blog article here later.

Add multiple paragraphs, headings, explanations, images, links or any other content you want.

The popup will automatically increase its height according to the amount of content you add.

You do not need to manually change the height.

You can continue adding more text here whenever you are ready.
''',
            style: GoogleFonts.manrope(
              fontSize: 11.5,
              height: 1.55,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.62),
            ),
          ),
          footerText: 'Add your blog information here later.',
        );
      },
    );
  }

  // ============================================================
  // WHITEPAPER POPUP
  // ============================================================

  void _showWhitepaperPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: tBlack.withOpacity(0.55),
      builder: (context) {
        return _buildPopupDialog(
          icon: Icons.description_outlined,
          iconColor: tBlue3,
          type: 'WHITEPAPER',
          title: 'Building Secure IoT Solutions',
          child: Text(
            '''
This is placeholder whitepaper content.

You can add the complete whitepaper information here later.

Add your introduction, research findings, technical information, security practices, diagrams, recommendations and other content.

You can add as many paragraphs as required.

The popup height will automatically adjust according to your content.

If the content becomes very long, the popup will become scrollable instead of overflowing.
''',
            style: GoogleFonts.manrope(
              fontSize: 11.5,
              height: 1.55,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.62),
            ),
          ),
          footerText: 'Add your whitepaper information here later.',
        );
      },
    );
  }

  // ============================================================
  // CASE STUDY POPUP
  // ============================================================

  void _showCaseStudyPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: tBlack.withOpacity(0.55),
      builder: (context) {
        return _buildPopupDialog(
          icon: Icons.local_shipping_outlined,
          iconColor: tBlue2,
          type: 'CASE STUDY',
          title: 'Logistics Efficiency Case Study',
          child: Text(
            '''
This is placeholder case study content.

You can add the complete customer case study here.

Add the customer background, business challenge, solution approach, implementation process, technologies used and project results.

You can also add measurable improvements, performance statistics and customer feedback.

Add as much information as required.

The popup will automatically extend vertically as you add more content.
''',
            style: GoogleFonts.manrope(
              fontSize: 11.5,
              height: 1.55,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.62),
            ),
          ),
          footerText: 'Add customer results and project information here.',
        );
      },
    );
  }

  // ============================================================
  // WEBINAR POPUP
  // ============================================================

  void _showWebinarPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: tBlack.withOpacity(0.55),
      builder: (context) {
        return _buildPopupDialog(
          icon: Icons.ondemand_video_outlined,
          iconColor: tOrange1,
          type: 'WEBINAR',
          title: 'IoT & AI: Driving Smarter Operations',
          child: Text(
            '''
This is placeholder webinar content.

You can add your webinar information here later.

Add the webinar introduction, speaker information, topics covered, date, time, agenda and other details.

You can also place a video player or registration section here later.

Add as much content as you need.

The popup automatically grows according to the content and becomes scrollable if it reaches the maximum screen height.
''',
            style: GoogleFonts.manrope(
              fontSize: 11.5,
              height: 1.55,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.62),
            ),
          ),
          footerText: 'Add your webinar details or video here.',
        );
      },
    );
  }

  // ============================================================
  // DOCUMENTATION POPUP
  // ============================================================

  void _showDocumentationPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: tBlack.withOpacity(0.55),
      builder: (context) {
        return _buildPopupDialog(
          icon: Icons.menu_book_outlined,
          iconColor: tBlue3,
          type: 'DOCUMENTATION',
          title: 'MA IoT Platform Developer Guide',
          child: Text(
            '''
This is placeholder documentation content.

You can add your complete developer documentation here later.

Add API references, setup instructions, integration steps, code examples, configuration information, technical specifications and other developer resources.

You can keep adding more sections and paragraphs.

The popup will automatically increase in height as you add content.

Very large content will automatically become scrollable.
''',
            style: GoogleFonts.manrope(
              fontSize: 11.5,
              height: 1.55,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.62),
            ),
          ),
          footerText: 'Add developer documentation and API information here.',
        );
      },
    );
  }

  // ============================================================
  // POPUP CONTAINER
  // ============================================================

  Widget _buildPopupDialog({
    required IconData icon,
    required Color iconColor,
    required String type,
    required String title,
    required Widget child,
    required String footerText,
  }) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: FractionallySizedBox(
        widthFactor: 0.25,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: tWhite.withOpacity(0.97),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: iconColor.withOpacity(0.15)),
                boxShadow: [
                  BoxShadow(
                    color: tBlack.withOpacity(0.20),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(icon, color: iconColor, size: 22),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: tBlue2,
                            height: 1.3,
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                        icon: Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: tBlack.withOpacity(0.55),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    type,
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  child,

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: tBlue3.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      footerText,
                      style: GoogleFonts.manrope(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: tBlue3,
                        height: 1.4,
                      ),
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

  // ============================================================
  // POPULAR RESOURCE ACTION
  // ============================================================

  void _handleResourceAction(String type) {
    switch (type) {
      case 'BLOG':
        _showBlogPopup();
        break;

      case 'WHITEPAPER':
        _showWhitepaperPopup();
        break;

      case 'CASE STUDY':
        _showCaseStudyPopup();
        break;

      case 'WEBINAR':
        _showWebinarPopup();
        break;

      case 'DOCUMENTATION':
        _showDocumentationPopup();
        break;
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHero(),

          const SizedBox(height: 54),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: _buildPopularResources(),
          ),

          const SizedBox(height: 54),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: _buildCategories(),
          ),

          const SizedBox(height: 54),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: _buildLatestAndNewsletter(),
          ),

          const SizedBox(height: 42),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: _buildContactStrip(),
          ),

          const SizedBox(height: 42),

          FooterSection(),
        ],
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero() {
    return SizedBox(
      height: 400,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tBlue2, tBlue3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RESOURCES',
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: tOrange1,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 20),

                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.manrope(
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                            height: 1.15,
                            color: tWhite,
                          ),
                          children: [
                            const TextSpan(text: 'Knowledge. Insights.\n'),
                            TextSpan(
                              text: 'Growth.',
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
                        'Explore our resources to stay informed, solve challenges and accelerate your IoT and digital transformation journey.',
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          color: tWhite,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 35),

                      Row(
                        children: [
                          Expanded(
                            child: _buildResourceHeaderIntroCard(
                              icon: 'icons/innovation.svg',
                              title: 'Expert Insights',
                              description:
                                  'Industry knowledge and practical insights',
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: _buildResourceHeaderIntroCard(
                              icon: 'icons/secured.svg',
                              title: 'Trusted Knowledge',
                              description:
                                  'Reliable information for smarter decisions',
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: _buildResourceHeaderIntroCard(
                              icon: 'icons/future.svg',
                              title: 'Future-Ready',
                              description:
                                  'Stay ahead with emerging technology trends',
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: _buildResourceHeaderIntroCard(
                              icon: 'icons/globe.svg',
                              title: 'All in One Place',
                              description:
                                  'Guides, case studies, webinars and more',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 40),

                Expanded(
                  flex: 4,
                  child: Container(
                    height: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: tBlack.withOpacity(0.25),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'images/company.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: tBlack.withOpacity(0.05),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: tWhite.withOpacity(0.6),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ========================================================
          // SEARCH BAR
          // ========================================================
          Positioned(
            left: 0,
            right: 0,
            bottom: -37,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildSearchBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO INTRO CARD
  // ============================================================

  Widget _buildResourceHeaderIntroCard({
    required String icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 30, height: 30, color: tOrange1),

        const SizedBox(height: 10),

        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            color: tWhite,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

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
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Center(
      child: Container(
        width: 1270,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tBlue2, const Color.fromARGB(255, 14, 23, 55)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: tBlue3),
          boxShadow: [
            BoxShadow(
              color: tBlack.withOpacity(0.18),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, size: 31, color: tOrange1),

            const SizedBox(width: 15),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find the right resource',
                  style: GoogleFonts.manrope(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: tWhite,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  'Search by topic, keyword or resource type.',
                  style: GoogleFonts.manrope(
                    fontSize: 9.5,
                    color: tWhite.withOpacity(0.60),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 70),

            SizedBox(
              width: 650,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: tWhite,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.trim();
                    });
                  },
                  onSubmitted: (_) {
                    _performSearch();
                  },
                  style: GoogleFonts.manrope(fontSize: 11, color: tBlack),
                  decoration: InputDecoration(
                    hintText: 'Search resources...',
                    hintStyle: GoogleFonts.manrope(
                      fontSize: 11,
                      color: tBlack.withOpacity(0.40),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            PopupMenuButton<String>(
              tooltip: 'Filter resources',
              onSelected: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              itemBuilder: (context) {
                const types = [
                  'All Resources',
                  'BLOG',
                  'WHITEPAPER',
                  'CASE STUDY',
                  'WEBINAR',
                  'DOCUMENTATION',
                ];

                return types.map((type) {
                  return PopupMenuItem<String>(
                    value: type,
                    child: Row(
                      children: [
                        if (_selectedType == type)
                          Icon(Icons.check_rounded, size: 16, color: tBlue3)
                        else
                          const SizedBox(width: 16),

                        const SizedBox(width: 8),

                        Text(
                          type == 'All Resources' ? type : type.toTitleCase(),
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: tBlack.withOpacity(0.72),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: tWhite,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedType,
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: tBlack.withOpacity(0.65),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 17,
                      color: tBlue3,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 25),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _performSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: tBlue3,
                  foregroundColor: tWhite,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  'Search',
                  style: GoogleFonts.manrope(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // POPULAR RESOURCES
  // ============================================================

  Widget _buildPopularResources() {
    return Column(
      children: [
        Text(
          'POPULAR RESOURCES',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.0,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Handpicked resources for you',
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 20),

        Builder(
          builder: (context) {
            final resources = _filteredResources;

            if (resources.isEmpty) {
              return _buildNoSearchResults();
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 12.0;

                final width = (constraints.maxWidth - spacing * 4) / 5;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(resources.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == resources.length - 1 ? 0 : spacing,
                      ),
                      child: SizedBox(
                        width: width,
                        child: _HoverResourceCard(
                          data: resources[index],
                          onAction: () {
                            _handleResourceAction(resources[index].type);
                          },
                        ),
                      ),
                    );
                  }),
                );
              },
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // NO SEARCH RESULTS
  // ============================================================

  Widget _buildNoSearchResults() {
    return Container(
      width: double.infinity,
      height: 225,
      padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 20),
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tBlue3.withOpacity(0.10)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 38,
            color: tBlue3.withOpacity(0.65),
          ),

          const SizedBox(height: 10),

          Text(
            'No resources found',
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: tBlack,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Try another keyword or choose a different resource type.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: tBlack.withOpacity(0.55),
            ),
          ),

          const SizedBox(height: 14),

          OutlinedButton(
            onPressed: _clearSearch,
            child: Text(
              'Clear Search',
              style: GoogleFonts.manrope(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // RESOURCE CATEGORIES

  Widget _buildCategories() {
    return Column(
      children: [
        Text(
          'RESOURCE CATEGORIES',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Browse by category',
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),

        const SizedBox(height: 25),

        LayoutBuilder(
          builder: (context, constraints) {
            final width = (constraints.maxWidth - 50) / 6;

            return Row(
              children: List.generate(_categories.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == _categories.length - 1 ? 0 : 10,
                  ),
                  child: SizedBox(
                    width: width,
                    child: _HoverCategoryCard(
                      data: _categories[index],
                      selected: _selectedResource == index,
                      onTap: () {
                        setState(() {
                          _selectedResource = index;
                        });

                        // _navigateToCategory(_categories[index].title);
                      },
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  // void _navigateToCategory(String category) {
  //   switch (category) {
  //     case 'Blog':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const BlogPage()),
  //       );
  //       break;

  //     case 'Case Studies':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const CaseStudiesPage()),
  //       );
  //       break;

  //     case 'Whitepapers':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const WhitepapersPage()),
  //       );
  //       break;

  //     case 'Webinars':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const WebinarsPage()),
  //       );
  //       break;

  //     case 'Documentation':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const DocumentationPage()),
  //       );
  //       break;

  //     case 'FAQs':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const FaqPage()),
  //       );
  //       break;
  //   }
  // }

  Widget _buildLatestAndNewsletter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 6, child: _buildLatestArticles()),

        const SizedBox(width: 30),

        Expanded(flex: 4, child: _buildNewsletter()),
      ],
    );
  }

  Widget _buildLatestArticles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LATEST FROM OUR BLOG',
          style: GoogleFonts.manrope(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: tBlue2,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 15),

        ..._latestArticles.map(
          (article) => Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: _HoverLatestArticle(data: article),
          ),
        ),

        const SizedBox(height: 4),

        Center(
          child: OutlinedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const BlogPage()),
              // );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: tBlue3, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All Blog Posts',
                  style: GoogleFonts.manrope(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: tBlue3,
                  ),
                ),

                const SizedBox(width: 7),

                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: tBlue3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsletter() {
    return _HoverContainer(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F6FF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: tBlue3.withOpacity(0.08)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // NEWSLETTER CONTENT
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STAY UPDATED',
                    style: GoogleFonts.manrope(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: tOrange1,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Subscribe to our newsletter',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: tBlack,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Get the latest insights, product updates and industry trends delivered to your inbox.',
                    style: GoogleFonts.manrope(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: tBlack.withOpacity(0.60),
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // EMAIL + SUBSCRIBE BUTTON
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: tBlack.withOpacity(0.07)),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: GoogleFonts.manrope(
                                fontSize: 10,
                                color: tBlack.withOpacity(0.35),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      SizedBox(
                        height: 38,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tBlue3,
                            foregroundColor: tWhite,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'Subscribe',
                            style: GoogleFonts.manrope(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildNewsletterPoint('Latest articles and insights'),

                  _buildNewsletterPoint('Product updates and releases'),

                  _buildNewsletterPoint('Upcoming webinars and events'),

                  _buildNewsletterPoint('Exclusive offers and more'),
                ],
              ),
            ),

            Positioned(
              right: -12,
              bottom: -6,
              child: IgnorePointer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 175,
                    height: 125,
                    child: Image.asset(
                      'images/email.png',
                      // fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 145,
                          height: 145,
                          decoration: BoxDecoration(
                            color: tBlue3.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 30,
                            color: tBlue3.withOpacity(0.35),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NEWSLETTER POINT
  // ============================================================

  Widget _buildNewsletterPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline_rounded, size: 14, color: tBlue3),

          const SizedBox(width: 7),

          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: tBlack.withOpacity(0.65),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONTACT STRIP
  // ============================================================

  Widget _buildContactStrip() {
    return _HoverContainer(
      child: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [tBlue2, tBlue3]),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Can't find what you are looking for?",
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: tWhite,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    'Our team is here to help you find the right resources.',
                    style: GoogleFonts.manrope(
                      fontSize: 9.5,
                      color: tWhite.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'Contact Our Experts',
                    style: GoogleFonts.manrope(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(width: 7),

                  const Icon(Icons.arrow_forward_rounded, size: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// RESOURCE CARD
// ============================================================

class _HoverResourceCard extends StatefulWidget {
  final _ResourceCardData data;
  final VoidCallback onAction;

  const _HoverResourceCard({required this.data, required this.onAction});

  @override
  State<_HoverResourceCard> createState() => _HoverResourceCardState();
}

class _HoverResourceCardState extends State<_HoverResourceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
        height: 300,
        decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                _hovering
                    ? data.accent.withOpacity(0.28)
                    : tBlack.withOpacity(0.06),
          ),
          boxShadow: [
            BoxShadow(
              color:
                  _hovering
                      ? data.accent.withOpacity(0.10)
                      : tBlack.withOpacity(0.045),
              blurRadius: _hovering ? 22 : 12,
              offset: Offset(0, _hovering ? 10 : 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 140,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    data.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: tBlack.withOpacity(0.04),
                        alignment: Alignment.center,
                        child: Icon(
                          data.icon,
                          size: 35,
                          color: data.accent.withOpacity(0.55),
                        ),
                      );
                    },
                  ),

                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: data.accent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        data.type,
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: tWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 15, 18, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: tBlack,
                        height: 1.28,
                      ),
                    ),

                    const SizedBox(height: 9),

                    Text(
                      data.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: tBlack.withOpacity(0.58),
                        height: 1.4,
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: widget.onAction,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.action,
                            style: GoogleFonts.manrope(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: tBlue3,
                            ),
                          ),

                          const SizedBox(width: 5),

                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: tBlue3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY CARD
// ============================================================

class _HoverCategoryCard extends StatefulWidget {
  final _ResourceCategoryData data;
  final bool selected;
  final VoidCallback onTap;

  const _HoverCategoryCard({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_HoverCategoryCard> createState() => _HoverCategoryCardState();
}

class _HoverCategoryCardState extends State<_HoverCategoryCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final active = _hovering || widget.selected;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovering ? -4 : 0, 0),
          height: 160,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  active ? tBlue3.withOpacity(0.30) : tBlue3.withOpacity(0.10),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    active
                        ? tBlue3.withOpacity(0.08)
                        : tBlack.withOpacity(0.025),
                blurRadius: active ? 17 : 10,
                offset: Offset(0, active ? 7 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color:
                      active
                          ? tBlue3.withOpacity(0.10)
                          : tBlue3.withOpacity(0.055),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  widget.data.icon,
                  size: 21,
                  color: active ? tBlue3 : tBlue3.withOpacity(0.85),
                ),
              ),

              const SizedBox(height: 11),

              Text(
                widget.data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: tBlack,
                ),
              ),

              const SizedBox(height: 5),

              Expanded(
                child: Text(
                  widget.data.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: tBlack.withOpacity(0.58),
                    height: 1.35,
                  ),
                ),
              ),

              Row(
                children: [
                  Text(
                    'Explore',
                    style: GoogleFonts.manrope(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: tBlue3,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Icon(Icons.arrow_forward_rounded, size: 11, color: tBlue3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// LATEST ARTICLE
// ============================================================

class _HoverLatestArticle extends StatefulWidget {
  final _LatestArticleData data;

  const _HoverLatestArticle({required this.data});

  @override
  State<_HoverLatestArticle> createState() => _HoverLatestArticleState();
}

class _HoverLatestArticleState extends State<_HoverLatestArticle> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(_hovering ? 3 : 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: SvgPicture.asset(
                data.image,
                width: 70,
                height: 35,
                color: tOrange1,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: tBlack,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    data.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: tBlack.withOpacity(0.58),
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Read More  →',
                    style: GoogleFonts.manrope(
                      fontSize: 9.6,
                      fontWeight: FontWeight.w800,
                      color: tBlue3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Text(
              data.date,
              style: GoogleFonts.manrope(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: tBlack.withOpacity(0.40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// GENERIC HOVER CONTAINER
// ============================================================

class _HoverContainer extends StatefulWidget {
  final Widget child;

  const _HoverContainer({required this.child});

  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),
        child: widget.child,
      ),
    );
  }
}

// ============================================================
// STRING EXTENSION
// ============================================================

extension _ResourceTypeTitleCase on String {
  String toTitleCase() {
    return split(' ')
        .map(
          (word) =>
              word.isEmpty
                  ? word
                  : '${word[0].toUpperCase()}'
                      '${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}

// ============================================================
// DATA CLASSES
// ============================================================

class _ResourceCardData {
  final String type;
  final String title;
  final String description;
  final String action;
  final String image;
  final IconData icon;
  final Color accent;

  const _ResourceCardData({
    required this.type,
    required this.title,
    required this.description,
    required this.action,
    required this.image,
    required this.icon,
    required this.accent,
  });
}

class _ResourceCategoryData {
  final String title;
  final String description;
  final IconData icon;

  const _ResourceCategoryData({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _LatestArticleData {
  final String title;
  final String description;
  final String date;
  final String image;

  const _LatestArticleData({
    required this.title,
    required this.description,
    required this.date,
    required this.image,
  });
}
