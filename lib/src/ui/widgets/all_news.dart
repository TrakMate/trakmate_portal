//all_news.dart (mobile + tablet + desktop)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/news_article.dart';
import 'package:trakmate_portal/src/utils/colors.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';

class AllNewsPage extends StatefulWidget {
  final List<NewsArticle> articles;

  /// Optional: article to show selected when the page opens.
  final NewsArticle? initialArticle;

  const AllNewsPage({super.key, required this.articles, this.initialArticle});

  @override
  State<AllNewsPage> createState() => _AllNewsPageState();
}

class _AllNewsPageState extends State<AllNewsPage> {
  // Breakpoints come from ResponsiveLayout:
  //   mobile  < 700   |   tablet 700 - 1099   |   desktop >= 1100
  bool get isMobile => ResponsiveLayout.isMobile(context);
  bool get isTablet => ResponsiveLayout.isTablet(context);

  // Medium phones (e.g. 360px wide)
  bool get _isCompact => MediaQuery.of(context).size.width < 380;
  // No hover effects on tablet / mobile layouts
  bool get _noHover => isMobile || isTablet;
  double get _listWidth => isTablet ? 260 : 340;

  late NewsArticle _selected;

  /// MOBILE ONLY: false = show the list of news, true = show one article.
  /// (There is no room for list + article side by side on a phone.)
  bool _showDetail = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialArticle ?? widget.articles.first;
    // If the page was opened for one specific article, start on it (mobile).
    _showDetail = widget.initialArticle != null;
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile) return _buildMobile();

    return Scaffold(
      backgroundColor: tWhite,
      body: Padding(
        padding:
            isTablet
                ? const EdgeInsets.fromLTRB(24, 18, 24, 16)
                : const EdgeInsets.fromLTRB(40, 22, 40, 20),
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

  // ---------------------------------------------------------------------------
  // MOBILE LAYOUT: list first, tap an item to open the article full screen
  // ---------------------------------------------------------------------------
  Widget _buildMobile() {
    return PopScope(
      // When an article is open, the system / browser back button goes
      // back to the list instead of leaving the page.
      canPop: !_showDetail,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _showDetail = false);
      },
      child: Scaffold(
        backgroundColor: tWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBackButton(context),
                const SizedBox(height: 8),
                if (!_showDetail) ...[
                  _buildHeader(),
                  const SizedBox(height: 18),
                  Expanded(child: _buildList()),
                ] else
                  Expanded(child: _buildDetail()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- BACK ----------------
  Widget _buildBackButton(BuildContext context) {
    // On mobile, while an article is open, "back" returns to the list.
    final bool backToList = isMobile && _showDetail;

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: tTransparent,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(7),
          onTap: () {
            if (backToList) {
              setState(() => _showDetail = false);
            } else {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_rounded, size: 18, color: tBlue3),
                const SizedBox(width: 7),
                Text(
                  backToList ? 'All News' : 'Back',
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
            fontSize: isMobile ? 12 : 13,
            fontWeight: FontWeight.w700,
            color: tOrange1,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: isMobile ? 6 : 8),
        Text(
          'All News & Updates',
          style: GoogleFonts.manrope(
            fontSize: isMobile ? (_isCompact ? 22 : 26) : (isTablet ? 26 : 32),
            fontWeight: FontWeight.w700,
            color: tBlue2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'The latest updates, milestones and stories from our engineering journey.',
          style: GoogleFonts.manrope(
            fontSize: isMobile ? 12.5 : 13,
            height: isMobile ? 1.5 : null,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  // ---------------- LEFT LIST ----------------
  Widget _buildList() {
    // final bool mobile = isMobile;

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
          // No "selected" highlight on mobile: tapping opens the article.
          final isSelected = !isMobile && identical(article, _selected);

          final Widget textColumn = Column(
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
                maxLines: isMobile ? 2 : 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? tBlue2 : tBlack.withOpacity(0.85),
                ),
              ),
            ],
          );

          return Material(
            color: isSelected ? tWhite : tTransparent,
            child: InkWell(
              mouseCursor:
                  _noHover
                      ? SystemMouseCursors.basic
                      : SystemMouseCursors.click,
              hoverColor: _noHover ? tTransparent : null,
              onTap:
                  () => setState(() {
                    _selected = article;
                    if (isMobile) _showDetail = true;
                  }),
              child: Container(
                padding:
                    isMobile
                        ? const EdgeInsets.fromLTRB(14, 14, 14, 14)
                        : const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 3,
                      color: isSelected ? tOrange1 : tTransparent,
                    ),
                  ),
                ),
                child:
                    isMobile
                        // Mobile: small thumbnail on the left, text on the right
                        ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                width: _isCompact ? 68 : 80,
                                height: _isCompact ? 68 : 80,
                                child: Image.asset(
                                  article.image,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Container(
                                        color: tBlue3.withOpacity(0.1),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 22,
                                          color: tBlue3.withOpacity(0.4),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: textColumn),
                          ],
                        )
                        : textColumn,
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
          // Mobile always uses the stacked (image on top) layout.
          final bool compact = isMobile || pw < 520;
          final bool medium = pw < 760;

          final EdgeInsets padding =
              isMobile
                  ? const EdgeInsets.fromLTRB(16, 16, 16, 24)
                  : compact
                  ? const EdgeInsets.fromLTRB(18, 18, 18, 22)
                  : medium
                  ? const EdgeInsets.fromLTRB(26, 22, 26, 26)
                  : const EdgeInsets.fromLTRB(40, 28, 40, 32);

          final double titleSize =
              isMobile
                  ? (_isCompact ? 19 : 21)
                  : compact
                  ? 20
                  : (medium ? 24 : 28);

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
              // Justified text leaves big gaps on narrow phone screens
              textAlign: isMobile ? TextAlign.left : TextAlign.justify,
            ),
          ),
      ],
    );
  }

  Widget _buildArticleBody(
    NewsArticle article,
    double innerWidth,
    double titleSize,
    bool compact,
  ) {
    // Narrow panel / mobile: stack everything
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
