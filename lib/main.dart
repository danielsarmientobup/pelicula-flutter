import 'package:flutter/material.dart';


import 'package:peliculas/src/routes/routes.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(          // para usar la librerí sizer                  
      builder: (context, constraints) {
        return OrientationBuilder(                 
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation); 
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Peliculas',
              initialRoute: '/',
              routes: getRoutes(),
              onGenerateRoute: (RouteSettings settings){
                return MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  );
              },
            );
          },
        );
      },
    );
  }
}