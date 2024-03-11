class ProfilePic {
  String? secureUrl;
  String? publicId;

  ProfilePic({this.secureUrl, this.publicId});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
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
