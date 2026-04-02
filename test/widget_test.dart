// Basic Flutter widget smoke test.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:z_editor/app.dart';
import 'package:z_editor/bloc/app_navigation/app_navigation_cubit.dart';
import 'package:z_editor/bloc/settings/settings_cubit.dart';

void main() {
  testWidgets('App builds and loads', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SettingsCubit(prefs)),
          BlocProvider(create: (_) => AppNavigationCubit()),
        ],
        child: const ZEditorApp(),
      ),
    );

    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
