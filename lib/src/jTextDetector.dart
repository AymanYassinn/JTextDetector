part of jtdetector;

class JTextDetector extends StatelessWidget {
  const JTextDetector(
      {Key? key,
      this.text = "",
      this.textStyle,
      this.defaultDetectStyle,
      this.detectorOptions = const [],
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.onTap,
      this.selectable = false})
      : super(key: key);

  /// [text] to be Detect
  final String text;

  /// [textStyle] applied the text
  final TextStyle? textStyle;

  /// [defaultDetectStyle] added to the formatted matches in the text
  final TextStyle? defaultDetectStyle;

  ///[onTap] A custom [Function] to handle onTap.
  final Function(DetectedValue)? onTap;

  /// [detectorOptions] Model [List] to override the RegExp to be formatted in the text
  final List<DetectorOptions> detectorOptions;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// Defaults to retrieving the value from the nearest [DefaultTextStyle] ancestor.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  final bool selectable;
  @override
  Widget build(BuildContext context) {
    if (selectable) {
      return SelectableText.rich(
        _jSpansWidget(
            style: defaultDetectStyle,
            onTap: onTap,
            fModel: detectorOptions,
            fText: text),
        key: key,
        style: textStyle,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
        semanticsLabel: semanticsLabel,
        maxLines: maxLines,
        selectionControls: MaterialTextSelectionControls(),
        /*toolbarOptions: const ToolbarOptions(
          selectAll: true,
          copy: true,
        ),
        */
      );
    } else {
      return Text.rich(
        _jSpansWidget(
            style: defaultDetectStyle,
            onTap: onTap,
            fModel: detectorOptions,
            fText: text),
        key: key,
        style: textStyle,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        locale: locale,
      );
    }
  }
}

RegExp _fRegex(List<DetectorOptions> detectorOptions) {
  if (detectorOptions.isEmpty) {
    return RegExp(r'''a^''');
  } else if (detectorOptions.length == 1) {
    return detectorOptions.first.pat;
  } else {
    final len = detectorOptions.length;
    final buffer = StringBuffer();
    for (var i = 0; i < len; i++) {
      final type = detectorOptions[i];
      final isLast = i == len - 1;
      isLast
          ? buffer.write("(${type.pattern})")
          : buffer.write("(${type.pattern})|");
    }
    return RegExp(buffer.toString());
  }
}

TextSpan _jSpansWidget({
  String fText = "",
  List<DetectorOptions> fModel = const [],
  Function(DetectedValue)? onTap,
  TextStyle? style,
}) {
  final regExp = _fRegex(fModel);
  if (fText.isEmpty || fModel.isEmpty || !regExp.hasMatch(fText)) {
    return TextSpan(text: fText);
  }
  final textList = fText.split(regExp);
  final List<InlineSpan> spanList = [];
  final detectedList = regExp.allMatches(fText).toList();
  for (final textItem in textList) {
    spanList.add(TextSpan(
      text: textItem,
    ));
    if (detectedList.isNotEmpty) {
      final match = detectedList.removeAt(0);
      String matchedText = match.input.substring(match.start, match.end);
      String fType = "";
      RegExp fRegExp = RegExp(r'''a^''');
      TextStyle? fStyle = style;
      Function(DetectedValue) fOnTap = onTap ?? (DetectedValue b) {};

      DetectorOptions? fDetector;
      for (var i in fModel) {
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
      final fDetectedValue = DetectedValue.init(matchedText, fType, fRegExp);
      if (fDetector != null) {
        if (fDetector.valueWidget != null) {
          spanList.add(WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () => fOnTap(fDetectedValue),
              child: fDetector.valueWidget!(fDetectedValue),
            ),
          ));
        } else if (fDetector.parsingValue != null) {
          var result = fDetector.parsingValue!(fDetectedValue);
          spanList.add(TextSpan(
            text: result.value,
            style: fStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => fOnTap(fDetectedValue),
          ));
        } else if (fDetector.spanWidget != null) {
          spanList.add(fDetector.spanWidget!(fDetectedValue));
        } else {
          spanList.add(TextSpan(
            text: matchedText,
            style: fStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => fOnTap(fDetectedValue),
          ));
        }
      } else {
        spanList.add(TextSpan(
          text: matchedText,
          style: fStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => fOnTap(fDetectedValue),
        ));
      }
    }
  }
  return TextSpan(children: spanList);
}
