class PlaceSearchResult {
  SearchMetadata? searchMetadata;
  int? totalResults;
  List<PlaceResult>? results;

  PlaceSearchResult({this.searchMetadata, this.totalResults, this.results});

  PlaceSearchResult.fromJson(Map<String, dynamic> json) {
    searchMetadata = json['searchMetadata'] != null
        ? SearchMetadata.fromJson(json['searchMetadata'])
        : null;
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = <PlaceResult>[];
      json['results'].forEach((v) {
        results!.add(PlaceResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (searchMetadata != null) {
      data['searchMetadata'] = searchMetadata!.toJson();
    }
    data['totalResults'] = totalResults;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchMetadata {
  String? centerLocation;
  int? mainSearchRadius;
  String? locationName;
  int? gridSearchRadius;
  String? placeType;
  int? totalPoints;
  int? pointsSearched;

  SearchMetadata(
      {this.centerLocation,
        this.mainSearchRadius,
        this.locationName,
        this.gridSearchRadius,
        this.placeType,
        this.totalPoints,
        this.pointsSearched});

  SearchMetadata.fromJson(Map<String, dynamic> json) {
    centerLocation = json['centerLocation'];
    mainSearchRadius = json['mainSearchRadius'];
    locationName = json['locationName'];
    gridSearchRadius = json['gridSearchRadius'];
    placeType = json['placeType'];
    totalPoints = json['totalPoints'];
    pointsSearched = json['pointsSearched'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['centerLocation'] = centerLocation;
    data['mainSearchRadius'] = mainSearchRadius;
    data['locationName'] = locationName;
    data['gridSearchRadius'] = gridSearchRadius;
    data['placeType'] = placeType;
    data['totalPoints'] = totalPoints;
    data['pointsSearched'] = pointsSearched;
    return data;
  }
}

class PlaceResult {
  String? name;
  String? placeId;
  String? address;
  GeoLocation? location;
  double? rating;
  List<String>? types;
  String? businessStatus;
  List<int>? foundByPointIds;
  double? locationLat;
  double? locationLng;
  int? foundInSearchPoints;

  PlaceResult(
      {this.name,
        this.placeId,
        this.address,
        this.location,
        this.rating,
        this.types,
        this.businessStatus,
        this.foundByPointIds,
        this.locationLat,
        this.locationLng,
        this.foundInSearchPoints});

  PlaceResult.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['place_id'];
    address = json['address'];
    location = json['location'] != null
        ? GeoLocation.fromJson(json['location'])
        : null;
    rating = json['rating'] != null ? (json['rating'] as num).toDouble() : null;
    types = json['types']?.cast<String>();
    businessStatus = json['business_status'];
    foundByPointIds = json['foundByPointIds']?.cast<int>();
    locationLat = json['location_lat'] != null ? (json['location_lat'] as num).toDouble() : null;
    locationLng = json['location_lng'] != null ? (json['location_lng'] as num).toDouble() : null;
    foundInSearchPoints = json['foundInSearchPoints'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['place_id'] = placeId;
    data['address'] = address;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['rating'] = rating;
    data['types'] = types;
    data['business_status'] = businessStatus;
    data['foundByPointIds'] = foundByPointIds;
    data['location_lat'] = locationLat;
    data['location_lng'] = locationLng;
    data['foundInSearchPoints'] = foundInSearchPoints;
    return data;
  }
}

class GeoLocation {
  double? lat;
  double? lng;

  GeoLocation({this.lat, this.lng});

  GeoLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
