

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'dart:convert';
import 'dart:async'; // stream

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apikey      = '8a3f6cc2eb76d6aaabcfe38b3045396c';
  String _url         = 'api.themoviedb.org';
  String _language    = 'es-ES';
  

  int _peliculasPage  = 0;
  int _popularesPage  = 0;
  bool _isCargando    = false;
  bool isPermitido   = true;
  

  // Stream
  List<Pelicula> _populares = [];
  // broadcast: para pueda emitir en muchos lugares
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add; 

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController.close();
  }


  Future<List<Actor>> getActores(int peliId) async{
    String _codePathActores = '3/movie/$peliId/credits';
    final url = Uri.https(_url,_codePathActores,{
      'api_key'   : _apikey,
      'language'  : _language,
    });
    final decodeData = await _getDataDecodificada(url);
    final actores = Actores.fromJsonList(decodeData['cast']);
    return actores.listActores;
  }

  Future<List<Pelicula>> getEncines() async{
    if(isPermitido) {
       _peliculasPage++;
    }else {
      _peliculasPage = _peliculasPage;
    }
    print(_peliculasPage);
    final url = _getUrl('3/movie/now_playing',_peliculasPage.toString());
    final peliculas = await _getData(url);
    return peliculas;
  }

  getPopulares() async{

    if(_isCargando) return [];
    _isCargando = true;
    if(isPermitido){
      _popularesPage++;
      final url = _getUrl('3/movie/popular',_popularesPage.toString());
      final peliculasPopulares = await _getData(url);
      _populares.addAll(peliculasPopulares);
    }
    print(_populares.length);
    print(isPermitido);
    popularesSink(_populares);
    _isCargando = false;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async{
    final url = Uri.https(_url,'3/search/movie',{
      'api_key'   : _apikey,
      'language'  : _language,
      'query'      : query,
    });

    final peliculas = await _getData(url);
    return peliculas;
  }
  

  Uri _getUrl(String codePath, String numPage){
    return Uri.https(_url, codePath,{
      'api_key'   : _apikey,
      'language'  : _language,
      'page'      : numPage,
    });
  }

  Future<List<Pelicula>> _getData(Uri url) async{
    final decodeData = await _getDataDecodificada(url);
    final result  = new Peliculas.fromJsonList(decodeData['results']);
    return result.listPelicula;
  }

  Future<Map<String,dynamic>>  _getDataDecodificada(Uri url) async{
    final resp = await http.get(url);
    return json.decode(resp.body);
  }

}