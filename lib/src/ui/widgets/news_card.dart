import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trakmate_portal/src/ui/widgets/news_article.dart';
import 'package:trakmate_portal/src/ui/widgets/shimmereffect.dart';
import 'package:trakmate_portal/src/utils/colors.dart';

/// Reusable news card. Tapping it opens the article popup.
class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final double height;

  const NewsCard({super.key, required this.article, this.height = 350});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => showNewsArticleDialog(context, article),
          child: Container(
            decoration: BoxDecoration(
              color: tWhite,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: tBlue1.withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                  color: tBlack.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: shimmerImage(article.image),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
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
                            const SizedBox(width: 9),
                            Container(
                              width: 1,
                              height: 13,
                              color: tBlue3.withOpacity(0.2),
                            ),
                            const SizedBox(width: 9),
                            Text(
                              article.date,
                              style: GoogleFonts.manrope(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: tBlue3.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: tBlack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.summary,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                            color: tBlue3.withOpacity(0.65),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 24,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Read More',
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: tOrange1,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Icon(
                                Icons.arrow_forward,
                                size: 15,
                                color: tOrange1,
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
        ),
      ),
    );
  }
}
