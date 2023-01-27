import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A [JTDetector] class which provides a SpanWidgets Value
class JTDetector {
  ///[List] of [DetectorOptions] - [_fDetections]
  final List<DetectorOptions> _fDetections;

  ///[TextStyle] of [_style]
  final TextStyle? _style;

  ///[String] of [_fText]
  final String _fText;

  ///[bool] of [_valid]
  final bool _valid;

  ///[Function] of [DetectedValue] - [_onTap]
  Function(DetectedValue)? _onTap;

  ///constructor for [JTDetector]
  JTDetector(
      [this._fDetections = const [],
      this._fText = '',
      this._style,
      this._onTap,
      this._valid = true]);

  ///[TextSpan] Getter - [spans]
  TextSpan get spans => _jSpansWidget();

  ///[RegExp] Getter - [regExp]
  RegExp get regExp => _fRegex();
  TextSpan _jSpansWidget() {
    final regExp = _fRegex();
    if (_fText.isEmpty || _fDetections.isEmpty || !regExp.hasMatch(_fText)) {
      return TextSpan(text: _fText, style: _style);
    }
    final textList = _fText.split(regExp);
    final detectedList = regExp.allMatches(_fText).toList();

    final span = textList.map((e) {
      return TextSpan(
        children: [
          TextSpan(text: e, style: _style),
          if (_valid) _spansList(detectedList),
          if (!_valid) _spansList2(detectedList),
        ],
      );
    }).toList();
    return TextSpan(children: span);
  }

  InlineSpan _spansList(List<RegExpMatch> detectedList) {
    InlineSpan fWidget = TextSpan();
    if (detectedList.isNotEmpty) {
      final match = detectedList.removeAt(0);
      String matchedText = match.input.substring(match.start, match.end);
      String fType = "";
      RegExp fRegExp = RegExp(r'''a^''');
      TextStyle? fStyle = _style;
      Function(DetectedValue) fOnTap = _onTap ?? (DetectedValue b) {};
      DetectorOptions? fDetector;
      for (var i in _fDetections) {
        if (i.pat.hasMatch(matchedText)) {
          fDetector = i;
          fType = i.type;
          fRegExp = i.pat;
          fStyle = i.style;
          if (i.onTap != null) {
            fOnTap = i.onTap!;
          }
        }
      }
      final fDetectedValue = DetectedValue(fRegExp, matchedText, fType);

      if (fDetector != null) {
        if (fDetector.valueWidget != null) {
          fWidget = WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () => fOnTap(fDetectedValue),
              child: fDetector.valueWidget!(fDetectedValue),
            ),
          );
        } else if (fDetector.parsingValue != null) {
          var result = fDetector.parsingValue!(fDetectedValue);
          fWidget = TextSpan(
            text: result.value,
            style: fStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => fOnTap(fDetectedValue),
          );
        } else if (fDetector.spanWidget != null) {
          fWidget = fDetector.spanWidget!(fDetectedValue);
        } else {
          fWidget = TextSpan(
            text: matchedText,
            style: fStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => fOnTap(fDetectedValue),
          );
        }
      } else {
        fWidget = TextSpan(
          text: matchedText,
          style: fStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => fOnTap(fDetectedValue),
        );
      }
    }
    return fWidget;
  }

  InlineSpan _spansList2(List<RegExpMatch> detectedList) {
    InlineSpan fWidget = TextSpan();
    if (detectedList.isNotEmpty) {
      final match = detectedList.removeAt(0);
      String matchedText = match.input.substring(match.start, match.end);
      String fType = "";
      RegExp fRegExp = RegExp(r'''a^''');
      TextStyle? fStyle = _style;
      Function(DetectedValue) fOnTap = _onTap ?? (DetectedValue b) {};
      DetectorOptions? fDetector;
      for (var i in _fDetections) {
        if (i.pat.hasMatch(matchedText)) {
          fDetector = i;
          fType = i.type;
          fRegExp = i.pat;
          fStyle = i.style;
          if (i.onTap != null) {
            fOnTap = i.onTap!;
          }
        }
      }
      final fDetectedValue = DetectedValue(fRegExp, matchedText, fType);
      if (fDetector != null) {
        if (fDetector.valueWidget != null) {
          fWidget = WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () => fOnTap(fDetectedValue),
              child: fDetector.valueWidget!(fDetectedValue),
            ),
          );
        } else if (fDetector.parsingValue != null) {
          var result = fDetector.parsingValue!(fDetectedValue);
          fWidget = TextSpan(
            text: result.value,
            style: fStyle,
          );
        } else if (fDetector.spanWidget != null) {
          fWidget = fDetector.spanWidget!(fDetectedValue);
        } else {
          fWidget = TextSpan(
            text: matchedText,
            style: fStyle,
          );
        }
      } else {
        fWidget = TextSpan(
          text: matchedText,
          style: fStyle,
        );
      }
    }
    return fWidget;
  }

  RegExp _fRegex() {
    if (_fDetections.isEmpty) {
      return RegExp(r'''a^''');
    } else if (_fDetections.length == 1) {
      return _fDetections.first.pat;
    } else {
      final len = _fDetections.length;
      final buffer = StringBuffer();
      for (var i = 0; i < len; i++) {
        final type = _fDetections[i];
        final isLast = i == len - 1;
        isLast
            ? buffer.write("(${type.pattern})")
            : buffer.write("(${type.pattern})|");
      }
      return RegExp(buffer.toString());
    }
  }
}

/// A [DetectedValue] class which provides a Return Value for [JTextDetector] and [JTextFieldDetector]
class DetectedValue {
  String _value = "";
  String _detectType = "";
  RegExp _regExp = RegExp(r'''a^''');
  DetectedValue(this._regExp, [this._value = '', this._detectType = ""]);

  ///[String] getter [value]
  String get value => _value;

  ///[String] getter [detectType]
  String get detectType => _detectType;

  ///[RegExp] getter [regExp]
  RegExp get regExp => _regExp;
}

/// A [DetectorOptions] class which provides a structure for [JTextDetector] to handle
/// Pattern matching and also to provide custom [Function] and custom [TextStyle].
class DetectorOptions {
  ///[String] setter [type]
  String type = "Empty";

  ///[String] setter [pattern]
  String pattern = r'''a^''';

  /// [style] Takes a custom style of [TextStyle] for the matched text widget
  TextStyle? style;

  ///[onTap] A custom [Function] to handle onTap.
  Function(DetectedValue)? onTap;

  ///[parsingValue] A callback function that takes one parameter of Type [DetectedValue]
  DetectedValue Function(DetectedValue dv)? parsingValue;

  /// [valueWidget] A callback function that takes one parameter of Type [DetectedValue]
  /// the [Widget] to be displayed inside a [WidgetSpan]
  Widget Function(DetectedValue dv)? valueWidget;

  /// [spanWidget] A callback function that takes one parameter of Type [DetectedValue]
  /// and display [TextSpan]
  TextSpan Function(DetectedValue dv)? spanWidget;

  ///[RegExp] getter [pat]
  RegExp get pat => RegExp(pattern);

  /// Creates a [DetectorOptions] object
  DetectorOptions({
    this.type = "Empty",
    this.pattern = r'''a^''',
    this.style,
    this.onTap,
    this.parsingValue,
    this.valueWidget,
    this.spanWidget,
  });
}

/// An constant [String] for [URL_REGEXP] Pattern
const String URL_REGEXP =
    r'''(?<= |^)([--:\w?%&+~#=]*\.[a-z]{2,4}\/{0,2})((?:[?&](?:\w+)=(?:\w+))+|[--:\w?@%&+~#=]+)?''';

/// An constant [String] for [HASHTAG_REGEXP] Pattern
const String HASHTAG_REGEXP =
    r'''(?!\n)(?:^|\s)(#([·・ー_0-9０-９a-zA-Zａ-ｚＡ-Ｚ\u0600-\u06FF]+))''';

/// An constant [String] for [USER_TAG_REGEXP] Pattern
const String USER_TAG_REGEXP =
    r'''(?!\n)(?:^|\s)([@]([·・ー_0-9０-９a-zA-Zａ-ｚＡ-Ｚ\u0600-\u06FF]+))''';

/// An constant [String] for [PHONE_REGEXP] Pattern
const String PHONE_REGEXP =
    r'''\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{3,4})(?: *x(\d+))?\s*''';

/// An constant [String] for [EMAIL_REGEXP] Pattern
const String EMAIL_REGEXP =
    r'''[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?''';

/// An constant [String] for [USER_TAG_WITH_ID] Pattern
const String USER_TAG_WITH_ID = r'''\[(@[^:]+):([^\]]+)\]''';

/// An constant [String] for [ARABIC_REGEXP] Pattern
const String ARABIC_REGEXP = r'''[\u0600-\u06FF]+''';

/// An constant [String] for [ENGLISH_REGEXP] Pattern
const String ENGLISH_REGEXP = r'''[a-zA-Z]+''';

///  [detectFromText] method that take [String] parameter text and [List] of [DetectorOptions] as fList,
///  And has [List] of [DetectedValue] model as Return type
List<DetectedValue> detectFromText(String text, List<DetectorOptions> fList) {
  List<DetectedValue> list = [];
  if (text.isNotEmpty && fList.isNotEmpty) {
    final detector = JTDetector(fList, text);
    if (detector.regExp.hasMatch(text)) {
      final allText = text.split(detector.regExp);
      final detectedList = detector.regExp.allMatches(text).toList();
      for (int io = 0; io < allText.length; io++) {
        if (detectedList.isNotEmpty) {
          final match = detectedList.removeAt(0);
          String matchedText = match.input.substring(match.start, match.end);
          for (var i in fList) {
            if (i.pat.hasMatch(matchedText)) {
              list.add(DetectedValue(i.pat, matchedText, i.type));
            }
          }
        }
      }
    }
  }
  return list;
}

/// An [String] constant for [URL_REGEXP_TYPE]
const URL_REGEXP_TYPE = "URL";

/// An [String] constant for [PHONE_REGEXP_TYPE]
const PHONE_REGEXP_TYPE = "PHONE";

/// An [String] constant for [EMAIL_REGEXP_TYPE]
const EMAIL_REGEXP_TYPE = "EMAIL";

/// An [String] constant for [HASHTAG_REGEXP_TYPE]
const HASHTAG_REGEXP_TYPE = "HASHTAG";

/// An [String] constant for [USER_TAG_REGEXP_TYPE]
const USER_TAG_REGEXP_TYPE = "USER_TAG";

/// An [String] constant for [USER_ID_TAG_REGEXP_TYPE]
const USER_ID_TAG_REGEXP_TYPE = "USER_ID_TAG";

/// An [String] constant for [ARABIC_REGEXP_TYPE]
const ARABIC_REGEXP_TYPE = "ARABIC";

/// An [String] constant for [ENGLISH_REGEXP_TYPE]
const ENGLISH_REGEXP_TYPE = "ENGLISH";

/// An [List] Global Var [defaultDetectorOptionsList] for [DetectorOptions]
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
