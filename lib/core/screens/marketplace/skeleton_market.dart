import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MarketplaceDetailShimmer extends StatelessWidget {
  const MarketplaceDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama Toko
          Shimmer(
            colorOpacity: 0.3,
            child: Container(
              width: 200,
              height: 24,
              margin: const EdgeInsets.only(bottom: AppSpacing.spacingM),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
              ),
            ),
          ),

          // Gambar dan Detail Toko
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Toko
              Shimmer(
                colorOpacity: 0.3,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spacingM),
              
              // Detail Toko
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailShimmer('Lokasi'),
                    _buildDetailShimmer('Jam Operasional'), 
                    _buildDetailShimmer('Tanggal Bergabung'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spacingM),

          // Deskripsi Toko
          Shimmer(
            colorOpacity: 0.3,
            child: Container(
              width: 120,
              height: 20,
              margin: const EdgeInsets.only(bottom: AppSpacing.spacingXS),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
              ),
            ),
          ),
          Shimmer(
            colorOpacity: 0.3,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spacingXL),

          // Obat yang dijual
          Shimmer(
            colorOpacity: 0.3,
            child: Container(
              width: 150,
              height: 20,
              margin: const EdgeInsets.only(bottom: AppSpacing.spacingS),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Shimmer(
                    colorOpacity: 0.3,
                    child: Container(
                      width: 80,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailShimmer(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMutedColor,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        Shimmer(
          colorOpacity: 0.3,
          child: Container(
            width: 150,
            height: 16,
            margin: const EdgeInsets.only(
              bottom: AppSpacing.spacingS,
              top: AppSpacing.spacingXXS,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
            ),
          ),
        ),
      ],
    );
  }
}