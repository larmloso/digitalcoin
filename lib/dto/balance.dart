class Balance {
  final String key;
  final double available;
  final double reserved;

  Balance({this.key, this.available, this.reserved});

  factory Balance.fromJson(String balanceKey, Map<String, dynamic> json){
    return Balance(
      key: balanceKey,
      available: json['available'].toDouble(),
      reserved: json['reserved'].toDouble(),
    );
  }
}