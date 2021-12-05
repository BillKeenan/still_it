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
}
