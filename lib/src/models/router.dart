class RouterModel {
  final String mac;
  final String model;
  final String brand;
  final String friendlyName;
  final int type;
  final int acs;
  final int physicalModel;
  final bool hasWifiOptimizedForPlume;

  RouterModel({
    required this.mac,
    required this.model,
    required this.brand,
    required this.friendlyName,
    required this.type,
    required this.acs,
    required this.physicalModel,
    required this.hasWifiOptimizedForPlume,
  });

  factory RouterModel.fromJson(Map<String, dynamic> json) {
    return RouterModel(
      mac: json['Mac'],
      model: json['Model'],
      brand: json['Brand'],
      friendlyName: json['FriendlyName'],
      type: json['Type'],
      acs: json['Acs'],
      physicalModel: json['PhysicalModel'],
      hasWifiOptimizedForPlume: json['HasWifiOptimizedForPlume'],
    );
  }
}
