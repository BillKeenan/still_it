// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:still_it/util/maths.dart';
import 'package:test/test.dart';

void main() {
  test('Volume Test', () {
    var answer = Maths.volume(200, 55, 40);

    expect(answer, [145, 55]);
  });

  test('Dillution Test', () {
    var answer = Maths.dillution(1000, 55, 40);
    expect(answer, 375);
  });

  test('Sugar Wash Test', () {
    var answer = Maths.sugarWash(5, 20);
    expect(answer, [1.096, 16.92, 14.7]);
  });

  test('abv from sg', () {
    var answer = Maths.abvFromSg(1.050, 1.010);

    expect(answer, 5.25);
  });
}
