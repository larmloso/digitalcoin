class Config {
  final String bitkubEndpoint;
  final String bitkubApikey;
  final String bitkubApiSecret;

  Config({this.bitkubEndpoint, this.bitkubApikey, this.bitkubApiSecret});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      bitkubEndpoint: json['bitkub.endpoint'],
      bitkubApikey: json['bitkub.apikey'],
      bitkubApiSecret: json['bitkub.apisecret'],
    );
  }
}
