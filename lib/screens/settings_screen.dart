import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_event.dart';
import '../blocs/theme/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ListView(
            children: [
              SwitchListTile(
                secondary: Icon(
                  state.isDark ? Icons.dark_mode : Icons.light_mode,
                ),
                title: const Text('Dark Theme'),
                subtitle: Text(
                  state.isDark ? 'Dark mode is on' : 'Light mode is on',
                ),
                value: state.isDark,
                onChanged: (_) =>
                    context.read<ThemeBloc>().add(const ToggleTheme()),
              ),
            ],
          );
        },
      ),
    );
  }
}
