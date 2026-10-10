import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const FirstIosApp());
}

class FirstIosApp extends StatelessWidget {
  const FirstIosApp({super.key});

  static const Color _primary = Color(0xFFF97316);
  static const Color _background = Color(0xFFFFF7ED);
  static const Color _foreground = Color(0xFF9A3412);
  static const Color _accent = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primary,
      primary: _primary,
      onPrimary: const Color(0xFF0F172A),
      secondary: const Color(0xFFFB923C),
      tertiary: _accent,
      surface: _background,
      onSurface: _foreground,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'First iOS App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: _background,
        splashFactory: InkRipple.splashFactory,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final platformLabel = _platformLabel(theme.platform);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Semantics(
                  header: true,
                  label: 'hey its my first ios app',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _AppMark(isDark: isDark, colors: colors),
                      const SizedBox(height: 40),
                      Text(
                        'hey its my first ios app',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                          height: 1.25,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Built with Flutter for Android and iOS.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          color: colors.onSurface.withValues(alpha: 0.72),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _PlatformChip(
                        label: platformLabel,
                        color: colors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static String _platformLabel(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return 'Running on iOS';
      case TargetPlatform.android:
        return 'Running on Android';
      default:
        return 'Ready for Android & iOS';
    }
  }
}

class _AppMark extends StatelessWidget {
  const _AppMark({required this.isDark, required this.colors});

  final bool isDark;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'App icon',
      image: true,
      child: Container(
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: isDark ? 0.28 : 0.36),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: isDark ? 0.04 : 0.7),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Icon(
          Icons.phone_iphone_rounded,
          size: 52,
          color: colors.onPrimary,
        ),
      ),
    );
  }
}

class _PlatformChip extends StatelessWidget {
  const _PlatformChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.devices_rounded, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
