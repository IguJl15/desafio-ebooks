part of "app.dart";

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: '/read/:ebookId',
      builder: (_, state) => EpubReader(
        ebook: state.extra as Ebook?,
        ebookId: int.parse(state.pathParameters['ebookId']!),
      ),
    ),
    GoRoute(
      path: '/settings',
      builder: (_, __) => SettingsView(controller: SettingsController.instance),
    )
  ],
);
