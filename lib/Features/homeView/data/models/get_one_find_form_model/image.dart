class Image {
  String? secureUrl;
  String? publicId;

  Image({this.secureUrl, this.publicId});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      secureUrl: json['secure_url'] as String?,
      publicId: json['public_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }
}
