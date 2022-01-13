// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:distillers_calculator/model/specific_gravity.dart';
import 'package:distillers_calculator/util/maths.dart';
import 'package:distillers_calculator/classes/table6.dart';
import 'package:test/test.dart';

void main() {
  test('Volume (bottle) Test', () {
    var answer = Table6.volume(1000, 80, 40);
    expect(answer.volumeOfSourceToAdd, 500.0000000000001);
    expect(answer.volumeOfWaterToAdd, 518.9641799999999);
  });

  test('Volume (bottle) Test2', () {
    var answer = Table6.volume(500, 80, 40);
    expect(answer.volumeOfSourceToAdd, 250.00000000000006);
    expect(answer.volumeOfWaterToAdd, 259.48208999999997);
  });

  test('Dilution Test', () {
    var answer = Table6.dilution(1, 80, 40);
    expect(answer.volumeOfWaterToAdd, 1.04);
  });

  test('Dilution Test2', () {
    var answer = Table6.dilution(100, 95.5, 94);
    expect(answer.volumeOfWaterToAdd, 1.84);
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
    expect(answer.alcohol, 40);
  });

  test('temp Adjust test', () {
    var answer = Maths.sgTempAdjust(SpecificGravity(1.02), 10, 20);
    expect(Maths.roundToXDecimals(answer.sg, 4), 1.0185);
  });

  test('liqueur test', () {
    var water = 750;
    var source = 500;
    var sourceABV = 95;
    var sugar = 150;

    var answer = Maths.liqueur(water, source, sourceABV, sugar);
    expect(Maths.roundToXDecimals(answer, 4), 35.3333);
  });
}
