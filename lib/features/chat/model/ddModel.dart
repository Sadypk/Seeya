class DDModel{
  String title;
  String value;
  DDModel({this.value, this.title});
  static final items = <DDModel>[
    DDModel(title: 'All Chat', value: 'all'),
    DDModel(title: 'Next option', value: 'another'),
  ];
}