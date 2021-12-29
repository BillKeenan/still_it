// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:distillers_calculator/classes/specific_gravity.dart';
import 'package:distillers_calculator/util/maths.dart';
import 'package:distillers_calculator/classes/table6.dart';
import 'package:test/test.dart';

void main() {
  test('Volume (bottle) Test', () {
    var answer = Table6.volume(500, 80, 40);
    expect(answer.VolumeOfSourceToAdd, 245);
    expect(answer.VolumeOfWaterToAdd, 255);
  });

  test('Dillution Test', () {
    var answer = Table6.dillution(1, 80, 40);
    expect(answer.VolumeOfWaterToAdd, 1.04);
  });

  test('Dillution Test2', () {
    var answer = Table6.dillution(100, 95.5, 94);
    expect(answer.VolumeOfWaterToAdd, 1.84);
  });

  test('Sugar Wash Test', () {
    var answer = Maths.sugarWash(5, 20);
    expect(answer, [1.096, 16.92, 14.7]);
  });

  test('abv from sg', () {
    var answer =
        Maths.abvFromSg(SpecificGravity(1.050), SpecificGravity(1.010));

    expect(answer, 5.25);
  });

  test('table 6 test', () {
    var answer = Table6.getVals(80);
    expect(answer.Alcohol, 40);
  });

  test('temp Adjust test', () {
    var answer = Maths.sgTempAdjust(SpecificGravity(1.02), 10);
    expect(Maths.roundToXDecimals(answer.sg, 4), 1.0185);
  });
}
