# 🌇 IMGY

<center>
  <p>Flutter image component<p>
  <img src="./example.gif" width={350} />
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

### Properties

| Name               | Type     | Description                             |
| ------------------ | -------- | --------------------------------------- |
| `src`              | `String` | preview image source                    |
| `fullSrc`          | `String` | full screen image source                |
| `enableFullScreen` | `bool`   | enable full screen view                 |
| `description`      | `String` | image description                       |
| `placeholderColor` | `Color`  | placeholder color when image is loading |
| `padding`          | `double` | container padding                       |
| `rounded`          | `double` | border radius                           |
| `width`            | `double` | image width                             |
| `height`           | `double` | image height                            |
| `borderWidth`      | `double` | container border width                  |
| `canSave`          | `bool`   | support to save image to gallery        |
| `canShare`         | `bool`   | support to share image                  |

---

Carlos Costa 🖼 2023
