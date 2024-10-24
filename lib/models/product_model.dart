class ProductModel {
  int? id;
  String? name;
  String? categ;
  String? opinions;
  String? ecomurl;
  String? description;
  String? price;
  List<String>? pictures;

  ProductModel({
    this.id,
    this.name,
    this.categ,
    this.opinions,
    this.ecomurl,
    this.description,
    this.pictures,
    this.price = "599",
  });

  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    return ProductModel(
      id: json?['id'],
      name: json?['name'],
      categ: json?['empdesc'],
      opinions: json?['location_descriptions'],
      ecomurl: json?['ecomurl'],
      description: json?['description'],
      pictures: json?['pictures'] != null
          ? List<String>.from(json?['pictures'])
          : null,
    );
  }
}

class StoreModel {
  int? id;
  String? name;
  String? slug;
  String? permalink;
  String? type;
  String? status;
  bool? featured;
  String? description;
  String? price;
  List<Category>? categories;
  List<StoreImage>? images;

  StoreModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.type,
    this.status,
    this.featured,
    this.description,
    this.price,
    this.categories,
    this.images,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      permalink: json['permalink'],
      type: json['type'],
      status: json['status'],
      featured: json['featured'],
      description: json['description'],
      price: json['price'],
      categories: (json['categories'] as List<dynamic>)
          .map((item) => Category.fromJson(item))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((item) => StoreImage.fromJson(item))
          .toList(),
    );
  }
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      length: json['length'] ?? '',
      width: json['width'] ?? '',
      height: json['height'] ?? '',
    );
  }
}

class Category {
  int id;
  String name;
  String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class StoreImage {
  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  StoreImage({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory StoreImage.fromJson(Map<String, dynamic> json) {
    return StoreImage(
      id: json['id'],
      dateCreated: DateTime.parse(json['date_created']),
      dateCreatedGmt: DateTime.parse(json['date_created_gmt']),
      dateModified: DateTime.parse(json['date_modified']),
      dateModifiedGmt: DateTime.parse(json['date_modified_gmt']),
      src: json['src'],
      name: json['name'],
      alt: json['alt'],
    );
  }
}

class Links {
  List<Href> self;
  List<Href> collection;

  Links({
    required this.self,
    required this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: (json['self'] as List<dynamic>)
          .map((item) => Href.fromJson(item))
          .toList(),
      collection: (json['collection'] as List<dynamic>)
          .map((item) => Href.fromJson(item))
          .toList(),
    );
  }
}

class Href {
  String href;

  Href({
    required this.href,
  });

  factory Href.fromJson(Map<String, dynamic> json) {
    return Href(
      href: json['href'],
    );
  }
}
