
import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/'         :  (BuildContext context) => HomePage(), 
    'detalles'  : (_) => PeliculaDetalle(), 
  };
}