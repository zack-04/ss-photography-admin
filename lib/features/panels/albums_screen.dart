import 'package:admin_console/widgets/album_container.dart';
import 'package:flutter/material.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key, this.clientId});
  final int? clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          children: [
            SizedBox(
              height: 90,
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onTap: () => widget.onClientSelected(index),
                    child: const AlbumContainer(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
