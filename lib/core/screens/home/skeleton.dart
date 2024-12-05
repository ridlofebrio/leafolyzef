import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ArticleShimmer extends StatelessWidget {
  const ArticleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer(
            colorOpacity: 0.3,
            child: Container(
              width: 240,
              margin: EdgeInsets.only(right: AppSpacing.spacingS),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppBorderRadius.radiusS),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DiagnosisShimmer extends StatelessWidget {
  const DiagnosisShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 350,
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.spacingS,
        0,
        AppSpacing.spacingS,
        AppSpacing.spacingMS,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.radiusM),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 15,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          3,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.spacingS),
            child: Shimmer(
              colorOpacity: 0.3,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(AppBorderRadius.radiusS),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              colorOpacity: 0.3,
              child: Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.spacingXS),
            Shimmer(
              colorOpacity: 0.3,
              child: Container(
                width: 150,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
                ),
              ),
            ),
          ],
        ),
        Shimmer(
          colorOpacity: 0.3,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
          ),
        ),
      ],
    );
  }
}

class ProfilePageShimmer extends StatelessWidget {
  const ProfilePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar shimmer
        Shimmer(
          colorOpacity: 0.3,
          child: Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(224, 224, 224, 1),
            ),
          ),
        ),
        SizedBox(width: AppSpacing.spacingL),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name shimmer
            Shimmer(
              colorOpacity: 0.3,
              child: Container(
                width: 150,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(224, 224, 224, 1),
                  borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.spacingS),
            // Email shimmer
            Shimmer(
              colorOpacity: 0.3,
              child: Container(
                width: 200,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(224, 224, 224, 1),
                  borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(AppSpacing.spacingM),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: AppSpacing.spacingM),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppBorderRadius.radiusM),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 15,
                  color: Colors.black.withOpacity(0.08),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.spacingM),
              child: Row(
                children: [
                  // Gambar shimmer
                  Shimmer(
                    colorOpacity: 0.3,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(AppBorderRadius.radiusS),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.spacingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul shimmer
                        Shimmer(
                          colorOpacity: 0.3,
                          child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(
                                  AppBorderRadius.radiusXS),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.spacingS),
                        // Subtitle shimmer
                        Shimmer(
                          colorOpacity: 0.3,
                          child: Container(
                            width: 150,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(
                                  AppBorderRadius.radiusXS),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
