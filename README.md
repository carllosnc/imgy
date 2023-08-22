# 🌇 IMGY

<center>
  <p>Flutter network image component<p>
  <img src="./example.gif" />
</center>

---

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

var previewImage = "prevew image address"
var fullImage = "full image address"

Imgy(
  src: previewImage,
  fullSrc: fullImage,
  enableFullScreen: true,
  description: "Image description",
  placeholderColor: Colors.red
)
```

---

Carlos Costa 🖼 2023
