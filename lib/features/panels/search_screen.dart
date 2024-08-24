import 'package:admin_console/core/app_imports.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    void clearSearch() {
      controller.clear();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                cursorHeight: 18,
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: clearSearch,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F5F7),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
