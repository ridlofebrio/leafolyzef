import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/screens/diagnosis/camera_screen.dart';
import 'package:leafolyze/core/screens/diagnosis/result_screen.dart';
import 'package:leafolyze/core/screens/history/history_screen.dart';
import 'package:leafolyze/core/screens/home/article_detail_screen.dart';
import 'package:leafolyze/core/screens/home/article_list_screen.dart';
import 'package:leafolyze/core/screens/home/home_screen.dart';
import 'package:leafolyze/core/screens/marketplace/marketplace_detail_screen.dart';
import 'package:leafolyze/core/screens/marketplace/marketplace_screen.dart';
import 'package:leafolyze/core/screens/marketplace/product_list_screen.dart';
import 'package:leafolyze/core/screens/onboarding/landing_screen.dart';
import 'package:leafolyze/core/screens/onboarding/splash_screen.dart';
import 'package:leafolyze/core/screens/auth/login_screen.dart';
import 'package:leafolyze/core/screens/auth/register_screen.dart';
import 'package:leafolyze/core/home.dart';
import 'package:leafolyze/core/screens/profile/about_screen.dart';
import 'package:leafolyze/core/screens/profile/faq_screen.dart';
import 'package:leafolyze/core/screens/profile/personal_information_screen.dart';
import 'package:leafolyze/core/screens/profile/profile_screen.dart';
import 'package:leafolyze/core/screens/profile/reset_password_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/landing',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Home(child: child);
      },
      routes: [
        GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'article',
                builder: (context, state) => const ArticleListScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => ArticleDetailScreen(
                      id: int.parse(state.pathParameters['id']!),
                    ),
                  ),
                ],
              ),
            ]),
        GoRoute(
          path: '/diagnose',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return CameraScreen(
              imageUrl: extra?['imageUrl'] as String?,
              isRegenerate: extra?['isRegenerate'] as bool? ?? false,
              detectionId: extra?['detectionId'] as int?,
              title: extra?['title'] as String?,
              diseaseIds: extra?['diseaseIds'] as List<int>?,
              skipLabelInput: extra?['skipLabelInput'] as bool? ?? false,
            );
          },
          routes: [
            GoRoute(
              path: 'result',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>;
                return ResultScreen(
                  detectionId: extra['detectionId'] as int,
                  title: extra['title'] as String,
                  diseaseIds: List<int>.from(extra['diseaseIds'] as List),
                  imageUrl: extra['imageUrl'] as String,
                  description: extra['description'] as String,
                  treatmentTitle: extra['treatmentTitle'] as String,
                  treatments: List<String>.from(extra['treatments'] as List),
                  pesticideTitle: extra['pesticideTitle'] as String,
                  pesticides: List<String>.from(extra['pesticides'] as List),
                  timestamp: extra['timestamp'] as String,
                );
              },
            )
          ],
        ),
        GoRoute(
          path: '/marketplace',
          builder: (context, state) => const MarketplaceScreen(),
          routes: [
            GoRoute(
              path: ':diseaseId',
              builder: (context, state) => ProductListScreen(
                diseaseId:
                    int.tryParse(state.pathParameters['diseaseId']!) ?? 0,
              ),
              routes: [
                GoRoute(
                  path: 'detail/:shopId',
                  builder: (context, state) {
                    final shopId =
                        int.tryParse(state.pathParameters['shopId']!) ?? 0;
                    return MarketplaceDetailScreen(shopId: shopId);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'faq',
                builder: (context, state) => FaqScreen(),
              ),
              GoRoute(
                path: 'about',
                builder: (context, state) => AboutScreen(),
              ),
              GoRoute(
                path: 'personal-information',
                builder: (context, state) => PersonalInformationScreen(),
              ),
              GoRoute(
                path: 'password-security',
                builder: (context, state) => ResetPasswordScreen(),
              ),
            ]),
      ],
    ),
  ],
);
