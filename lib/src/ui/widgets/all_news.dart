//all_news.dart(right -flex)

//all_news.dart(all screens)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/news_article.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

class AllNewsPage extends StatefulWidget {
  final List<NewsArticle> articles;

  /// Optional: article to show selected when the page opens.
  final NewsArticle? initialArticle;

  const AllNewsPage({super.key, required this.articles, this.initialArticle});

  @override
  State<AllNewsPage> createState() => _AllNewsPageState();
}

class _AllNewsPageState extends State<AllNewsPage> {
  static const double _listWidth = 340;

  late NewsArticle _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialArticle ?? widget.articles.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 22, 40, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBackButton(context),
            const SizedBox(height: 15),
            _buildHeader(),
            const SizedBox(height: 25),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: _listWidth, child: _buildList()),
                  const SizedBox(width: 30),
                  Flexible(fit: FlexFit.loose, child: _buildDetail()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- BACK ----------------
  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: tTransparent,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(7),
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_rounded, size: 18, color: tBlue3),
                const SizedBox(width: 7),
                Text(
                  'Back',
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tBlue3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NEWS & MEDIA',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'All News & Updates',
          style: GoogleFonts.manrope(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'The latest updates, milestones and stories from our engineering journey.',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  // ---------------- LEFT LIST ----------------
  Widget _buildList() {
    return Container(
      decoration: BoxDecoration(
        color: tBlue1.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: widget.articles.length,
        separatorBuilder:
            (_, __) => Divider(
              height: 1,
              indent: 18,
              endIndent: 18,
              color: tBlue3.withOpacity(0.12),
            ),
        itemBuilder: (context, index) {
          final article = widget.articles[index];
          final isSelected = identical(article, _selected);

          return Material(
            color: isSelected ? tWhite : tTransparent,
            child: InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () => setState(() => _selected = article),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 3,
                      color: isSelected ? tOrange1 : tTransparent,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            article.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.manrope(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: tOrange1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            article.date,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.manrope(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: tBlue3.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.title.replaceAll('\n', ' '),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? tBlue2 : tBlack.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- RIGHT DETAIL ----------------
  Widget _buildDetail() {
    final article = _selected;

    return Container(
      decoration: BoxDecoration(
        color: tWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tBlue3.withOpacity(0.12)),
      ),
      clipBehavior: Clip.antiAlias,
      // Measures the space actually left for the panel, not the screen.
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double pw = constraints.maxWidth;
          final bool compact = pw < 520;
          final bool medium = pw < 760;

          final EdgeInsets padding =
              compact
                  ? const EdgeInsets.fromLTRB(18, 18, 18, 22)
                  : medium
                  ? const EdgeInsets.fromLTRB(26, 22, 26, 26)
                  : const EdgeInsets.fromLTRB(40, 28, 40, 32);

          final double titleSize = compact ? 20 : (medium ? 24 : 28);

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.loose,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            child: SingleChildScrollView(
              key: ValueKey(article.title),
              padding: padding,
              child: _buildArticleBody(
                article,
                pw - padding.horizontal,
                titleSize,
                compact,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _metaRow(NewsArticle article) {
    Widget divider() =>
        Container(width: 1, height: 14, color: tBlue3.withOpacity(0.25));

    final TextStyle light = GoogleFonts.manrope(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: tBlue3.withOpacity(0.6),
    );

    // Wrap: flows onto a second line if the panel gets narrow.
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 6,
      children: [
        Text(
          article.category,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: tOrange1,
          ),
        ),
        divider(),
        Text(article.date, style: light),
        if (article.readTime != null) ...[
          divider(),
          Text(article.readTime!, style: light),
        ],
      ],
    );
  }

  // ---------------- DETAIL HELPERS ----------------

  TextStyle get _bodyStyle => GoogleFonts.manrope(
    fontSize: 13,
    height: 1.65,
    fontWeight: FontWeight.w500,
    color: tBlack.withOpacity(0.85),
  );

  Widget _detailImage(NewsArticle article) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        article.image,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _detailHeading(NewsArticle article, double titleSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _metaRow(article),
        const SizedBox(height: 14),
        Text(
          article.title.replaceAll('\n', ' '),
          style: GoogleFonts.manrope(
            fontSize: titleSize,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: tBlack,
          ),
        ),
        const SizedBox(height: 12),
        Container(width: 75, height: 2, color: tOrange1),
        if (article.author != null) ...[
          const SizedBox(height: 14),
          Text(
            'By ${article.author}',
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tBlue3.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }

  Widget _paragraphs(List<String> items, {bool lastHasGap = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: EdgeInsets.only(
              bottom:
                  (i == items.length - 1 && !lastHasGap)
                      ? 0
                      : 16, //automatic new line
            ),
            child: Text(
              items[i],
              style: _bodyStyle,
              textAlign: TextAlign.justify,
            ),
          ),

        //no line after para
        // Padding(
        //   padding: EdgeInsets.zero,
        //   child: Text(
        //     items[i],
        //     style: _bodyStyle,
        //     textAlign: TextAlign.justify,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildArticleBody(
    NewsArticle article,
    double innerWidth,
    double titleSize,
    bool compact,
  ) {
    // Narrow panel: stack everything
    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailImage(article),
          const SizedBox(height: 16),
          _detailHeading(article, titleSize),
          const SizedBox(height: 20),
          _paragraphs(article.content),
        ],
      );
    }

    const double gap = 28;
    final double imageWidth = innerWidth * 0.48; //image larger
    final double imageHeight = imageWidth * 2 / 3; // matches 4:3 above
    final double textWidth = innerWidth - imageWidth - gap;

    // Measure the title so we know how tall the heading block is
    final titlePainter = TextPainter(
      text: TextSpan(
        text: article.title.replaceAll('\n', ' '),
        style: GoogleFonts.manrope(
          fontSize: titleSize,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout(maxWidth: textWidth);

    // meta(16) + gap(14) + title + gap(12) + bar(2)
    double headingHeight = 16 + 14 + titlePainter.height + 12 + 2;
    if (article.author != null) headingHeight += 14 + 16;
    headingHeight += 20; // gap before content

    final double available = (imageHeight - headingHeight).clamp(0.0, 9999.0);

    final split = _splitForFloat(article.content, textWidth, available);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image left, heading + first part of content right
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(width: imageWidth, child: _detailImage(article)),
            SizedBox(
              width: imageWidth,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ), // change 20 to move it more or less
                child: _detailImage(article),
              ),
            ),
            const SizedBox(width: gap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailHeading(article, titleSize),
                  if (split.beside.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _paragraphs(split.beside, lastHasGap: false),
                  ],
                ],
              ),
            ),
          ],
        ),
        // Rest continues full width below
        if (split.below.isNotEmpty) ...[
          const SizedBox(height: 16),
          _paragraphs(split.below),
        ],
      ],
    );
  }

  /// Splits whole paragraphs only (never cuts one). Picks how many
  /// paragraphs go beside the image so the text column ends closest
  /// to the image's bottom edge. The rest go below at full width.
  ({List<String> beside, List<String> below}) _splitForFloat(
    List<String> paragraphs,
    double width,
    double available,
  ) {
    int count = 0;
    double bestDiff = available; // diff when no paragraph sits beside the image
    double running = 0;

    for (int i = 0; i < paragraphs.length; i++) {
      final tp = TextPainter(
        text: TextSpan(text: paragraphs[i], style: _bodyStyle),
        textDirection: TextDirection.ltr,
        textScaler: MediaQuery.textScalerOf(context),
      )..layout(maxWidth: width);

      running += tp.height;
      final diff = (running - available).abs();
      if (diff < bestDiff) {
        bestDiff = diff;
        count = i + 1;
      }
      running += 16; // gap before the next paragraph
    }

    return (
      beside: paragraphs.take(count).toList(),
      below: paragraphs.skip(count).toList(),
    );
  }
}
