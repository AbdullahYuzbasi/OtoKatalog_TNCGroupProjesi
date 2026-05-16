//WantAPI'dan alinan json kodalrini json to dart yaparak buraya aktardim

class VehicleResponse {
  String? status;
  Meta? meta;
  List<Vehicle>? data;

  VehicleResponse({this.status, this.meta, this.data});

  VehicleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Vehicle>[];
      json['data'].forEach((v) {
        data!.add(Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  String? title;
  String? description;
  String? source;
  String? generated;
  int? count;

  Meta({this.title, this.description, this.source, this.generated, this.count});

  Meta.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    source = json['source'];
    generated = json['generated'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['source'] = source;
    data['generated'] = generated;
    data['count'] = count;
    return data;
  }
}

class Vehicle {
  int? id;
  String? make;
  String? model;
  int? year;
  int? price;
  String? currency;
  String? image;
  String? description;
  Specs? specs;

  Vehicle(
      {this.id,
        this.make,
        this.model,
        this.year,
        this.price,
        this.currency,
        this.image,
        this.description,
        this.specs});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    price = json['price'];
    currency = json['currency'];
    image = json['image'];
    description = json['description'];
    specs = json['specs'] != null ? Specs.fromJson(json['specs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['make'] = make;
    data['model'] = model;
    data['year'] = year;
    data['price'] = price;
    data['currency'] = currency;
    data['image'] = image;
    data['description'] = description;
    if (specs != null) {
      data['specs'] = specs!.toJson();
    }
    return data;
  }
}

class Specs {
  String? engine;
  String? transmission;
  String? fuelType;
  String? mileage;
  String? s060mph;
  String? horsepower;
  String? towing;

  Specs(
      {this.engine,
        this.transmission,
        this.fuelType,
        this.mileage,
        this.s060mph,
        this.horsepower,
        this.towing});

  Specs.fromJson(Map<String, dynamic> json) {
    engine = json['engine'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    mileage = json['mileage'];
    s060mph = json['0-60mph'];
    horsepower = json['horsepower'];
    towing = json['towing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['engine'] = engine;
    data['transmission'] = transmission;
    data['fuel_type'] = fuelType;
    data['mileage'] = mileage;
    data['0-60mph'] = s060mph;
    data['horsepower'] = horsepower;
    data['towing'] = towing;
    return data;
  }
}