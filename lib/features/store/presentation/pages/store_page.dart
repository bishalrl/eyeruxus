import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/store/domain/entities/store_product.dart';
import 'package:eye_rex_us/features/store/presentation/bloc/store_bloc.dart';
import 'package:eye_rex_us/shared/widgets/feature_state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(const StoreProductsRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            if (state is StoreLoading || state is StoreInitial) {
              return const FeatureLoadingView();
            }
            if (state is StoreFailure) {
              return FeatureErrorView(message: state.message);
            }

            final products = state is StoreLoaded ? state.products : <StoreProduct>[];
            final featured = products.where((p) => p.category == 'featured').toList();
            final hot = products.where((p) => p.category == 'hot').toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 6),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => AppRouter.maybePop(context),
                          icon: Icon(Icons.menu, color: colors.textPrimary),
                        ),
                        const Spacer(),
                        Text(
                          l10n.storeTitle,
                          style: textTheme.headlineSmall?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.shopping_cart, color: colors.textPrimary, size: 28),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: colors.border),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: l10n.storeSearchHint,
                                hintStyle: TextStyle(color: colors.textMuted),
                                prefixIcon: Icon(Icons.search, color: colors.textMuted),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 100,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                l10n.storeCategory,
                                style: TextStyle(color: colors.textMuted, fontSize: 12),
                              ),
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down, color: colors.textMuted),
                              items: const [],
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _CategoryRow(
                    items: [
                      _CategoryItem(l10n.storeCategoryHonorMall, 'https://picsum.photos/seed/honor/200/200', () {
                        AppRouter.pushNamed(context, AppRouteNames.storeHonorMall);
                      }),
                      _CategoryItem(l10n.storeCategoryRareId, 'https://picsum.photos/seed/rareid/200/200', () {
                        AppRouter.pushNamed(context, AppRouteNames.storeRareId);
                      }),
                      _CategoryItem(l10n.storeCategoryRides, 'https://picsum.photos/seed/rides/200/200', () {
                        AppRouter.pushNamed(context, AppRouteNames.storeRides);
                      }),
                      _CategoryItem(l10n.storeCategoryProfileCard, 'https://picsum.photos/seed/profile/200/200', () {
                        AppRouter.pushNamed(context, AppRouteNames.storeProfileCard);
                      }),
                      _CategoryItem(l10n.storeCategoryAvatarFrame, 'https://picsum.photos/seed/avatar/200/200', () {
                        AppRouter.pushNamed(context, AppRouteNames.storeAvatarFrame);
                      }),
                      _CategoryItem(l10n.storeCategoryPartyTheme, 'https://picsum.photos/seed/party/200/200', () {
                        AppRouter.pushNamed(context, AppRouteNames.storePartyTheme);
                      }),
                      _CategoryItem(l10n.storeCategoryRoomBubble, 'https://picsum.photos/seed/room/200/200', () {
                        AppRouter.pushNamed(context, AppRouteNames.storeRoomBubble);
                      }),
                      _CategoryItem(l10n.storeStayTuned, 'https://picsum.photos/seed/stay/200/200', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: colors.success,
                            content: Text(l10n.storeStayTunedMessage),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      l10n.storeComingNew,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colors.mallCard,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: featured.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final product = featured[index];
                            return _FeaturedCard(product: product);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      l10n.storeHotRecommendation,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      itemCount: hot.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 250,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return _HotProductCard(product: hot[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryItem {
  const _CategoryItem(this.title, this.imageUrl, this.onTap);

  final String title;
  final String imageUrl;
  final VoidCallback onTap;
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.items});

  final List<_CategoryItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final item in items) ...[
              GestureDetector(
                onTap: item.onTap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.border),
                      ),
                      child: ClipOval(
                        child: Image.network(item.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 70,
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.product});

  final StoreProduct product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      width: 80,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(product.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(height: 4),
          Text(
            product.name,
            style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${product.price}',
            style: textTheme.labelSmall?.copyWith(
              color: colors.storeGold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _HotProductCard extends StatelessWidget {
  const _HotProductCard({required this.product});

  final StoreProduct product;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Card(
      elevation: 2,
      shadowColor: colors.storeGold.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 1.35,
                child: Image.network(product.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          Text(
            '${product.price}',
            style: textTheme.titleMedium?.copyWith(
              color: colors.storeGold,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.storeGold),
                      foregroundColor: colors.storeGold,
                      minimumSize: const Size(0, 30),
                    ),
                    child: Text(l10n.storeSend),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.storeGold,
                      foregroundColor: colors.onPrimary,
                      minimumSize: const Size(0, 30),
                    ),
                    child: Text(l10n.storePurchase),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
