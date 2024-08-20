class ProfileUtils {
  ProfileUtils._();

  static String getUsername(String input) {
    return input.contains('://') ? Uri.parse(input).pathSegments.last : input;
  }
}