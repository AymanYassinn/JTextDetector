// ignore_for_file: non_constant_identifier_names

part of jtdetector;

/// A [DetectedValue] class which provides a Return Value for [JTextDetector]

class DetectedValue {
  String _value = "";
  String _detectType = "";
  RegExp _regExp = RegExp(r'''a^''');

  ///[String] getter [value]
  String get value => _value;

  ///[String] getter [detectType]
  String get detectType => _detectType;

  ///[RegExp] getter [regExp]
  RegExp get regExp => _regExp;

  /// Creates a [DetectedValue] object from [DetectedValue.init(te, deType, reg)]
  DetectedValue.init(String te, String deType, RegExp reg) {
    _value = te;
    _detectType = deType;
    _regExp = reg;
  }
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

///  [detectFromText] method that take [String] parameter text and [Map] of [String] as types and [RegExp] as Patterns,
///  And has [List] of [DetectedValue] model as Return type
List<DetectedValue> detectFromText(String text, Map<String, RegExp> reg) {
  List<DetectedValue> list = [];
  RegExp? regExp;
  if (reg.isNotEmpty && text.isNotEmpty) {
    if (reg.entries.length > 1) {
      final len = reg.entries.length;
      final buffer = StringBuffer();
      //  for(var io in reg.entries)
      for (var i = 0; i < len; i++) {
        final type = reg.entries.toList()[i];
        final isLast = i == len - 1;
        isLast
            ? buffer.write("(${type.value.pattern})")
            : buffer.write("(${type.value.pattern})|");
      }
      if (buffer.isNotEmpty) {
        regExp = RegExp(buffer.toString());
      }
    } else {
      regExp = reg.values.first;
    }
    if (regExp != null) {
      if (regExp.hasMatch(text)) {
        final allText = text.split(regExp);
        final detectedList = regExp.allMatches(text).toList();
        // ignore: avoid_function_literals_in_foreach_calls
        allText.forEach((element) {
          if (detectedList.isNotEmpty) {
            final match = detectedList.removeAt(0);
            String matchedText = match.input.substring(match.start, match.end);
            for (var i in reg.entries.toList()) {
              if (i.value.hasMatch(matchedText)) {
                list.add(DetectedValue.init(matchedText, i.key, i.value));
              }
            }
          }
        });
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

/// An [Map] constant [STRING_REGEXP_CONST_MAP] for [String] Patterns and [String] types
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

/// An [Map] Global Var [REGEXP_MAP_VALUES] for [String] Patterns types and [RegExp] constant
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
