import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/items/items_bloc.dart';
import 'blocs/items/items_event.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/theme/theme_event.dart';
import 'blocs/theme/theme_state.dart';
import 'screens/home_screen.dart';
import 'services/api_service.dart';
import 'services/shared_preferences_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiService>(create: (_) => ApiService()),
        RepositoryProvider<SharedPreferencesService>(
          create: (_) => SharedPreferencesService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ItemsBloc>(
            create: (context) => ItemsBloc(context.read<ApiService>())
              ..add(const LoadItems()),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) =>
                ThemeBloc(context.read<SharedPreferencesService>())
                  ..add(const LoadTheme()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Flutter Clean App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              themeMode:
                  themeState.isDark ? ThemeMode.dark : ThemeMode.light,
              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
