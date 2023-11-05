import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "hello": "Hello",
          "meassge": "Welcome",
          "app_title": "Language Selection",
          "select_language": "Select Language",
          "Change Language": "Change Language",
          "english": "English",
          "hindi": "Hindi",
          "marathi": "Marathi"
        },
        'hi_IN': {
          "hello": "नमस्ते",
          "message": "आपका स्वागत है",
          "app_title": "भाषा चयन",
          "select_language": "भाषा चुनें",
          "Change Language": "भाषा बदलें",
          "english": "अंग्रेज़ी",
          "hindi": "हिंदी",
          "marathi": "मराठी"
        },
        'mr_IN': {
          "hello": "नमस्कार",
          "message": "आपले स्वागत आहे",
          "app_title": "भाषा निवडणी",
          "select_language": "भाषा निवडा",
          "Change Language": "भाषा बदला",
          "english": "इंग्रजी",
          "hindi": "हिंदी",
          "marathi": "मराठी"
        },
      };
}
