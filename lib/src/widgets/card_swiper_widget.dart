import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas; 
  
  CardSwiper({ @required this.peliculas});
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    return Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Swiper(
            layout: SwiperLayout.STACK,
            itemWidth:_screenSize.width*0.7,
            itemHeight: _screenSize.height*0.3,
            itemBuilder: (BuildContext context,int index){
                
                peliculas[index].uniqId = '${peliculas[index].id}-csw';
                final hero = Hero(
                  tag: peliculas[index].uniqId,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: FadeInImage(
                          placeholder: AssetImage('assets/img/no-image.jpg'), 
                          image: NetworkImage(peliculas[index].getImg()),
                          fit: BoxFit.fill,
                          height: _screenSize.height*0.5,
                          width: _screenSize.width*0.7,
                        )
                  ),
                );
                return GestureDetector(
                  child: hero,
                  onTap: (){
                    Navigator.pushNamed(context, 'detalles',arguments: peliculas[index]);
                  },
                );
              },
            itemCount: peliculas.length,
              // pagination: new SwiperPagination(),
              // control: new SwiperControl(),
          ),
    );
  }
}