import 'package:flutter/material.dart';
import 'package:jtdetector/jtdetector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JText Detector Example',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const JTextDetectorExample(),
    );
  }
}

const List<String> TEXT_EXAMPLE = [
  "السلام [@عليكم:12345678] #how @حالكم [@friends:1234568] 150",
  "00. This  a url: https://jucodes.com email address: info@jucodes.com an #hashtag @user tag +967772445395",
  "01. This  a url: https://flutter.dev",
  "02. This email address example@jucodes.com",
  "03. This  #hashtag #هاشتاغ",
  "04. This @user tag",
  "05. This  phone number +967772445395",
  "06. This text Arabic: وعليكم السلام ورحمة الله Is Nothing وبركاته كيف الحال",
  "08. 772445395",
  "07. website  https://jucodes.com/en  web: www.jucodes.com,  facebook.com,  link http://jucodes.com/method?id=hello.com, hashtag #trending & userTag @dev.user +12345678901",
];

List<DetectorOptions> detectorOptionsList = [
  DetectorOptions(
      type: "PHONE",
      pattern: PHONE_REGEXP,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 24,
      ),
      onTap: (url) {
        //launch("tel:" + url);
        debugPrint("tel:${url.value}");
      }),
  DetectorOptions(
    pattern: URL_REGEXP,
    type: URL_REGEXP_TYPE,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.brown,
    ),
    onTap: (value) {
      debugPrint("${value.detectType}:${value.value}:${value.regExp.pattern}");
    },
  ),
  DetectorOptions(
    pattern: EMAIL_REGEXP,
    type: EMAIL_REGEXP_TYPE,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    ),
    onTap: (value) {
      debugPrint("${value.detectType}:${value.value}:${value.regExp.pattern}");
    },
  ),
  DetectorOptions(
    pattern: HASHTAG_REGEXP,
    type: HASHTAG_REGEXP_TYPE,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    ),
    onTap: (value) {
      debugPrint("${value.detectType}:${value.value}:${value.regExp.pattern}");
    },
  ),
  DetectorOptions(
    pattern: USER_TAG_REGEXP,
    type: USER_TAG_REGEXP_TYPE,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    onTap: (value) {
      debugPrint("${value.detectType}:${value.value}:${value.regExp.pattern}");
    },
  ),
  DetectorOptions(
    pattern: USER_TAG_WITH_ID,
    type: USER_ID_TAG_REGEXP_TYPE,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.purpleAccent,
    ),
    onTap: (value) {
      debugPrint("${value.detectType}:${value.value}:${value.regExp.pattern}");
    },
    parsingValue: (value) {
      RegExp customRegExp = RegExp(r'''[a-zA-Z\u0600-\u06FF]+''');
      Match? match = customRegExp.firstMatch(value.value);
      DetectedValue val = value;
      if (match != null) {
        var ma = match[0].toString();
        val = DetectedValue(customRegExp, ma, "NoD");
      }
      debugPrint("${value.detectType}:${value.value}:${value.regExp.pattern}");
      debugPrint("${val.detectType}:${val.value}:${val.regExp.pattern}");
      return val;
    },
    valueWidget: (value) {
      return Container(
        color: Colors.blue,
        child: Text(
          value.value,
          style: const TextStyle(color: Colors.white),
        ),
      );
    },
  ),
];

class JTextDetectorExample extends StatefulWidget {
  const JTextDetectorExample({Key? key}) : super(key: key);

  @override
  State<JTextDetectorExample> createState() => _JTextDetectorExampleState();
}

class _JTextDetectorExampleState extends State<JTextDetectorExample> {
  TextEditingController controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JustTextDetectorWidget"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              JTextFieldDetector(
                controller: controller,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                clipBehavior: Clip.hardEdge,
                detectorOptions: detectorOptionsList,
                isTapValid: false,
                maxLines: 15,
              ),
              for (int i = 0; i < TEXT_EXAMPLE.length; i++)
                JTextDetector(
                  text: TEXT_EXAMPLE[i],
                  selectable: TEXT_EXAMPLE[i].startsWith("07"),
                  detectorOptions: detectorOptionsList,
                ),
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        onPressed: () {
          final value = detectFromText(TEXT_STRING, defaultDetectorOptionsList);
          for (var i in value) {
            debugPrint("${i.detectType}:${i.value}:${i.regExp.pattern}");
          }
        },
        child: const Icon(Icons.sync),
      ),
    );
  }
}

const String TEXT_STRING =
    "السلام [@عليكم:12345678] #how @حالكم [@friends:1234568] ..0"
    "00. This  a url: https://flutter.dev email address: info@jucodes.com an #hashtag @user tag "
    "01. This  a url: https://flutter.dev"
    "02. This email address example@app.com"
    "03. This  #hashtag #هاشتاغ"
    "04. This @user tag"
    "05. This  phone number: (967) 77244 5395"
    "06. This text Arabic: وعليكم السلام ورحمة الله Is Nothing وبركاته كيف الحال"
    "07. website url: https://jucodes.com/en  web: www.jucodes.com, social facebook.com, additional link http://jucodes.com/method?id=hello.com, hashtag #trending & mention @dev.user +123456789";
