import 'package:distillers_calculator/util/maths.dart';
import 'package:sprintf/sprintf.dart';
import 'dart:core';
import 'dart:developer' as dev;
import '../util/math_results.dart';

class Table6 {
  ///Proof,Water,alcohol,SG in air
  // var data = HashMap<int, List>();

  ///implemented as per
  ///https://www.law.cornell.edu/cfr/text/27/30.66
  ///Example.
// It is desired to reduce spirits of 191 proof to 188 proof. We find that 191 proof spirits contains 95.5 parts alcohol and 5.59 parts water, and 188 proof spirits contains 94.0 parts alcohol and 7.36 parts water.
// 95.5 (the strength of 100 wine gallons of spirits at 191 proof) divided by 94.0 (the strength of 100 wine gallons of spirits at 188 proof) equals 1.01.
// 7.36 (the water in 188 proof) multiplied by 1.01 equals 7.43.
// 7.43 less 5.59 (the water in 191 proof spirits) equal 1.84 gallons of water to be added to each 100 wine gallons of 191 proof spirits to be reduced.
  static DilutionResult dilution(num volume, num sourceABV, num desiredABV) {
    //v2 = (c1 * v1) / c2

    //get proof

    var sourceData = Table6.getVals((sourceABV * 2).toInt());
    var desiredData = Table6.getVals((desiredABV * 2).toInt());

    var ratio =
        Maths.dropMoreThan2Decimals(sourceData.Alcohol / desiredData.Alcohol);

    var desiredWater = Maths.dropMoreThan2Decimals(desiredData.Water * ratio);

    var waterDiff = Maths.roundTo2Decimals(desiredWater - sourceData.Water);

    //the forumla is per/100 units
    double waterToAdd = Maths.roundTo2Decimals((waterDiff * volume) / 100);

    return DilutionResult(waterToAdd);
  }

  static VolumeResult volume(int volumeML, int sourceABV, int desiredABV) {
    /*
SG is the density relative to water. So something with the same density than water has a SG of 1.
Density is the absolute density in kg/lt. Water has a density of 0.9982 kg/lt at 20°C.
So if something has SG of 0.9, it has a density of 0.9 x 0.9982 = 0.898 kg/lt

---
40%abv is SG 0.95. So the density is sg*waterDesnsity = 0.948kg/lt.

The abw is 40 x densitypureethanol / 0.948 = 33.3

So you want 948g 33.3%abw.

This is 948 x 33.3% = 316g ethanol, and 632g water.

80%abv is SG 0.861. So the density is 0.859kg/lt.
The abw is 80 x densitypureethanol / 0.859 = 73.5

For 316g ethanol you need 316 / 73.5% = 430g 80%abv. 
This includes 430 x 26.5% = 114g water.
So for total 632g water you have to add 632 - 114 = 518g water, what is 519ml.
And 430g 80%abv is 430 / 0.859 = 501ml.

*/
    var waterDensity = .9982;
    var pureEthDensity = .789;

    var endingSG = getVals(desiredABV * 2);

    //40%abv is SG 0.95. So the density is sg*waterDesnsity = 0.948kg/lt.
    var endingDensity = endingSG.AlcoholSG * waterDensity;

    //The abw is 40 x densitypureethanol / 0.948 = 33.3
    var endingABW = (desiredABV * pureEthDensity) / endingDensity;

    //So you want 948g 33.3%abw.
    //This is 948 x 33.3% = 316g ethanol, and 632g water.
    var eth = endingDensity * (endingABW / 100);
    var water = endingDensity - eth;

    dev.log(
        sprintf('Table.6VolumeResult:So you want %sg eth and %s water.',
            [eth, water]),
        name: 'bigmojo.net.debug');

    //80%abv is SG 0.861. So the density is 0.859kg/lt.
    var sourceSG = getVals(sourceABV * 2);
    var sourceDensity = sourceSG.AlcoholSG * waterDensity;

    //The abw is 80 x densitypureethanol / 0.859 = 73.5
    var sourceABW = (sourceABV * pureEthDensity) / sourceDensity;

    //For 316g ethanol you need 316 / 73.5% = 430g 80%abv.
    //This includes 430 x 26.5% = 114g water.
    var howMuchSource = eth / (sourceABW / 100);
    var includesThisWater = howMuchSource * ((100 - sourceABW) / 100);

    //So for total 632g water you have to add 632 - 114 = 518g water, what is 519ml.
    var thisMuchWater = water - includesThisWater;

    //And 430g 80%abv is 430 / 0.859 = 501ml.
    var thisMuchSource = howMuchSource / sourceDensity;

    //So 501ml 80%abv and 519ml water sum up to 1lt 40%abv.

    return VolumeResult(thisMuchSource * 1000, thisMuchWater * 1000);
  }

  static Map<num, List<num>> data = {
    1: [0.5, 99.53, 0.99925],
    2: [1, 99.06, 0.9985],
    3: [1.5, 98.58, 0.99776],
    4: [2, 98.12, 0.99703],
    5: [2.5, 97.65, 0.9963],
    6: [3, 97.18, 0.99559],
    7: [3.5, 96.71, 0.99487],
    8: [4, 96.24, 0.99418],
    9: [4.5, 95.78, 0.99349],
    10: [5, 95.31, 0.99281],
    11: [5.5, 94.85, 0.99214],
    12: [6, 94.3, 0.99149],
    13: [6.5, 93.93, 0.99084],
    14: [7, 93.46, 0.99021],
    15: [7.5, 93.01, 0.98959],
    16: [8, 92.55, 0.98898],
    17: [8.5, 92.09, 0.98837],
    18: [9, 91.63, 0.98778],
    19: [9.5, 91.18, 0.98719],
    20: [10, 90.72, 0.9866],
    21: [10.5, 90.27, 0.98601],
    22: [11, 89.81, 0.98543],
    23: [11.5, 89.36, 0.98485],
    24: [12, 88.9, 0.98428],
    25: [12.5, 88.45, 0.98372],
    26: [13, 88, 0.98317],
    27: [13.5, 87.55, 0.98262],
    28: [14, 87.1, 0.98208],
    29: [14.5, 86.65, 0.98155],
    30: [15, 86.2, 0.98102],
    31: [15.5, 85.75, 0.98049],
    32: [16, 85.3, 0.97996],
    33: [16.5, 84.85, 0.97944],
    34: [17, 84.4, 0.97893],
    35: [17.5, 83.95, 0.97842],
    36: [18, 83.5, 0.97792],
    37: [18.5, 83.06, 0.97742],
    38: [19, 82.61, 0.97692],
    39: [19.5, 82.16, 0.97643],
    40: [20, 81.72, 0.97594],
    41: [20.5, 81.27, 0.97544],
    42: [21, 80.82, 0.97492],
    43: [21.5, 80.38, 0.97442],
    44: [22, 79.93, 0.97391],
    45: [22.5, 79.48, 0.9734],
    46: [23, 79.03, 0.97289],
    47: [23.5, 78.58, 0.97237],
    48: [24, 78.14, 0.97185],
    49: [24.5, 77.69, 0.97133],
    50: [25, 77.24, 0.9708],
    51: [25.5, 76.79, 0.97027],
    52: [26, 76.34, 0.96974],
    53: [26.5, 75.89, 0.9692],
    54: [27, 75.44, 0.96866],
    55: [27.5, 74.98, 0.96811],
    56: [28, 74.53, 0.96756],
    57: [28.5, 74.08, 0.967],
    58: [29, 73.62, 0.96644],
    59: [29.5, 73.17, 0.96587],
    60: [30, 72.72, 0.9653],
    61: [30.5, 72.26, 0.96471],
    62: [31, 71.81, 0.96413],
    63: [31.5, 71.35, 0.96353],
    64: [32, 70.89, 0.06291],
    65: [32.5, 70.43, 0.96229],
    66: [33, 69.97, 0.96165],
    67: [33.5, 69.51, 0.96101],
    68: [34, 69.05, 0.96036],
    69: [34.5, 68.59, 0.9597],
    70: [35, 68.12, 0.95903],
    71: [35.5, 67.66, 0.95835],
    72: [36, 67.19, 0.95765],
    73: [36.5, 66.72, 0.95695],
    74: [37, 66.25, 0.95623],
    75: [37.5, 65.78, 0.95551],
    76: [38, 65.31, 0.95476],
    77: [38.5, 64.84, 0.95402],
    78: [39, 64.37, 0.95326],
    79: [39.5, 63.9, 0.9525],
    80: [40, 63.42, 0.95172],
    81: [40.5, 62.95, 0.95094],
    82: [41, 62.47, 0.95014],
    83: [41.5, 61.99, 0.94934],
    84: [42, 61.52, 0.94852],
    85: [42.5, 61.04, 0.9477],
    86: [43, 60.56, 0.94687],
    87: [43.5, 60.08, 0.94603],
    88: [44, 59.59, 0.94518],
    89: [44.5, 59.11, 0.94431],
    90: [45, 58.63, 0.94344],
    91: [45.5, 58.14, 0.94256],
    92: [46, 57.66, 0.94167],
    93: [46.5, 57.17, 0.94077],
    94: [47, 56.68, 0.93988],
    95: [47.5, 56.19, 0.93894],
    96: [48, 55.7, 0.93801],
    97: [48.5, 55.21, 0.93707],
    98: [49, 54.72, 0.93612],
    99: [49.5, 54.22, 0.93516],
    100: [50, 53.73, 0.93418],
    101: [50.5, 53.24, 0.9332],
    102: [51, 52.74, 0.93222],
    103: [51.5, 52.25, 0.93123],
    104: [52, 51.75, 0.93023],
    105: [52.5, 51.25, 0.92923],
    106: [53, 50.75, 0.92822],
    107: [53.5, 50.26, 0.9272],
    108: [54, 49.76, 0.92618],
    109: [54.5, 49.26, 0.92515],
    110: [55, 48.76, 0.92409],
    111: [55.5, 48.25, 0.92305],
    112: [56, 47.75, 0.922],
    113: [56.5, 47.25, 0.92095],
    114: [57, 46.75, 0.91989],
    115: [57.5, 46.24, 0.91882],
    116: [58, 45.74, 0.91774],
    117: [58.5, 45.23, 0.91665],
    118: [59, 44.72, 0.91555],
    119: [59.5, 44.22, 0.91444],
    120: [60, 43.71, 0.91333],
    121: [60.5, 43.2, 0.91221],
    122: [61, 42.69, 0.91109],
    123: [61.5, 42.18, 0.90996],
    124: [62, 41.67, 0.90882],
    125: [62.5, 41.16, 0.90768],
    126: [63, 40.65, 0.90653],
    127: [63.5, 40.14, 0.90538],
    128: [64, 39.62, 0.90422],
    129: [64.5, 39.11, 0.90306],
    130: [65, 38.6, 0.9019],
    131: [65.5, 38.08, 0.90073],
    132: [66, 37.57, 0.89955],
    133: [66.5, 37.05, 0.89836],
    134: [67, 36.54, 0.89717],
    135: [67.5, 36.02, 0.89597],
    136: [68, 35.5, 0.89476],
    137: [68.5, 34.99, 0.89355],
    138: [69, 34.47, 0.89232],
    139: [69.5, 33.95, 0.89109],
    140: [70, 33.43, 0.88986],
    141: [70.5, 32.91, 0.88862],
    142: [71, 32.38, 0.88738],
    143: [71.5, 31.88, 0.88612],
    144: [72, 31.34, 0.88485],
    145: [72.5, 30.82, 0.88358],
    146: [73, 30.29, 0.8823],
    147: [73.5, 29.76, 0.88102],
    148: [74, 29.24, 0.87973],
    149: [74.5, 28.71, 0.87844],
    150: [75, 28.19, 0.87714],
    151: [75.5, 27.66, 0.87583],
    152: [76, 27.13, 0.8745],
    153: [76.5, 26.6, 0.87317],
    154: [77, 26.07, 0.87184],
    155: [77.5, 25.54, 0.8705],
    156: [78, 25.01, 0.86914],
    157: [78.5, 24.47, 0.86778],
    158: [79, 23.94, 0.86641],
    159: [79.5, 23.4, 0.86503],
    160: [80, 22.87, 0.86364],
    161: [80.5, 22.33, 0.86225],
    162: [81, 21.8, 0.86084],
    163: [81.5, 21.26, 0.85943],
    164: [82, 20.72, 0.85801],
    165: [82.5, 20.18, 0.85658],
    166: [83, 19.64, 0.85515],
    167: [83.5, 19.1, 0.85369],
    168: [84, 18.55, 0.85223],
    169: [84.5, 18.01, 0.85076],
    170: [85, 17.46, 0.84927],
    171: [85.5, 16.92, 0.84777],
    172: [86, 16.37, 0.84625],
    173: [86.5, 15.82, 0.84471],
    174: [87, 15.27, 0.84317],
    175: [87.5, 14.72, 0.84162],
    176: [88, 14.16, 0.84006],
    177: [88.5, 13.61, 0.83848],
    178: [89, 13.05, 0.83688],
    179: [89.5, 12.49, 0.83526],
    180: [90, 11.93, 0.83362],
    181: [90.5, 11.37, 0.83196],
    182: [91, 10.8, 0.83029],
    183: [91.5, 10.24, 0.82859],
    184: [92, 9.67, 0.82685],
    185: [92.5, 9.09, 0.82509],
    186: [93, 8.52, 0.8233],
    187: [93.5, 7.94, 0.82149],
    188: [94, 7.36, 0.81963],
    189: [94.5, 6.77, 0.81775],
    190: [95, 6.18, 0.81582],
    191: [95.5, 5.59, 0.81385],
    192: [96, 4.99, 0.81184],
    193: [96.5, 4.39, 0.80979],
    194: [97, 3.78, 0.8077],
    195: [97.5, 3.17, 0.80555],
    196: [98, 2.55, 0.80333],
    197: [98.5, 1.93, 0.80104],
    198: [99, 1.29, 0.79866],
    199: [99.5, 0.65, 0.7962],
    200: [100, 0, 0.79365]
  };

  static Table6Result getVals(int proof) {
    if (data[proof] == null) {
      throw ArgumentError("invalid proof");
    }

    var dataList = data[proof];
    var returnResult =
        Table6Result(proof, dataList![0], dataList[1], dataList[2]);

    return returnResult;
  }
}

class Table6Result {
  int Proof;
  num Water;
  num Alcohol;
  num AlcoholSG;

  Table6Result(this.Proof, this.Alcohol, this.Water, this.AlcoholSG);

  @override
  String toString() {
    return sprintf("Table6 Result: Water: %s, Alcohol %s, AlcoholSG %s",
        [Water, Alcohol, AlcoholSG]);
  }
}
