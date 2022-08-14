import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/Drawerhiden/hidendrawer.dart';
import 'package:flutter_todo/db/noted.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'data/shared/Task_saved.dart';
import 'data/thems.dart';

late Box box;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());
  box = await Hive.openBox<Notes>("notes");
  await TaskerPreference.init(); // for initial SharedPerfomance ..
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemProvider(),
      builder: (context, _) {
        final themProvider = Provider.of<ThemProvider>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: themProvider.themeMode,
          darkTheme: Mytheme.darkthem,
          theme: Mytheme.lightthem,
          home: HidenDrawer(),
        );
      });
}
