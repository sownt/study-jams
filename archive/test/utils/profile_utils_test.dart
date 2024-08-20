import 'package:android_studyjams/utils/profile_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get username', () {
    expect(
      ProfileUtils.getUsername('username'),
      'username',
    );
    expect(
      ProfileUtils.getUsername('https://g.dev/username'),
      'username',
    );
    expect(
      ProfileUtils.getUsername('https://g.dev/username?parameter=value'),
      'username',
    );
    expect(
      ProfileUtils.getUsername('http://g.dev/username'),
      'username',
    );
    expect(
      ProfileUtils.getUsername(
          'https://developers.google.com/profile/u/username'),
      'username',
    );
    expect(
      ProfileUtils.getUsername(
          'https://developers.google.com/profile/u/username?parameter=value'),
      'username',
    );
    expect(
      ProfileUtils.getUsername(
          'http://developers.google.com/profile/u/username'),
      'username',
    );
  });
}
