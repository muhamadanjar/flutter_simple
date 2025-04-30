import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/slider.dart';

class SliderItemWidget extends StatelessWidget {
  final SliderItem slide;

  const SliderItemWidget({
    super.key,
    required this.slide,
  });


  @override
  Widget build(BuildContext context) {
    print('slider item build ${slide.imageUrl}');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            // Background image
            CachedNetworkImage(
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: slide.imageUrl,
              placeholder: (context, url) => Image.asset(
                'assets/img/loading.gif',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slide.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      slide.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
