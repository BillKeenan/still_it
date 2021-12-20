class VolumeResult extends BaseResult {
  num VolumeOfWaterToAdd;
  num VolumeOfSourceToAdd;

  VolumeResult(this.VolumeOfSourceToAdd, this.VolumeOfWaterToAdd);
}

class DilutionResult extends BaseResult {
  double VolumeOfWaterToAdd;
  DilutionResult(this.VolumeOfWaterToAdd);
}

class BaseResult {
  String ErrorResult = "";
  int ResultCode = 200;
}
