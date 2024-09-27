import 'package:demo_svd/note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notepage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Notes App',
            style: TextStyle(
              color: Color.fromARGB(255, 110, 110, 110),
              fontSize: 23,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () => Get.to(const Notepage()),
          backgroundColor: Colors.amber[600],
          child: const Icon(
            Icons.add,
            size: 42,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('notes').listenable(),
          builder: (context, Box<Note> box, _) {
            if (box.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'No notes here yet',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final note = box.getAt(index);

                  String truncatedContent = (note?.content ?? '').length > 30
                      ? '${note?.content.substring(0, 30)}....'
                      : note?.content ?? '';

                  return Card(
                    color: Colors.grey[100],
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(Notepage(note: note, index: index));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note?.title ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              truncatedContent,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
