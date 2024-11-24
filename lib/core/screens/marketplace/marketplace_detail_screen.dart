import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/shop/shop_bloc.dart';
import 'package:leafolyze/blocs/shop/shop_state.dart';
import 'package:leafolyze/blocs/shop/shop_event.dart';
import 'package:leafolyze/blocs/product/product_bloc.dart';
import 'package:leafolyze/blocs/product/product_state.dart';
import 'package:leafolyze/blocs/product/product_event.dart';
import 'package:leafolyze/core/widgets/marketplace/detailed_product_card.dart';
import 'package:leafolyze/utils/constants.dart';

class MarketplaceDetailScreen extends StatefulWidget {
  final String id;

  const MarketplaceDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<MarketplaceDetailScreen> createState() =>
      _MarketplaceDetailScreenState();
}

class _MarketplaceDetailScreenState extends State<MarketplaceDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(LoadShops());
    context
        .read<ProductBloc>()
        .add(LoadProductsByShop(int.parse(widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        scrollBehavior: const ScrollBehavior().copyWith(
          overscroll: false,
        ),
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            title: Text(
              'Shop Profile',
              style: TextStyle(
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
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: AppSpacing.spacingL),
                  // Shop Details Section
                  BlocBuilder<ShopBloc, ShopState>(
                    builder: (context, shopState) {
                      if (shopState is ShopLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (shopState is ShopLoaded) {
                        final shop = shopState.shops.firstWhere(
                          (shop) => shop.id == widget.id,
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shop.name,
                              style: const TextStyle(
                                fontSize: AppFontSize.fontSizeL,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.spacingM),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      AppBorderRadius.radiusXS),
                                  child: Image.network(
                                    shop.image?.path ??
                                        '', // Ensure safe null handling here too
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.spacingM),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Location',
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
                                      const SizedBox(
                                          height: AppSpacing.spacingS),
                                      const Text(
                                        'Operational Hours',
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (shopState is ShopError) {
                        return Center(child: Text(shopState.message));
                      }
                      return const Center(child: Text('Something went wrong.'));
                    },
                  ),

                  const SizedBox(height: AppSpacing.spacingM),
                  // Shop Products Section
                  const Text(
                    'Shop Products',
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeM,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingXS),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, productState) {
                      if (productState is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (productState is ProductLoaded) {
                        if (productState.products.isEmpty) {
                          return const Center(
                              child: Text('No products found.'));
                        }
                        return GridView.builder(
                          padding: const EdgeInsets.only(
                              bottom: AppSpacing.spacingXXL),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppSpacing.spacingM,
                            mainAxisSpacing: AppSpacing.spacingM,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: productState.products.length,
                          itemBuilder: (context, index) {
                            final product = productState.products[index];
                            return DetailedProductCard(product: product);
                          },
                        );
                      } else if (productState is ProductError) {
                        return Center(child: Text(productState.message));
                      }
                      return const Center(child: Text('Something went wrong.'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
