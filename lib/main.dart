import 'package:admin_console/features/panels/albums_screen.dart';
import 'package:admin_console/features/panels/client_screen.dart';
import 'package:admin_console/features/panels/files_screen.dart';
import 'package:admin_console/features/panels/login_screen.dart';
import 'package:admin_console/features/panels/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
    );
  }
}

// Define the global keys for navigator states
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginScreen(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithSidebar(
          showSidebar: state.uri.toString() != '/login',
          child: navigationShell, 
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'users'),
          routes: [
            GoRoute(
              path: '/users',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: UsersScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'clients'),
          routes: [
            GoRoute(
              path: '/clients',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ClientScreen(),
              ),
              routes: [
                GoRoute(
                  path: ':clientId',
                  pageBuilder: (context, state) {
                    final clientId = state.pathParameters['clientId']!;
                    return NoTransitionPage(
                      child: AlbumsScreen(
                        clientId: clientId,
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'albums/:albumId',
                      pageBuilder: (context, state) {
                        final clientId = state.pathParameters['clientId']!;
                        final albumId = state.pathParameters['albumId']!;
                        return NoTransitionPage(
                          child: FilesScreen(
                            clientId: clientId,
                            albumsId: albumId,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'search'),
          routes: [
            GoRoute(
              path: '/search',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'gallery'),
          routes: [
            GoRoute(
              path: '/gallery',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: GalleryScreen(),
              ),
            ),
          ],
        ),
        // Add other branches for different top-level routes if needed
        // For example: Search and Gallery
      ],
    ),
  ],
);

class ScaffoldWithSidebar extends StatelessWidget {
  final Widget child;
  final bool showSidebar;

  const ScaffoldWithSidebar({
    super.key,
    required this.child,
    this.showSidebar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (showSidebar) const Sidebar(),
          if (showSidebar)
            SizedBox(
              child: VerticalDivider(
                color: Colors.grey.shade300,
                thickness: 1,
                width: 2,
              ),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String currentRoute = '/users';

  void toggleRoute(String route) {
    setState(() {
      currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      //color: Colors.blueGrey[800],
      child: Column(
        children: [
          const SizedBox(height: 40), // Spacing from top
          SidebarItem(
            icon: 'assets/icons/client.png',
            text: 'Users',
            route: '/users',
            isActive: currentRoute.startsWith('/users'),
            handleToggle: toggleRoute,
          ),
          SidebarItem(
            icon: 'assets/icons/client.png',
            text: 'Clients',
            route: '/clients',
            isActive: currentRoute.startsWith('/clients'),
            handleToggle: toggleRoute,
          ),
          SidebarItem(
            icon: 'assets/icons/search.png',
            text: 'Search',
            route: '/search',
            isActive: currentRoute.startsWith('/search'),
            handleToggle: toggleRoute,
          ),
          SidebarItem(
            icon: 'assets/icons/gallery.png',
            text: 'Gallery',
            route: '/gallery',
            isActive: currentRoute.startsWith('/gallery'),
            handleToggle: toggleRoute,
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String icon;
  final String text;
  final String route;
  final bool isActive;
  final void Function(String route) handleToggle;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.text,
    required this.route,
    required this.isActive,
    required this.handleToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        selectedColor: isActive
            ? const Color.fromARGB(255, 40, 104, 241)
            : Colors.grey[200],
        leading: Image.asset(
          icon,
          height: 20,
          width: 20,
          color: isActive
              ? const Color.fromARGB(255, 40, 104, 241)
              : const Color(0xFF5B6B79),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: isActive
                ? const Color.fromARGB(255, 40, 104, 241)
                : const Color(0xFF5B6B79),
          ),
        ),
        selected: isActive,
        selectedTileColor: Colors.blue.withOpacity(0.1),
        hoverColor: isActive ? Colors.blue[50] : Colors.grey[200],
        onTap: () {
          handleToggle(route);
          GoRouter.of(context).go(route);
        },
        // tileColor: _selectedIndex == index ? Colors.blue[200] : Colors.grey[300],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Content'));
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Gallery Content'));
  }
}
