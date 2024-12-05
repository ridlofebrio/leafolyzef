import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/product/product_bloc.dart';
import 'package:leafolyze/blocs/product/product_state.dart';
import 'package:leafolyze/blocs/shop/shop_bloc.dart';
import 'package:leafolyze/blocs/shop/shop_event.dart';
import 'package:leafolyze/blocs/shop/shop_state.dart';
import 'package:leafolyze/core/screens/marketplace/skeleton_marketplace.dart';
import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketplaceDetailScreen extends StatefulWidget {
  final int shopId;

  const MarketplaceDetailScreen({super.key, required this.shopId});

  @override
  State<MarketplaceDetailScreen> createState() =>
      _MarketplaceDetailScreenState();
}

class _MarketplaceDetailScreenState extends State<MarketplaceDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(LoadShops(widget.shopId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return const Padding(
              padding: EdgeInsets.only(top: 130.0, left: 16.0, right: 16.0),
              child: MarketplaceDetailShimmer(),
            );
          }

          if (state is ShopError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ShopBloc>().add(LoadShops(widget.shopId)),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ShopLoaded) {
            final shop = state.shop;

            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(
                        shop.name,
                        style: const TextStyle(
                          fontSize: AppFontSize.fontSizeXXL,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                      floating: true,
                      snap: true,
                      pinned: true,
                      backgroundColor: AppColors.backgroundColor,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.spacingM,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const SizedBox(height: AppSpacing.spacingL),
                          // Store Name
                          Text(
                            shop.name,
                            style: const TextStyle(
                              fontSize: AppFontSize.fontSizeL,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.spacingM),
                          // Store Image and Details
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Store Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppBorderRadius.radiusXS),
                                child: Image.network(
                                  shop.image as String? ??
                                      'https://lh3.googleusercontent.com/p/AF1QipMd6Q5zYhf4MX9GCK3nEblqaBHmCIpQSH446pwh=s1360-w1360-h1020',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.spacingM),
                              // Store Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Lokasi',
                                      style: TextStyle(
                                        color: AppColors.textMutedColor,
                                        fontWeight: AppFontWeight.semiBold,
                                      ),
                                    ),
                                    Text(
                                      shop.address,
                                      style: const TextStyle(
                                        fontWeight: AppFontWeight.semiBold,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.spacingS),
                                    const Text(
                                      'Jam Operasional',
                                      style: TextStyle(
                                        color: AppColors.textMutedColor,
                                        fontWeight: AppFontWeight.semiBold,
                                      ),
                                    ),
                                    Text(
                                      shop.operational,
                                      style: const TextStyle(
                                        fontWeight: AppFontWeight.semiBold,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.spacingS),
                                    const Text(
                                      'Tanggal Bergabung',
                                      style: TextStyle(
                                        color: AppColors.textMutedColor,
                                        fontWeight: AppFontWeight.semiBold,
                                      ),
                                    ),
                                    Text(
                                      shop.createdAt != null
                                          ? '${shop.createdAt!.day}/${shop.createdAt!.month}/${shop.createdAt!.year}'
                                          : 'Unknown',
                                      style: const TextStyle(
                                        fontWeight: AppFontWeight.semiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.spacingM),
                          // Store Description
                          const Text(
                            'Deskripsi Toko',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSizeM,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.spacingXS),
                          Text(shop.description),
                          const SizedBox(height: AppSpacing.spacingXL),
                          const Text(
                            'Obat yang dijual',
                            style: TextStyle(
                              fontSize: AppFontSize.fontSizeM,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.spacingS),
                          BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              if (state is ProductLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (state is ProductLoaded) {
                                return _buildPesticideList(state.products);
                              }

                              return const SizedBox();
                            },
                          ),
                          const SizedBox(height: AppSpacing.spacingXL),
                        ]),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 40,
                  left: 16,
                  right: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Nomer Whatsapp',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSizeM,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.spacingXS),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse('https://wa.me/${shop.noHp}');
                          await launchUrl(url);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacingM,
                            vertical: AppSpacing.spacingS,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.black,
                                size: 24,
                              ),
                              const SizedBox(width: AppSpacing.spacingXS),
                              Text(
                                shop.noHp,
                                style: const TextStyle(
                                  fontSize: AppFontSize.fontSizeL,
                                  color: Colors.black,
                                  fontWeight: AppFontWeight.medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}

Widget _buildPesticideList(List<Product> products) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: products.map((product) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.image?.path ?? '',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Rp ${product.price}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}
