import 'package:hive/hive.dart';
part 'noted.g.dart';

@HiveType(typeId: 1)
class Notes extends HiveObject {
  Notes({
    required this.title,
    required this.description,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;
}
