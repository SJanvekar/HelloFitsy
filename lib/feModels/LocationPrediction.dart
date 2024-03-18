class Prediction {
  final String description;
  final String placeId; // Adding placeId field
  late double lat;
  late double long;

  Prediction({required this.description, required this.placeId});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'],
      placeId: json['place_id'], // Assigning placeId from JSON
    );
  }
}

class AddressLatLong {
  double? lat;
  double? long;

  AddressLatLong({required this.lat, required this.long});

  factory AddressLatLong.fromJsonLatLong(Map<String, dynamic> json) {
    double? latitude;
    double? longitude;

    if (json['results'][0]['geometry'] != null &&
        json['results'][0]['geometry']['location'] != null) {
      latitude = json['results'][0]['geometry']['location']['lat'];
      longitude = json['results'][0]['geometry']['location']['lng'];
    } else {}
    return AddressLatLong(lat: latitude, long: longitude);
  }
}
