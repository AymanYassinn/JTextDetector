# jtdetector

Just Text Detector: Just An Amazing Highly Customizable Text & Text Field Detector Widgets Package That Can Detect Url,HashTag,Email,User Tag & any Other Pattern.

## Features
- Text Field Detector Widget
- Text Detector Widget
- Text Detector Method
- Many RegExp Constants
- Highly Customizable Widget

## Usage
To use this package, add `jtdetector` as a dependency in your `pubspec.yaml` file.

```dart
import 'package:jtdetector/jtdetector.dart';
```
## Simple Usage
You Can Use The Widgets, Constants, Method

#JTextFieldDetector Widget

```dart
JTextFieldDetector(
                controller: controller,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),isTapValid: false,
                textDirection: TextDirection.rtl,
                clipBehavior: Clip.hardEdge,
                detectorOptions: detectorOptionsList,
                maxLines: 15,
              ),
```
#JTextDetector Widget

```dart
          JTextDetector(
                text: "This  a url: https://jucodes.com email address: info@jucodes.com an #hashtag @user tag +967772445395",
                detectorOptions: [
                  DetectorOptions(
                      type: PHONE_REGEXP_TYPE,
                      pattern: PHONE_REGEXP,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                      ),
                      onTap: (val) {
                        debugPrint("tel:${val.value}");
                      }),
                  DetectorOptions(
                      type: "Url",
                      pattern: URL_REGEXP,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                      ),
                      onTap: (val) {
                        debugPrint("website:${val.value}");
                      }),
                  DetectorOptions(
                      type: "Tag",
                      pattern: r'''(?!\n)(?:^|\s)(#([·・ー_0-9０-９a-zA-Zａ-ｚＡ-Ｚ\u0600-\u06FF]+))''',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                      ),
                      onTap: (val) {
                        debugPrint("Tag:${val.value}");
                      }),
                  
                ],
              )
```
#Method

```dart
List<DetectorOptions> defaultDetectorOptionsList = [
  DetectorOptions(
    type: URL_REGEXP_TYPE,
    pattern: URL_REGEXP,
  ),
  DetectorOptions(
    type: PHONE_REGEXP_TYPE,
    pattern: PHONE_REGEXP,
  ),
  DetectorOptions(
    type: EMAIL_REGEXP_TYPE,
    pattern: EMAIL_REGEXP,
  ),
  DetectorOptions(
    type: HASHTAG_REGEXP_TYPE,
    pattern: HASHTAG_REGEXP,
  ),
  DetectorOptions(
    type: USER_TAG_REGEXP_TYPE,
    pattern: USER_TAG_REGEXP,
  ),
  DetectorOptions(
    type: USER_ID_TAG_REGEXP_TYPE,
    pattern: USER_TAG_WITH_ID,
  ),
];
List<DetectedValue> value = detectFromText("website  https://jucodes.com/en  web: www.jucodes.com,  facebook.com,  link http://jucodes.com/method?id=hello.com, hashtag #trending & mention @dev.user +12345678901", defaultDetectorOptionsList);

```

## Additional information

Provided By [Just Codes Developers](https://jucodes.com/)