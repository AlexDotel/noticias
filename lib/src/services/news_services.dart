import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:noticias/src/models/categorias_model.dart';

import 'package:noticias/src/models/news_models.dart';

final _urlNews = 'https://newsapi.org/';
final _apiKey = '09483fb91a9d4a54a04931369f24607b';
final _endpoint = '/v2/top-headlines';
final _country = 'country=nz';
final _limit = 'pageSize=100';

class NewsService with ChangeNotifier {
  String selectedCat = 'business';

  List<Article> headlines = [];
  List<Article> newsC = [];

  List<Categoria> categorias = [
    Categoria(FontAwesomeIcons.building, 'business'),
    Categoria(FontAwesomeIcons.dizzy, 'entertainment'),
    Categoria(FontAwesomeIcons.newspaper, 'general'),
    Categoria(FontAwesomeIcons.hospitalSymbol, 'health'),
    Categoria(FontAwesomeIcons.flask, 'science'),
    Categoria(FontAwesomeIcons.futbol, 'sports'),
    Categoria(FontAwesomeIcons.glasses, 'technology'),
  ];

  Map<String, List<Article>> artCategorias = {};

  NewsService() {
    this.getTopHeadlines();

    categorias.forEach((item) {
      this.artCategorias[item.name] = new List();
    });
  }

  //Obtener Categorias
  get getSelectCat => this.selectedCat;

  //Cambiar Categorias
  set setSelectCat(String valor) {
    this.selectedCat = valor;

    // Aqui cuando se cambia la categoria o se selecciona
    // Hacemos la peticion y llenamos la categoria ↓
    this.getArticlesByCategorie(valor);
    notifyListeners();
  }

  //Obteler Lista de Categorias
  get getListaCategoria => artCategorias[selectedCat];











  // https://newsapi.org/v2/top-headlines?country=us&apiKey=09483fb91a9d4a54a04931369f24607b&pageSize=100

  getTopHeadlines() async {
    final url = '$_urlNews$_endpoint?apiKey=$_apiKey&$_country&$_limit';
    final resp = await http.get(url);

    if (resp != null) {
      final newsResponse = newsResponseFromJson(resp.body);
      this.headlines.addAll(newsResponse.articles);
    } else {
      return null;
    }

    notifyListeners();
  }

  // https://newsapi.org/v2/top-headlines?apiKey=09483fb91a9d4a54a04931369f24607b&pageSize=30&country=us&category=health

  getArticlesByCategorie(String cat) async {
    //Antes que nada verificamos que este vacia la lista de categorias.↓
    if (this.artCategorias[cat].length > 0) {
      return this.artCategorias[cat];
    }

    //Aqui obtendremos el listado de noticias, pero por categoria.↓
    final url = '$_urlNews$_endpoint?apiKey=$_apiKey&$_country&category=$cat';
    final resp = await http.get(url);

    //Comprobamos que tenga informacion ↓
    if (resp != null) {
      final newsResponse = newsResponseFromJson(resp.body);
      // this.headlines.addAll(newsResponse.articles);
      this.artCategorias[cat].addAll(newsResponse.articles);
    } else {
      return null;
    }

    //Notificamos
    notifyListeners();
  }
}
