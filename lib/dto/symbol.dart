class Ticker {

  final String key;
  final int id;
  final double last;
  final double lowestAsk;
  final double highestBid;
  final double percentChange;
  final double baseVolume;
  final double quoteVolume;
  final double isFrozen;
  final double high24hr;
  final double low24hr;

  Ticker(
      {this.key,
        this.id,
      this.last,
      this.lowestAsk,
      this.highestBid,
      this.percentChange,
      this.baseVolume,
      this.quoteVolume,
      this.isFrozen,
      this.high24hr,
      this.low24hr});

  factory Ticker.fromJson(String tickerKey,Map<String, dynamic> json) {
    return Ticker(
      key :tickerKey,
      id: json['id'],
      last: json['last'].toDouble(),
      lowestAsk: json['lowestAsk'].toDouble(),
      highestBid: json['highestBid'].toDouble(),
      percentChange: json['percentChange'].toDouble(),
      baseVolume: json['baseVolume'].toDouble(),
      quoteVolume: json['quoteVolume'].toDouble(),
      isFrozen: json['isFrozen'].toDouble(),
      high24hr: json['high24hr'].toDouble(),
      low24hr: json['low24hr'].toDouble(),
    );
  }
}
