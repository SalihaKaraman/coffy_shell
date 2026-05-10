import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coffy_shell/firebase_options.dart';
import 'package:coffy_shell/app.dart';
import 'package:coffy_shell/services/firebase_service.dart';
import 'package:coffy_shell/providers/cart_provider.dart';
import 'package:coffy_shell/providers/navigation_provider.dart';
import 'package:coffy_shell/providers/favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Google Fonts yapılandırması - HTTP çekmeyi aktif tut ama takılmayı önlemeye çalış
  GoogleFonts.config.allowRuntimeFetching = true;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const App(),
    ),
  );

  // Seed dummy data in background
  FirebaseService().populateDummyData();
}


