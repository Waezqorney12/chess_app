class ProfileEntities {
  final String? profileImage;
  final String? profileStatus;
  final String? profileUsername;
  final String? profileFirstName;
  final String? profileLastName;
  final String? profileCountry;
  final String? profileLocation;

  ProfileEntities({
    this.profileImage,
    this.profileStatus,
    this.profileUsername,
    this.profileFirstName,
    this.profileLastName,
    this.profileCountry,
    this.profileLocation,
  });

  copyWith(
    final String? profileImage,
    final String? profileStatus,
    final String? profileUsername,
    final String? profileFirstName,
    final String? profileLastName,
    final String? profileCountry,
    final String? profileLocation,
  ) {
    return ProfileEntities(
      profileImage: this.profileImage ?? profileImage,
      profileStatus: this.profileStatus ?? profileStatus,
      profileUsername: this.profileUsername ?? profileUsername,
      profileFirstName: this.profileFirstName ?? profileFirstName,
      profileLastName: this.profileLastName ?? profileLastName,
      profileCountry: this.profileCountry ?? profileCountry,
      profileLocation: this.profileLocation ?? profileLocation,
    );
  }
}
