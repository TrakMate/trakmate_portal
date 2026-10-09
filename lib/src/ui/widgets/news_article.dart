import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
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
    barrierColor: Colors.black.withOpacity(0.55),
    builder: (_) => NewsArticleDialog(article: article),
  );
}

class NewsArticleDialog extends StatelessWidget {
  final NewsArticle article;
  const NewsArticleDialog({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 860,
          maxHeight: size.height * 0.88,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          // child: Stack(
          //   children: [
          //     SingleChildScrollView(
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(
          //             height: 300,
          //             width: double.infinity,
          //             child: Image.asset(article.image, fit: BoxFit.cover),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(40, 28, 40, 32),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 _metaRow(),
          //                 const SizedBox(height: 14),
          //                 Text(
          //                   article.title.replaceAll('\n', ' '),
          //                   style: GoogleFonts.manrope(
          //                     fontSize: 28,
          //                     height: 1.2,
          //                     fontWeight: FontWeight.w700,
          //                     color: tBlack,
          //                   ),
          //                 ),
          //                 const SizedBox(height: 12),
          //                 Container(width: 75, height: 2, color: tOrange1),
          //                 if (article.author != null) ...[
          //                   const SizedBox(height: 14),
          //                   Text(
          //                     'By ${article.author}',
          //                     style: GoogleFonts.manrope(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w600,
          //                       color: tBlue3.withOpacity(0.7),
          //                     ),
          //                   ),
          //                 ],
          //                 const SizedBox(height: 20),
          //                 ...article.content.map(
          //                   (p) => Padding(
          //                     padding: const EdgeInsets.only(bottom: 16),
          //                     child: Text(
          //                       //paragraph
          //                       p,
          //                       style: GoogleFonts.manrope(
          //                         fontSize: 13,
          //                         height: 1.65,
          //                         fontWeight: FontWeight.w500,
          //                         color: tBlack.withOpacity(0.85),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 const SizedBox(height: 8),
          //                 Align(
          //                   alignment: Alignment.centerRight,
          //                   child: ElevatedButton(
          //                     onPressed: () => Navigator.of(context).pop(),
          //                     style: ElevatedButton.styleFrom(
          //                       backgroundColor: tOrange1,
          //                       foregroundColor: tWhite,
          //                       elevation: 0,
          //                       padding: const EdgeInsets.symmetric(
          //                         horizontal: 26,
          //                         vertical: 14,
          //                       ),
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(7),
          //                       ),
          //                     ),
          //                     child: Text(
          //                       'Close',
          //                       style: GoogleFonts.manrope(
          //                         fontSize: 12,
          //                         fontWeight: FontWeight.w700,
          //                         color: tWhite,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),

          //     // Close (X) button over the image
          //     // Positioned(
          //     //   top: 14,
          //     //   right: 14,
          //     //   child: Material(
          //     //     color: Colors.black.withOpacity(0.45),
          //     //     shape: const CircleBorder(),
          //     //     child: InkWell(
          //     //       customBorder: const CircleBorder(),
          //     //       onTap: () => Navigator.of(context).pop(),
          //     //       child: const Padding(
          //     //         padding: EdgeInsets.all(8),
          //     //         child: Icon(Icons.close, size: 20, color: tWhite),
          //     //       ),
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),
          child: Stack(
            children: [
              // Scrollable article content
              Padding(
                padding: const EdgeInsets.only(bottom: 42),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 350,
                        width: double.infinity,
                        child: shimmerImage(article.image),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 28, 40, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _metaRow(),
                            const SizedBox(height: 14),

                            Text(
                              article.title.replaceAll('\n', ' '),
                              style: GoogleFonts.manrope(
                                fontSize: 28,
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

                            const SizedBox(height: 20),

                            ...article.content.map(
                              (p) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  p,
                                  style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    height: 1.65,
                                    fontWeight: FontWeight.w500,
                                    color: tBlack.withOpacity(0.85),
                                  ),
                                ),
                              ),
                            ),

                            // Extra bottom space so content isn't hidden
                            // behind the fixed Close button.
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // FIXED CLOSE BUTTON
              Positioned(
                right: 40,
                bottom: 20,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tOrange1,
                    foregroundColor: tWhite,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 14,
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

    return Row(
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
