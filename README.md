# IMGY

![Static Badge](https://img.shields.io/badge/Flutter_package-blue)
[![Imgy](https://github.com/C4co/imgy/actions/workflows/dart.yml/badge.svg)](https://github.com/C4co/imgy/actions/workflows/dart.yml)


| Example                                 |
| --------------------------------------- |
| <img src="./example.gif" width={350} /> |

## **Features**
 - Preview and full screen
 - Fade in effect
 - Description
 - Border
 - Padding
 - Save to gallery
 - Sharing
 - Placeholder color

## Install

`pubspec.yml`
```yml
dependencies:
  imgy:
    git:
      url: https://github.com/C4co/imgy.git
```

## Usage

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

## Properties

| Name                | Type     | Default              | Description                               |
| ------------------- | -------- | -------------------- | ----------------------------------------- |
| `src`               | `String` | `null`               | preview image source                      |
| `fullSrc`           | `String` | `null`               | full screen image source                  |
| `enableFullScreen`  | `bool`   | `false`              | enable full screen view                   |
| `description`       | `String` | `null`               | image description                         |
| `placeholderColor`  | `Color`  | `Colors.transparent` | placeholder color when image is loading   |
| `padding`           | `double` | `0`                  | container padding                         |
| `rounded`           | `double` | `0`                  | border radius                             |
| `width`             | `double` | `100`                | image width                               |
| `height`            | `double` | `100`                | image height                              |
| `borderWidth`       | `double` | `0`                  | container border width                    |
| `borderColor`       | `double` | `0`                  | container border color                    |
| `canSave`           | `bool`   | `true`               | support to save image to gallery          |
| `canShare`          | `bool`   | `true`               | support to share image                    |
| `tapOnImageToClose` | `bool`   | `true`               | close fullscreen view image when tap over |

---

Carlos Costa 🖼 2023
