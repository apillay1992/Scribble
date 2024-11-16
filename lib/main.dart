import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/repositories/firestore_note_repository.dart';
import 'package:notes_app/ui/screens/add_note_screen.dart';
import 'package:notes_app/ui/screens/auth_gate.dart';
import 'package:notes_app/ui/screens/home_screen.dart';
import 'package:notes_app/view_models/note_view_model.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/firebase_options.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NoteViewModel(FirestoreNoteRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple[100],
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.purple[700],
            ),
            titleTextStyle: TextStyle(
              color: Colors.purple[700],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.purple[400],
            behavior: SnackBarBehavior.floating,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.purple[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.purple[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.purple[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.purple[400]!, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[400],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Show a loading indicator while checking auth state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // If user is not logged in, show AuthGate
            if (!snapshot.hasData) {
              return const AuthGate();
            }

            // If user is logged in, show HomeScreen
            return const HomeScreen();
          },
        ),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddNoteScreen.routeName: (context) => const AddNoteScreen(),
        },
      ),
    );
  }
}