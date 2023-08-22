# 🌇 IMGY

Flutter network image component

### Install

`pubspec.yml`
```yml
dependencies:
  imgy:
    git:
      url: https://github.com/C4co/imgy.git
```

### Features
 - Preview and full screen
 - Fade in effect
 - Description
 - Border
 - Padding
 - Save to gallery
 - Sharing
 - Placeholder color

### Usage

```dart
import 'package:imgy/imgy.dart';

var source = "[image_url]"
var fullSource = "[full_image_url]"

Imgy(
  src: source,
  fullSrc: fullSource,
  enableFullScreen: true,
  description: "Image description",
  placeholderColor: Colors.red
)
```

---

Carlos Costa 🖼 2023
