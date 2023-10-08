import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/NotesProvider.dart';
import 'package:notes/screens/Notes.dart';
import 'package:notes/screens/LogIn.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'constants/endpoint.dart';
import 'helpers/SharedPreferencesManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
      ],
      child: EasyLocalization(
          supportedLocales:const [Locale('en'), Locale('ar')],
          path: 'assets/lang',
          fallbackLocale: const Locale('en'),
          child: const MyApp()),
    ),
  );
  SharedPreferencesManager.init();
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: isLogin(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Text('Loading....');
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return snapshot.data ?  Notes() :  LogIn();
          }

        },
      ),

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }

  Future<bool> isLogin() async {


    SharedPreferencesManager.init().then((value) async {
      String? token = await SharedPreferencesManager.getString('token');
      final response = await http.get(
        Uri.parse(APICall().apiGetNotes),
        headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      },
      );

      if(response.statusCode != 200){
      return false;
      }
      return (token != null);
    });
    return false;
  }
}
