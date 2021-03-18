import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    
    final _screenSize = MediaQuery.of(context).size;
    final _heightContPelicula = _screenSize.height * 0.3;
    final _heightContPopulares = _screenSize.height * 0.2;
    final _heightTituloPopulares = _screenSize.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
              icon: Icon(Icons.search), 
              onPressed: (){ 
                peliculasProvider.isPermitido = false;
                showSearch(
                  context: context, 
                  delegate: DataSearch(),
                );
              },
            )
        ],
      ),
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _swiperTarjetas(_heightContPelicula),
              _footer( context, _heightTituloPopulares ),
            ],
          ),
        ),
    );
  }

  Widget _swiperTarjetas(double _heightContPelicula) {
    
    return FutureBuilder(
        future: peliculasProvider.getEncines(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData) return CardSwiper(peliculas: snapshot.data,);
          return Container(
              height: _heightContPelicula,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          
        },
      ); 
    // peliculasProvider.getEncines();
    // return CardSwiper(
    //     peliculas: [1,2,3,4,5],
    //   );
  }

  Widget _footer(BuildContext context, double _heightTituloPopulares) {

    peliculasProvider.getPopulares();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: _heightTituloPopulares,
              padding: EdgeInsets.only(top:  _heightTituloPopulares * 0.3,left: _heightTituloPopulares * 0.3),
              child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
            ),
          StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
                    if(snapshot.hasData) return MovieHorizontal(
                        peliculas: snapshot.data,
                        siguientePagina: peliculasProvider.getPopulares,
                        peliculasProvider: peliculasProvider,
                      );
                    return Center(child: CircularProgressIndicator());

              }
            )
        ],
      ),
    );
  }
}