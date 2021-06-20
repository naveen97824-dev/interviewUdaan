import 'package:demo/components/excel_sheet_page/excel_sheet_page.dart';
import 'package:demo/function/size_config.dart';

import 'package:flutter/material.dart';

// import 'reducers/appStateReducer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final persistor = Persistor<AppState>(
  //     storage: FlutterStorage(location: FlutterSaveLocation.sharedPreferences),
  //     serializer: JsonSerializer<AppState>(AppState.fromJson),
  //     debug: true,
  //     throttleDuration: Duration(seconds: 2));
  // final initialState = await persistor.load();
  // var store = await createStore(persistor, initialState);
  runApp(MyApp());
}

// Future<Store<AppState>> createStore(persistor, initialState) async {
//   return Store(
//     appStateReducer,
//     middleware: [persistor.createMiddleware()],
//     initialState: (initialState == null ||
//             (initialState as AppState).bottomNavigationState == null ||
//             (initialState as AppState).storyState == null)
//         ? AppState.initial()
//         : initialState,
//   );
// }

class MyApp extends StatefulWidget {
  // final Store<AppState> store;
  final String title;

  const MyApp({Key key, this.title}) : super(key: key);
  @override
  MyStateApp createState() => MyStateApp();
}

class MyStateApp extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // main component is called here
          home: ExcelSheetPage(),
        );
      });
    });
  }
}
