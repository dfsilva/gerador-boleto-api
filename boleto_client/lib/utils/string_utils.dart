class StringUtils {
  static final Map<String, RegExp> _translator = {
    'A': new RegExp(r'[A-Za-z]'),
    '0': new RegExp(r'[0-9]'),
    '@': new RegExp(r'[A-Za-z0-9]'),
    '*': new RegExp(r'.*')
  };

  static String removeSpecial(String string) => string.replaceAll(new RegExp(r'[^\w]+'), '');

  static bool isBlank(String value) {
    return value == null || value.isEmpty || value.trim().isEmpty;
  }

  // static String maskText(String mask, String value) {
  //   String result = '';
  //   var maskCharIndex = 0;
  //   var valueCharIndex = 0;
  //
  //   while (true) {
  //     if (maskCharIndex == mask.length) {
  //       break;
  //     }
  //
  //     if (valueCharIndex == value.length) {
  //       break;
  //     }
  //
  //     var maskChar = mask[maskCharIndex];
  //     var valueChar = value[valueCharIndex];
  //
  //     if (maskChar == valueChar) {
  //       result += maskChar;
  //       valueCharIndex += 1;
  //       maskCharIndex += 1;
  //       continue;
  //     }
  //
  //     if (_translator.containsKey(maskChar)) {
  //       if (_translator[maskChar].hasMatch(valueChar)) {
  //         result += valueChar;
  //         maskCharIndex += 1;
  //       }
  //
  //       valueCharIndex += 1;
  //       continue;
  //     }
  //
  //     result += maskChar;
  //     maskCharIndex += 1;
  //     continue;
  //   }
  //
  //   return result;
  // }

  static int toNumber(String str) =>
      str != null ? str.codeUnits.fold(0, (previousValue, element) => previousValue + element) : 0;
}
