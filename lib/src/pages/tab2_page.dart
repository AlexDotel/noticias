import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:noticias/src/theme/tema.dart';
import 'package:noticias/src/widgets/lista.dart';
import 'package:noticias/src/models/categorias_model.dart';
import 'package:noticias/src/services/news_services.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final servicio = Provider.of<NewsService>(context);
    // servicio.setSelectCat = 'business';
    final listaNoticias = servicio.getListaCategoria;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Categories', style: TextStyle(fontFamily: 'SF')),
            centerTitle: true,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _ListaCategoria(),
              Expanded(child: ListaNoticias(noticias: listaNoticias))
            ],
          )),
    );
  }
}

class _ListaCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Categoria> categorias =
        Provider.of<NewsService>(context).categorias;

    if (categorias.length != null) {
      return Container(
        color: temaOscuro.cardColor,
        height: 100,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          itemBuilder: (BuildContext context, int index) {
            return _Categoria(categorias[index]);
          },
        ),
      );
    } else {
      return Center(
        child: Column(
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            Text('Loading Categories')
          ],
        ),
      );
    }
  }
}

class _Categoria extends StatelessWidget {
  final Categoria categoria;

  const _Categoria(this.categoria);

  @override
  Widget build(BuildContext context) {
    final cName = categoria.name;
    final newsServices = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () => newsServices.setSelectCat = cName,
      child: Container(
        decoration: BoxDecoration(
          color: temaOscuro.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        height: 60,
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(categoria.icon,
                color: cName == newsServices.getSelectCat
                    ? temaOscuro.accentColor
                    : Colors.white),
            SizedBox(height: 10),
            Text('${cName[0].toUpperCase()}${cName.substring(1)}',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: 'SF')),
          ],
        ),
      ),
    );
  }
}
