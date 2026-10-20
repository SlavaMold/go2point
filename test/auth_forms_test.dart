import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go2point/data/demo_login.dart';
import 'package:go2point/pages/login_page.dart';
import 'package:go2point/pages/register_page.dart';
import 'package:go2point/pages/home_page.dart';
import 'package:go2point/router.dart';
import 'package:go2point/theme/app_theme.dart';
import 'package:go2point/widgets/app_button.dart';
import 'package:go2point/widgets/app_text_field.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets(
    'Demo inputs allow login and remove the login page from history',
    (tester) async {
      final appRouter = await _openApp(tester);
      expect(
        tester.widget<TextFormField>(_field('Email')).controller!.text,
        DemoLogin.email,
      );
      expect(
        tester.widget<TextFormField>(_field('Password')).controller!.text,
        DemoLogin.password,
      );
      expect(
        _textField(tester, 'Email').keyboardType,
        TextInputType.emailAddress,
      );
      expect(_textField(tester, 'Password').obscureText, isTrue);
      expect(
        _textField(tester, 'Password').textInputAction,
        TextInputAction.done,
      );

      await _submit(tester, 'Sign In');
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(LoginPage, skipOffstage: false), findsNothing);
      expect(appRouter.canPop(), isFalse);
      expect(find.text('Welcome to Go2Point!'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Invalid login stays on the form; corrected non-demo input can enter',
    (tester) async {
      final appRouter = await _openApp(tester);
      await tester.enterText(_field('Email'), '');
      await tester.enterText(_field('Password'), '');
      await _submit(tester, 'Sign In');
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
      expect(appRouter.routeInformationProvider.value.uri.path, '/login');
      expect(find.byType(NavigationBar), findsNothing);

      await tester.enterText(_field('Email'), 'invalid');
      await tester.enterText(_field('Password'), '12345');
      await tester.pumpAndSettle();
      expect(find.text('Enter a valid email address'), findsOneWidget);
      expect(
        find.text('Password must be at least 6 characters'),
        findsOneWidget,
      );

      await tester.enterText(_field('Email'), 'student@example.com');
      await tester.enterText(_field('Password'), 'secret123');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      expect(appRouter.canPop(), isFalse);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Registration validates all fields then opens Home without auth history',
    (tester) async {
      final appRouter = await _openApp(tester, location: '/register');
      expect(find.text('Name is required'), findsNothing);
      await _submit(tester, 'Sign Up');
      for (final message in [
        'Name is required',
        'Email is required',
        'Password is required',
        'Please confirm your password',
      ]) {
        expect(find.text(message), findsOneWidget);
      }

      await tester.enterText(_field('Name'), 'Veaceslav');
      await tester.enterText(_field('Email'), 'student@example.com');
      await tester.enterText(_field('Password'), 'secret123');
      await tester.enterText(_field('Confirm password'), 'different');
      await _submit(tester, 'Sign Up');
      expect(find.text('Passwords do not match'), findsOneWidget);
      expect(appRouter.routeInformationProvider.value.uri.path, '/register');

      await tester.enterText(_field('Confirm password'), 'secret123');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.text('Passwords do not match'), findsNothing);
      expect(find.text('Registration details are valid.'), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RegisterPage, skipOffstage: false), findsNothing);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(appRouter.routeInformationProvider.value.uri.path, '/home');
      expect(appRouter.canPop(), isFalse);
      expect(tester.takeException(), isNull);
    },
  );
}

Finder _field(String label) => find.descendant(
  of: find.byWidgetPredicate(
    (widget) => widget is AppTextField && widget.label == label,
  ),
  matching: find.byType(TextFormField),
);

TextField _textField(WidgetTester tester, String label) =>
    tester.widget<TextField>(
      find.descendant(of: _field(label), matching: find.byType(TextField)),
    );

Future<GoRouter> _openApp(
  WidgetTester tester, {
  String location = '/login',
}) async {
  tester.view.physicalSize = const Size(430, 932);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final appRouter = createAppRouter(initialLocation: location);
  addTearDown(appRouter.dispose);
  await tester.pumpWidget(
    MaterialApp.router(theme: AppTheme.light(), routerConfig: appRouter),
  );
  await tester.pumpAndSettle();
  return appRouter;
}

Future<void> _submit(WidgetTester tester, String label) async {
  tester.testTextInput.hide();
  await _tapVisible(tester, find.widgetWithText(AppButton, label));
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
