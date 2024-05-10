// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Restaurant {
  String nama;
  String telepon;
  String alamat;
  String review;
  Restaurant({
    required this.nama,
    required this.telepon,
    required this.alamat,
    required this.review,
  });

  Restaurant copyWith({
    String? nama,
    String? telepon,
    String? alamat,
    String? review,
  }) {
    return Restaurant(
      nama: nama ?? this.nama,
      telepon: telepon ?? this.telepon,
      review: review ?? this.review,
      alamat: alamat ?? this.alamat,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nama': nama});
    result.addAll({'telepon': telepon});
    result.addAll({'review': review});
    result.addAll({'alamat': alamat});

    return result;
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      nama: map['nama'] ?? '',
      telepon: map['telepon'] ?? '',
      alamat: map['alamat'] ?? '',
      review: map['review'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Restaurant(nama: $nama, telepon: $telepon, review: $review, alamat: $alamat)';

  @override
  bool operator ==(covariant Restaurant other) {
    if (identical(this, other)) return true;

    return other.nama == nama &&
        other.telepon == telepon &&
        other.review == review &&
        other.alamat == alamat;
  }

  @override
  int get hashCode =>
      nama.hashCode ^ telepon.hashCode ^ review.hashCode ^ alamat.hashCode;
}
