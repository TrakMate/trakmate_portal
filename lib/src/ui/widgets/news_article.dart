import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmer_effect.dart';
import 'package:trakmate_portal/src/utils/responsive.dart';
import '../../utils/colors.dart';

//here
class NewsArticle {
  final String category;
  final DateTime publishedAt;
  final String date;
  final String title;
  final String summary; // short text shown on the card
  final String image; // asset path
  final List<String> content; // full article, one string per paragraph
  final String? author;
  final String? readTime;

  const NewsArticle({
    required this.category,
    required this.publishedAt,
    required this.date,
    required this.title,
    required this.summary,
    required this.image,
    required this.content,
    this.author,
    this.readTime,
  });
}

/// Call this from anywhere:  showNewsArticleDialog(context, article);
Future<void> showNewsArticleDialog(BuildContext context, NewsArticle article) {
  return showDialog(
    context: context,
    barrierColor: tBlack.withOpacity(0.55),
    builder: (_) => NewsArticleDialog(article: article),
  );
}

class NewsArticleDialog extends StatelessWidget {
  final NewsArticle article;
  const NewsArticleDialog({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool compact = size.width < 380; // medium phones

    // Sizes: mobile | tablet / desktop (unchanged)
    final double imageHeight = isMobile ? (compact ? 190 : 220) : 350;
    final double titleSize = isMobile ? (compact ? 19 : 22) : 28;
    final EdgeInsets bodyPadding =
        isMobile
            ? const EdgeInsets.fromLTRB(20, 20, 20, 16)
            : const EdgeInsets.fromLTRB(40, 28, 40, 32);

    return Dialog(
      backgroundColor: tTransparent,
      insetPadding:
          isMobile
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 20)
              : const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 860,
          maxHeight: size.height * (isMobile ? 0.9 : 0.88),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Scrollable article content
              Padding(
                // leaves room for the fixed Close button
                padding: EdgeInsets.only(bottom: isMobile ? 60 : 42),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: imageHeight,
                        width: double.infinity,
                        child: shimmerImage(article.image),
                      ),
                      Padding(
                        padding: bodyPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _metaRow(),
                            SizedBox(height: isMobile ? 12 : 14),

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

                            SizedBox(height: isMobile ? 16 : 20),

                            ...article.content.map(
                              (p) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: isMobile ? 14 : 16,
                                ),
                                child: Text(
                                  p,
                                  style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    height: isMobile ? 1.6 : 1.65,
                                    fontWeight: FontWeight.w500,
                                    color: tBlack.withOpacity(0.85),
                                  ),
                                ),
                              ),
                            ),

                            // Extra bottom space so content isn't hidden
                            // behind the fixed Close button.
                            SizedBox(height: isMobile ? 4 : 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // FIXED CLOSE BUTTON
              Positioned(
                right: isMobile ? 20 : 40,
                bottom: isMobile ? 12 : 20,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tOrange1,
                    foregroundColor: tWhite,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 22 : 26,
                      vertical: isMobile ? 11 : 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: tWhite,
                    ),
                  ),
                ),
              ),

              // Mobile only: small close (X) over the image, easy to reach
              if (isMobile)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: tBlack.withOpacity(0.45),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.all(7),
                        child: Icon(Icons.close, size: 18, color: tWhite),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metaRow() {
    final divider = Container(
      width: 1,
      height: 14,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: tBlue3.withOpacity(0.25),
    );

    // Wrap: looks the same as a Row when it fits, but flows onto a second
    // line instead of overflowing on narrow phones.
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
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
        divider,
        Text(
          article.date,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: tBlue3.withOpacity(0.6),
          ),
        ),
        if (article.readTime != null) ...[
          divider,
          Text(
            article.readTime!,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: tBlue3.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }
}
