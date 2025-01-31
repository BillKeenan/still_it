class VolumeResult extends BaseResult {
  num volumeOfWaterToAdd;
  num volumeOfSourceToAdd;

  VolumeResult(this.volumeOfSourceToAdd, this.volumeOfWaterToAdd);
}

class DilutionResult extends BaseResult {
  double volumeOfWaterToAdd;
  DilutionResult(this.volumeOfWaterToAdd);
}

class BaseResult {
  String errorResult = "";
  int resultCode = 200;
}
