import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/book_provider.dart';
import '../services/notification/RideActionService.dart';
import '../services/notification/overlay_permission_service.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  @override
  void initState() {
    super.initState();

    // Register ride action listener only once
    RideActionService.listen(
      onAction: (action) async {
        if (action == 'ACCEPT_RIDE') {
          debugPrint('🔥 ACCEPT RIDE RECEIVED');

          if (!mounted) return;

          await context.read<BookProvider>().getBooks();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // --------------------------------
        // Start Overlay Button
        // --------------------------------

        SizedBox(
          height: 60,
          width: 250,
          child: ElevatedButton(
            onPressed: () async {
              await OverlayPermissionService.startRideOverlay();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Start Overlay",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // --------------------------------
        // Loader
        // --------------------------------

        if (provider.isLoading)
          const CircularProgressIndicator(),

        // --------------------------------
        // Error
        // --------------------------------

        if (provider.error != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              provider.error!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),

        // --------------------------------
        // Books
        // --------------------------------

        if (!provider.isLoading)
          ...provider.books.map(
                (book) {
              return ListTile(
                title: Text(
                  book['title'].toString(),
                ),
                subtitle: Text(
                  'ID: ${book['id']}',
                ),
              );
            },
          ),
      ],
    );
  }
}