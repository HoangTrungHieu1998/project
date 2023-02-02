import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/bloc/todo_bloc.dart';
import 'package:flutter_todoapp/bloc/todo_init.dart';
import 'package:flutter_todoapp/boxes.dart';
import 'package:flutter_todoapp/objectbox.dart';
import 'package:flutter_todoapp/todo_dialog.dart';
import 'package:flutter_todoapp/todo_hive.dart';
import 'package:flutter_todoapp/todo_object_page.dart';
import 'package:flutter_todoapp/todo_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

late ObjectBox objectBox;

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoHiveAdapter());
  await Hive.openBox<TodoHive>("todo_hive");
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState

    _tabController = TabController(length: 2, vsync: this);
    TodoInit.instance.init(objectBox.store);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.green,
                width: double.infinity,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: const [
                    Tab(
                      text: "Todo Hive",
                    ),
                    Tab(
                      text: "Todo Box",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    TodoPage(bloc: TodoInit.instance.bloc,),
                    TodoObjectPage(bloc: TodoInit.instance.blocBox,store: objectBox.store,)
                  ],
                ),
              )
            ],
          )),
    );
  }

}

