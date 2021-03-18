import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final PeliculasProvider peliculasProvider;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina, @required this.peliculasProvider });


  final _pageController = new PageController(
    initialPage: 1, // Empieza con la página 1
    viewportFraction: 0.3, // el ancho en porcentaje que debe de tener cada item en el children
  );
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    final double _height = _screenSize.height * 0.3;
    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent-200){
        peliculasProvider.isPermitido = true;
        siguientePagina();
      }
    });

    return Container(
      height: _height,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(),
        itemCount: peliculas.length,
        itemBuilder: ( BuildContext context, i ) => _crearTarjeta(context,peliculas[i],_height),
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula, double _height ){
    
    pelicula.uniqId = '${pelicula.id}-mh';
    final tarjeta =  Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            Hero(
              tag: pelicula.uniqId, // ID unico
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'), 
                    image: NetworkImage(pelicula.getImg()),
                    height:_height*0.7,
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            Container(
                height: _height*0.2,
                margin: EdgeInsets.only(top: _height*0.05,),
                child: Text(
                    pelicula.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,// Coloca tres puntos cuando ya no cabe.
                  )
              ),
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: (){
          Navigator.pushNamed(context, 'detalles', arguments: pelicula);
        },
      );
  }

  List<Widget> _tarjetas(double _height) {
    
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(pelicula.getImg()),
                  height:_height*0.7,
                  fit: BoxFit.cover,
                ),
            ),
            Container(
                height: _height*0.2,
                margin: EdgeInsets.only(top: _height*0.05,),
                child: Text(
                    pelicula.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,// Coloca tres puntos cuando ya no cabe.
                  )
              ),
          ],
        ),
      );
    }).toList();
  }
}