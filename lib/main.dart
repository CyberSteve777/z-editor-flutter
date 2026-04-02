import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_editor/app.dart';
import 'package:z_editor/bloc/app_navigation/app_navigation_cubit.dart';
import 'package:z_editor/bloc/settings/settings_cubit.dart';
import 'package:z_editor/l10n/resource_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ResourceNames.ensureLoaded();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsCubit(prefs)),
        BlocProvider(create: (_) => AppNavigationCubit()),
      ],
      child: const ZEditorApp(),
    ),
  );
}
