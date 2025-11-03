import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../widgets/note_tile.dart';
import 'edit_note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NoteProvider>().notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 My Notes'),
        centerTitle: true,
      ),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet. Tap + to add one!'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (ctx, i) => NoteTile(note: notes[i]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const EditNoteScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
