class RideModel {
  String? locationAddress;
  String? destinationAddress;
  String? time;
  String? clientName;
  String? clientImageUrl;
  double? ridePrice;
  String? driverUID;
  String? paymentMethod;
  RideModel(
      {this.locationAddress,
      this.destinationAddress,
      this.time,
      this.clientName,
      this.clientImageUrl,
      this.ridePrice,
      this.driverUID,
      this.paymentMethod});
}
