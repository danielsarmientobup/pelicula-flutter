import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/models/actores_model.dart';

class PeliculaDetalle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearActores(pelicula),
                // _crearCasting(),
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true, // para que se mantega visible al hacer scroll
      flexibleSpace: FlexibleSpaceBar( //Widget que debe de adaptarse en el SliverAppBar
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'), 
            image: NetworkImage(pelicula.getBackgroundImg()),
            fit: BoxFit.cover,
          ),
      ), 
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getImg()),
                height: 100.0,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearActores(Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();

    return  FutureBuilder(
      future: peliProvider.getActores(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if(snapshot.hasData) return _crearActoresView(snapshot.data);
        return Center( child: CircularProgressIndicator(),);
      },
    );
  }

  Widget _crearActoresView(List<Actor> actores) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0.h),
      height: 40.0.h,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: (contex,i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor ){

    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2.0.h),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getUrlImg()),
              height: 20.0.h,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}