class StringUtils {
  static String exceededLength8(String text) {
    return text.length >= 8 ? "${text.substring(0, 7)}..." : text;
  }

  static String exceededLength12(String text) {
    return text.length >= 12 ? "${text.substring(0, 11)}..." : text;
  }

  static String exceededLength18(String text) {
    return text.length >= 18 ? "${text.substring(0, 17)}..." : text;
  }
}
