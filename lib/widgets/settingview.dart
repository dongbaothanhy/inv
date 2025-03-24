import 'package:flutter/material.dart';

/// A widget that displays a screenshot with specific aspect ratio and fitting properties.
class SettingView extends StatelessWidget {
  /// The URL of the image to display
  final String imageUrl;

  /// Creates a new [ScreenshotViewer] widget.
  ///
  /// The [imageUrl] parameter is required and specifies the URL of the image to display.
  const SettingView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.47,
      child: SizedBox(
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
