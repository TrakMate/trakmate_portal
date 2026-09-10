import 'package:flutter/foundation.dart';

/// Simple pub/sub used to tell a section "please scroll to this item"
/// after the footer navigates to it.
class SectionScrollBus {
  SectionScrollBus._();
  static final SectionScrollBus instance = SectionScrollBus._();

  final ValueNotifier<ScrollRequest?> pendingKey =
      ValueNotifier<ScrollRequest?>(null);

  void request(String key) {
    pendingKey.value = ScrollRequest(key);
  }
}

/// Wrapping the string in an object means two clicks on the SAME menu
/// item in a row still create a "new" value, so ValueNotifier fires
/// its listeners every time — not just when the key text changes.
class ScrollRequest {
  final String key;
  ScrollRequest(this.key);
}
