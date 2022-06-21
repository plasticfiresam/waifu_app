enum WaifuType {
  sfw(value: 'sfw', displayName: 'SFW'),
  nsfw(value: 'nsfw', displayName: 'NSFW');

  const WaifuType({
    required this.value,
    required this.displayName,
  });

  final String value;
  final String displayName;

  @override
  String toString() => value;
}
