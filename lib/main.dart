import 'package:bill_sync_app/customs/custom_loader.dart';
import 'package:bill_sync_app/riverpod/loading_state_riverpod.dart';
import 'package:bill_sync_app/routes/app_route.dart';
import 'package:bill_sync_app/routes/route_path.dart';
import 'package:bill_sync_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(
    const ProviderScope(
      child: RepaintBoundary(
        child: MyApp(),
      ),
    ),
  );
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return MaterialApp(
      title: 'BillSync',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      initialRoute: RoutePath.splashScreen,
      navigatorObservers: [routeObserver],
      onGenerateRoute: AppRoute().onGenerateRoute,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              child!,
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Loader(),
                ),
            ],
          ),
        );
      },
    );
  }
}


