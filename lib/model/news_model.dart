import 'package:intl/intl.dart';

class News {
  static const int announcement = 0;
  static const int pressRelease = 1;
  final int _id;
  final String _title;
  final String? _description;
  final int _type;
  final String _imageURL;
  final DateTime _enteredOn;
  final DateTime _validUntil;

  News({
    required int id,
    required String title,
    String? description,
    required int type,
    String? imageURL,
    required DateTime enteredOn,
    required DateTime validUntil,
  })  : _id = id,
        _title = title,
        _description = description,
        _type = type,
        _imageURL = imageURL ??
            'https://images.unsplash.com/photo-1612441804231-77a36b284856?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW91bnRhaW4lMjBsYW5kc2NhcGV8ZW58MHx8MHx8&w=1000&q=80',
        _enteredOn = enteredOn,
        _validUntil = validUntil;

  int get id => _id;
  String get title => _title;
  String? get description => _description;
  int get type => _type;
  String get typeString {
    switch (type) {
      case 0:
        return 'Announcement';
      case 1:
        return 'Press Release';
      default:
        return 'Unknown';
    }
  }

  String get imageURL => _imageURL;
  DateTime get enteredOn => _enteredOn;
  String get enteredOnString {
    return DateFormat('MMMM d, y').format(enteredOn);
  }

  DateTime get validUntil => _validUntil;
  String get validUntilString {
    return DateFormat('MMMM d, yyyy').format(validUntil);
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: int.parse(json['newsID'] != null ? json['newsID'] : '0'),
      title: json['newstitle'],
      description: json['description'],
      type: int.parse(json['type']),
      imageURL: json['imageurl'],
      enteredOn: DateTime.parse(json['enteredon']),
      validUntil: DateTime.parse(json['validuntil']),
    );
  }

  void printNews() {
    print('id: $id');
    print('title: $title');
    print('description: $description');
    print('type: $typeString');
    print('imageURL: $imageURL');
    print('enteredOn: $enteredOnString [${enteredOn.runtimeType}]');
    print('validUntil: $validUntilString [${validUntil.runtimeType}]');
  }
}

class StudentNews {
  final int _id;
  final String _title;
  final String? _description;
  final int _type;
  final DateTime _announceStart;
  final DateTime _validUntil;

  StudentNews({
    required int id,
    required String title,
    String? description,
    required int type,
    required DateTime announceStart,
    required DateTime validUntil,
  })  : _id = id,
        _title = title,
        _description = description,
        _type = type,
        _announceStart = announceStart,
        _validUntil = validUntil;

  int get id => _id;
  String get title => _title;
  String? get description => _description;
  int get type => _type;
  DateTime get announceStart => _announceStart;
  String get announceStartString {
    return DateFormat('MMMM d, yyyy').format(announceStart);
  }

  DateTime get validUntil => _validUntil;
  String get validUntilString {
    return DateFormat('MMMM d, yyyy').format(validUntil);
  }

  factory StudentNews.fromJson(Map<String, dynamic> json) {
    return StudentNews(
      id: int.parse(json['newsID']),
      title: json['newstitle'],
      description: json['description'],
      type: int.parse(json['type']),
      announceStart: DateTime.parse(json['announcestart']),
      validUntil: DateTime.parse(json['validuntil']),
    );
  }

  void printNews() {
    print('id: $id');
    print('title: $title');
    print('description: $description');
    print('type: $type');
    print('announcestart: $announceStartString [${announceStart.runtimeType}]');
    print('validUntil: $validUntilString [${validUntil.runtimeType}]');
  }
}
