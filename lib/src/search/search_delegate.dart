
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

    final PeliculasProvider peliculasProvider = new PeliculasProvider();

    String seleccion = '';
    final peliculas = [
      'Spiderman',
      'Aquaman',
      'Batman',
      'Shazan'
    ];

    final peliculasResientes = [
      'Spiderman',
      'Batman',
    ];

    @override
    List<Widget> buildActions(BuildContext context) {
      // las acciones  de nuestro appbar
      return [
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: (){
            query = '';
          }
        ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del Appbar 
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation, // tiempo en cual se anima este icono
        ), 
        onPressed: (){
          close(context, null); // para cerrar la vista de busqueda
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultado que vamo a mostrar
      return Center(
        child: Container(
          child: Text(seleccion),
        ),
      );
    }
    @override
    Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando el usuario escribe
     
      if(query.isEmpty) return Container();

      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if(snapshot.hasData){
            final peliculas  = snapshot.data;
            return ListView(
              children: peliculas.map((peli) {
                peli.uniqId = '${peli.id}-sd';
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image:  NetworkImage(peli.getBackgroundImg()),
                    width: 10.0.w,
                    fit: BoxFit.contain,
                  ),
                  title: Text(peli.title),
                  subtitle: Text(peli.originalTitle),
                  onTap: () {
                    close(context, null); // cierra la vista de la barra de busqueda
                    Navigator.pushNamed(context, 'detalles', arguments: peli);
                  },
                );
                
              
              }).toList()
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
  }
    // @override
  //   Widget buildSuggestions(BuildContext context) {
  //   // Sugerencias que aparecen cuando el usuario escribe
  //     final listaSugerida = (query.isEmpty)
  //                           ? peliculasResientes 
  //                           : peliculas.where((peli) => peli.toLowerCase().startsWith(query.toLowerCase())
  //                           ).toList();
  //     return ListView.builder(
  //       itemCount: listaSugerida.length,
  //       itemBuilder: (context,i){
  //         return ListTile(
  //           leading: Icon(Icons.movie),
  //           title: Text(listaSugerida[i]),
  //           onTap: (){
  //             seleccion = listaSugerida[i];
  //             showResults(context);
  //           },
  //         );
  //       },
  //     );
  // }

}