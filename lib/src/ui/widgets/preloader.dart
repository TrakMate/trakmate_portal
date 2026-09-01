import 'package:video_player/video_player.dart';

class HeroVideoPreloader {
  static final VideoPlayerController controller = VideoPlayerController.asset(
    'video/hero1.mp4',
  );

  static Future<void> initialize() async {
    if (controller.value.isInitialized) return;

    await controller.initialize();
    await controller.setLooping(true);
    await controller.setVolume(0);
  }

  static void dispose() {
    controller.dispose();
  }
}
