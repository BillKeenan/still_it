import 'dart:math';
import 'dart:developer' as dev;

import 'package:distillers_calculator/model/specific_gravity.dart';
import 'package:distillers_calculator/util/math_results.dart';
import 'package:sprintf/sprintf.dart';

class Maths {
  static num dropMoreThan2Decimals(input) {
    return (input * 100).toInt() / 100;
  }

  static double roundTo2Decimals(num input) {
    return roundToXDecimals(input, 2);
  }

  static roundToXDecimals(num input, int i) {
    return double.parse(input.toStringAsFixed(i));
  }

  static List volume(
      int makeHowMuch, int fromWhatPercentage, int toWhatPercentage) {
    var sourceSpirit = (makeHowMuch /
            ((fromWhatPercentage / toWhatPercentage) * makeHowMuch)) *
        makeHowMuch;

    return [sourceSpirit.round(), (makeHowMuch - sourceSpirit).round()];
  }

  static DilutionResult dilution(int volume, int startingABV, int desiredABV) {
    //v2 = (c1 * v1) / c2

    var v2 = (volume * startingABV) / desiredABV;

    var addWater = v2 - volume;

    return DilutionResult(addWater);
  }

  static abvFromSg(SpecificGravity start, SpecificGravity end) {
    //v2 = (c1 * v1) / c2

    var abv = (start.sg - end.sg) * 131.25;

    dev.log(
        sprintf('abvFromSg:Converted %s and %s to %s', [start.sg, end.sg, abv]),
        name: 'bigmojo.net.debug');

    return abv;
  }

  static sugarWash(num sugarKG, num litres) {
    var sg = num.tryParse((((258.6 + (87.96 * sugarKG / litres)) +
                sqrt(66874 +
                    (7736.96 * sugarKG * sugarKG / (litres * litres)) +
                    (57947 * sugarKG / litres))) /
            517.2 *
            1000 /
            1000)
        .toStringAsFixed(3));

    var waterNeeded = num.tryParse(
        ((((litres * sg!) - sugarKG) * 100) / 100).toStringAsFixed(3));

// sc.at.value=Math.round(sc.a.value*sc.weight.value*1000/17/(sc.b.value*sc.amount.value)*10)/10;
    var abv = num.tryParse(
        ((sugarKG * 1000) / 17 / litres * 10 / 10).toStringAsFixed(1));

    return [sg, waterNeeded, abv];
  }

  static double celciusToFarenheight(num celcius) {
    var f = celcius * (9 / 5) + 32;

    dev.log(sprintf('celciusToFarenheight:Converted %s to %s', [celcius, f]),
        name: 'bigmojo.net.debug');

    return f;
  }

  static fToC(num f) {
    //°F =°C * 1.8000 + 32.00
    //°C =(°F - 32) / 1.8000
    var c = (f - 32) / 1.8;
    return c;
  }

  static cToF(num c) {
    //°F =°C * 1.8000 + 32.00
    //°C =(°F - 32) / 1.8000
    var f = c * 1.8 + 32;
    return f;
  }

  static SpecificGravity sgTempAdjust(
      SpecificGravity sg, num temperatureCelcius, num calibrationTempC) {
    //cg = mg * ((1.00130346 - 0.000134722124 * tr + 0.00000204052596 * tr2 - 0.00000000232820948 * tr3) / (1.00130346 - 0.000134722124 * tc + 0.00000204052596 * tc2 - 0.00000000232820948 * tc3))

    var f = celciusToFarenheight(temperatureCelcius);
    var calib = celciusToFarenheight(calibrationTempC);

    //calibration temp (in f)

    var cg = sg.sg *
        ((1.00130346 -
                0.000134722124 * f +
                0.00000204052596 * pow(f, 2) -
                0.00000000232820948 * pow(f, 3)) /
            (1.00130346 -
                0.000134722124 * calib +
                0.00000204052596 * pow(calib, 2) -
                0.00000000232820948 * pow(calib, 3)));

    dev.log(
        sprintf('sgTempAdjust:Converted %s at %s to %s',
            [sg.sg, temperatureCelcius, cg]),
        name: 'bigmojo.net.debug');

    return SpecificGravity(cg);
  }

  static liqueur(int water, int source, int sourceABV, int sugar) {
    //transform sugar to ml
    var sugarML = sugar / 1.59;

    var totalVolum3 = water + source + sugarML;
    var alcVOl = source * sourceABV;

    var finalABV = alcVOl / totalVolum3;

    return finalABV;
  }
}
