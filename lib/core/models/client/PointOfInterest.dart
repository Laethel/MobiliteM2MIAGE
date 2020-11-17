
class PointOfInterest {

  String id;
  String name;
  double latitude;
  double longitude;
  String theme;
  String subTheme;

  PointOfInterest({this.id, this.name, this.latitude, this.longitude, this.theme, this.subTheme});

  PointOfInterest.fromMap(Map snapshot) :
    id = snapshot['id'] ?? '',
    name = snapshot['name'] ?? '',
    latitude = snapshot['latitude'] ?? '',
    longitude = snapshot['longitude'] ?? '',
    theme = snapshot['theme'] ?? '',
    subTheme = snapshot['subTheme'] ?? '';

  toJson() {

    return {
      "id": id,
      "name": name,
      "latitude": latitude,
      "longitude": longitude,
      "theme": theme,
      "subTheme": subTheme
    };
  }
}