import 'package:flutter/material.dart';
import 'package:unsplash/features/latest_photos/pages/latest_photo_page.dart';

import 'injector.dart';

class UnsplashDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Demo',
      theme: ThemeData.light().copyWith(
        accentColor: Colors.tealAccent,
        primaryColor: Colors.teal,
      ),
      darkTheme: ThemeData.dark().copyWith(
        accentColor: Colors.blueAccent,
      ),
      themeMode: ThemeMode.system,
      home: LatestPhotosPage(
        getLatestPhotos: injector(),
      ),
    );
  }
}
