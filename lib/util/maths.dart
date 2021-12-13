import 'dart:math';

class Maths {
  static List volume(
      int makeHowMuch, int fromWhatPercentage, int toWhatPercentage) {
    var sourceSpirit = (makeHowMuch /
            ((fromWhatPercentage / toWhatPercentage) * makeHowMuch)) *
        makeHowMuch;

    return [sourceSpirit.round(), (makeHowMuch - sourceSpirit).round()];
  }

  static dillution(int volume, int startingABV, int desiredABV) {
    //v2 = (c1 * v1) / c2

    var v2 = (volume * startingABV) / desiredABV;

    var addWater = v2 - volume;

    return addWater;
  }

  static abvFromSg(num start, num end) {
    //v2 = (c1 * v1) / c2

    var abv = num.tryParse(((start - end) * 131.25).toStringAsFixed(2));

    return abv;
  }

  static sugarWash(int sugarKG, int litres) {
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
}
