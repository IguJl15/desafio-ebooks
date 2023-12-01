part of "app.dart";

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/read/:eBookId',
      builder: (_, __) => Placeholder(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsView(controller: SettingsController.instance),
    )
  ],
);
