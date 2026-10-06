import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/all_news.dart';
import 'package:trakmate_portal/src/ui/widgets/news_article.dart';
import 'package:trakmate_portal/src/ui/widgets/news_card.dart';

import 'package:trakmate_portal/src/ui/widgets/newsheader.dart';
import '../../utils/colors.dart';
import '../widgets/footer_section.dart';

class NewsAndMediaSection extends StatefulWidget {
  final bool isActive;
  final void Function(int index)? onNavigate;
  const NewsAndMediaSection({
    super.key,
    required this.isActive,
    this.onNavigate,
  });

  @override
  State<NewsAndMediaSection> createState() => _NewsAndMediaSectionState();
}

class _NewsAndMediaSectionState extends State<NewsAndMediaSection> {
  final List<NewsArticle> _news = [
    NewsArticle(
      category: 'Company News',
      date: '25 Sep 2026',
      publishedAt: DateTime(2026, 9, 25),
      title:
          'TrakMate Expands Its Engineering Capabilities with New Innovation Center',
      summary:
          'We are excited to announce the expansion of our engineering capabilities with a new state-of-the-art innovation center, strengthening our commitment to build smarter, connected products for a better tomorrow.',
      image: 'images/innovation_center.png',
      author: 'TrakMate Communications',
      readTime: '3 min read',
      content: [
        'Write paragraph 1 of the full article here.',
        'Write paragraph 2 here.',
        'Write paragraph 3 here.',
      ],
    ),

    NewsArticle(
      category: 'Engineering',
      date: '18 Sep 2026',
      publishedAt: DateTime(2026, 9, 18),
      title: 'Advancing Embedded Systems for a Smarter Future',
      summary:
          'Exploring next-generation embedded solutions for connected mobility and IoT.',
      image: 'images/embedded_systems.png',
      content: ['Full article paragraph 1...', 'Paragraph 2...'],
    ),
    NewsArticle(
      category: 'Products',
      date: '12 Sep 2026',
      publishedAt: DateTime(2026, 9, 12),
      title: 'New Generation Vehicle Tracker Launched',
      summary:
          'Our latest vehicle tracking solution delivers higher accuracy, advanced safety features.',
      image: 'images/tracker_launch.png',
      content: ['Full article paragraph 1...', 'Paragraph 2...'],
    ),
    NewsArticle(
      category: 'Company News',
      date: '05 Sep 2026',
      publishedAt: DateTime(2026, 9, 5),
      title: 'TrakMate Strengthens R&D with New Talent',
      summary:
          'We are growing our engineering team to accelerate innovation in IoT, connected products.',
      image: 'images/R&D_Team.png',
      content: ['Full article paragraph 1...', 'Paragraph 2...'],
    ),
    NewsArticle(
      category: 'Events',
      date: '28 Aug 2026',
      publishedAt: DateTime(2026, 8, 28),
      title: 'TrakMate at Auto Expo 2026',
      summary:
          'Showcasing our latest innovations in connected mobility, intelligent vehicle solutions.',
      image: 'images/auto_expo.png',
      content: [
        'We deliver innovative technology solutions designed to meet evolving business needs.'
            'Our approach combines engineering expertise, smart technology, and reliable processes.'
            'We focus on building scalable, efficient, and high-quality solutions for our customers.'
            'With a commitment to excellence, we turn ideas into practical, connected products.',
      ],
    ),
  ];

  List<NewsArticle> get _sortedNews {
    final list = [..._news];
    list.sort((a, b) => b.publishedAt.compareTo(a.publishedAt)); // newest first
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // HERO HEADER (same as Products)
          HeroSlider(
            isActive: widget.isActive,
            slides: [
              HeroSlide(
                // image: _sortedNews[0].image,
                image: 'images/auto_expo.png',
                label: 'NEWS & MEDIA',
                line1: 'Engineering Innovation.',
                line2: 'Building a Smarter Tomorrow.',
              ),
              HeroSlide(
                // image: _sortedNews[1].image,
                image: 'images/auto_expo.png',
                label: 'NEWS & MEDIA',
                line1: 'Advancing Embedded Systems.',
                line2: 'For a Smarter Future.',
              ),
              HeroSlide(
                // image: _sortedNews[2].image,
                image: 'images/auto_expo.png',
                label: 'NEWS & MEDIA',
                line1: 'New Generation Trackers.',
                line2: 'Built for Performance.',
              ),
            ],
          ),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: _buildNewsMediaSection(),
          ),
          const SizedBox(height: 40),
          FooterSection(onNavigate: widget.onNavigate),
        ],
      ),
    );
  }

  Widget _buildNewsMediaSection() {
    final news = _sortedNews;
    final latest = news[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'NEWS & BLOGS',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: GoogleFonts.manrope(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: tBlue2,
            ),
            children: const [TextSpan(text: 'Stay Connected With TrakMate')],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'The latest updates, milestones and stories from our engineering journey.',
          style: GoogleFonts.manrope(
            fontSize: 13,
            color: tBlack.withOpacity(0.75),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 25),

        // ---------- LATEST BANNER ----------
        SizedBox(
          width: double.infinity,
          height: 330,
          child: Container(
            decoration: BoxDecoration(
              color: tBlue1.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 11,
                  child: Image.asset(latest.image, fit: BoxFit.cover),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: tOrange1.withOpacity(0.65),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: tOrange1,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Text(
                                'LATEST',
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: tOrange1,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Text(
                              latest.category,
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: tBlue,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 1,
                              height: 14,
                              color: tBlue3.withOpacity(0.25),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              latest.date,
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: tBlue3.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          latest.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 24,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                            color: tBlack,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          latest.summary,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: tBlue3.withOpacity(0.65),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNewsOrangeButton(
                          'Read Story',
                          onPressed:
                              () => showNewsArticleDialog(context, latest),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),

        // ---------- 4 NEWS CARDS ----------
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 1; i < news.length; i++) ...[
              Expanded(child: NewsCard(article: news[i])),
              if (i != news.length - 1) const SizedBox(width: 20),
            ],
          ],
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AllNewsPage(articles: news)),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: tOrange1,
              side: BorderSide(color: tOrange1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All News',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: tOrange1,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsOrangeButton(
    String label, {
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: tOrange1,
        foregroundColor: tWhite,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: tWhite,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    );
  }
}
