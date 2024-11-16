
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/ui/screens/add_note_screen.dart';
import 'package:notes_app/view_models/note_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {  // Changed to StatefulWidget
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // No need to navigate - AuthGate will handle this automatically
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error signing out. Please try again.'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[100],
        actions: [
          // Add Note button
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.purple[700],
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNoteScreen(),
                ),
              );
            },
          ),
          // Sign Out button
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.purple[700],
              size: 24,
            ),
            onPressed: _signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      backgroundColor: Colors.purple[50],
      body: Consumer<NoteViewModel>(
        // Rest of your existing body code remains the same
        builder: (context, noteViewModel, child) {
          if (noteViewModel.notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome ${user?.email ?? ""}!',  // Added welcome message
                    style: TextStyle(
                      color: Colors.purple[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No notes yet. Add your first note!',
                    style: TextStyle(
                      color: Colors.purple[300],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: noteViewModel.notes.length,
              itemBuilder: (context, index) {
                final note = noteViewModel.notes[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        note.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNoteScreen(note: note),
                        ),
                      );
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete Note'),
                          content: const Text(
                              'Are you sure you want to delete this note?'
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.purple[700]),
                              ),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                noteViewModel.deleteNote(note.id);
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
