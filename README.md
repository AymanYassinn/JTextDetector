# jtdetector

Just Text Detector: Just An Amazing Highly Customizable Text Detector Widget Package That Can Detect Url,HashTag,Email,User Tag & any Other Pattern.

## Features
- Text Detector Widget
- Text Detector Method
- Many RegExp Constants
- Highly Customizable Widget
- Many Options

## Usage
To use this package, add `jtdetector` as a dependency in your `pubspec.yaml` file.

```dart
import 'package:jtdetector/jtdetector.dart';
```
## Simple Usage
You Can Use The Widget, Constants, Method

#JTextDetector Widget
 
```dart
const Map<String, dynamic> STRING_REGEXP_CONST_MAP = {
  URL_REGEXP_TYPE: URL_REGEXP,
  PHONE_REGEXP_TYPE: PHONE_REGEXP,
  EMAIL_REGEXP_TYPE: EMAIL_REGEXP,
  HASHTAG_REGEXP_TYPE: HASHTAG_REGEXP,
  USER_TAG_REGEXP_TYPE: USER_TAG_REGEXP,
  USER_ID_TAG_REGEXP_TYPE: USER_TAG_WITH_ID,
  ARABIC_REGEXP_TYPE: ARABIC_REGEXP,
  ENGLISH_REGEXP_TYPE: ENGLISH_REGEXP,
};
JTextDetector(
                  text: "website  https://jucodes.com/en  web: www.jucodes.com,  facebook.com,  link http://jucodes.com/method?id=hello.com, hashtag #trending & mention @dev.user +12345678901",
                  selectable: false,
                  detectorOptions: [
                    for (var io in STRING_REGEXP_CONST_MAP.entries.toList())
                      DetectorOptions(
                        pattern: io.value,
                        type: io.key,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: fColors[i],
                        ),
                        onTap: (value) {
                          debugPrint(
                              "${value.detectType}:${value.value}:${value.regExp.pattern}");
                        },
                        parsingValue:(value) {
                                RegExp customRegExp =
                                    RegExp(r'''[a-zA-Z\u0600-\u06FF]+''');
                                Match? match =
                                    customRegExp.firstMatch(value.value);
                                DetectedValue val = value;
                                if (match != null) {
                                  var ma = match[0].toString();
                                  val = DetectedValue.init(
                                      ma, "NoD", customRegExp);
                                }
                                debugPrint(
                                    "${value.detectType}:${value.value}:${value.regExp.pattern}");
                                debugPrint(
                                    "${val.detectType}:${val.value}:${val.regExp.pattern}");
                                return val;
                              },
                        valueWidget:  (value) {
                                return Container(
                                  color: Colors.blue,
                                  child: Text(
                                    value.value,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                      ),
                  ],
                ),
```

#Method

```dart
Map<String, RegExp> REGEXP_MAP_VALUES = {
  URL_REGEXP_TYPE: RegExp(URL_REGEXP),
  PHONE_REGEXP_TYPE: RegExp(PHONE_REGEXP),
  EMAIL_REGEXP_TYPE: RegExp(EMAIL_REGEXP),
  HASHTAG_REGEXP_TYPE: RegExp(HASHTAG_REGEXP),
  USER_TAG_REGEXP_TYPE: RegExp(USER_TAG_REGEXP),
  USER_ID_TAG_REGEXP_TYPE: RegExp(USER_TAG_WITH_ID),
  ARABIC_REGEXP_TYPE: RegExp(ARABIC_REGEXP),
  ENGLISH_REGEXP_TYPE: RegExp(ENGLISH_REGEXP),
};
List<DetectedValue> value = detectFromText("website  https://jucodes.com/en  web: www.jucodes.com,  facebook.com,  link http://jucodes.com/method?id=hello.com, hashtag #trending & mention @dev.user +12345678901", REGEXP_MAP_VALUES);

```

## Additional information

Provided By [Just Codes Developers](https://jucodes.com/)