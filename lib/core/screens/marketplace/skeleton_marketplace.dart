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

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.63,
        mainAxisSpacing: AppSpacing.spacingMS,
        crossAxisSpacing: AppSpacing.spacingMS,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.spacingMS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar shimmer
                  Shimmer(
                    colorOpacity: 0.3,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingMS),
                  // Nama produk shimmer
                  Shimmer(
                    colorOpacity: 0.3,
                    child: Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(AppBorderRadius.radiusXXS),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingXXS),
                  // Harga shimmer
                  Shimmer(
                    colorOpacity: 0.3,
                    child: Container(
                      width: 100,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(AppBorderRadius.radiusXXS),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingXXS),
                  // Nama toko shimmer
                  Shimmer(
                    colorOpacity: 0.3,
                    child: Container(
                      width: 120,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(AppBorderRadius.radiusXXS),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingXXXS),
                  // Lokasi shimmer
                  Row(
                    children: [
                      Shimmer(
                        colorOpacity: 0.3,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spacingXXXS),
                      Shimmer(
                        colorOpacity: 0.3,
                        child: Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(AppBorderRadius.radiusXXS),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 6, // Menampilkan 6 item shimmer
      ),
    );
  }
}