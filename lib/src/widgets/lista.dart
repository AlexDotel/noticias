import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias({@required this.noticias});
  //Creamos un constructor a la clase para que sea requerida la lista de noticias.

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: temaOscuro.dialogBackgroundColor),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: this.noticias.length,
            itemBuilder: (BuildContext context, int index) {
              // return _NoticiaVertical(noticia: noticias[index], index: index);
              return _NoticiaHorizontal(noticia: noticias[index], index: index);
            }));
  }
}

//Tarjeta Horizontal
class _NoticiaHorizontal extends StatelessWidget {
  final Article noticia;
  final int index;

  const _NoticiaHorizontal({@required this.noticia, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: TarjetaImagen(
              noticia,
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TarjetaTitulo(
                  noticia: noticia,
                  index: index,
                ),
                Expanded(child: Container()),
                TarjetaFuente(
                  noticia,
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Imagen Horizontal
class TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: imagenHorizontal(
          noticia, 'assets/img/giphy.gif', 'assets/img/no-image.png'),
      // ),
    );
  }
}

//Titulo Horizontal
class TarjetaTitulo extends StatelessWidget {
  final Article noticia;
  final int index;

  const TarjetaTitulo({@required this.noticia, @required this.index});

  @override
  Widget build(BuildContext context) {
    final titulo = noticia.title.split("-");

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
      child: Text(titulo[0].toUpperCase(),
          overflow: TextOverflow.ellipsis, maxLines: 4, style: tituloStyle()),
    );
  }
}

//Fuente Horizontal
class TarjetaFuente extends StatelessWidget {
  final Article noticia;

  TarjetaFuente(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 10),
        child:
            Text('${noticia.source.name}'.toUpperCase(), style: fuenteStyle()));
  }
}

//Tarjeta Vertical
class _NoticiaVertical extends StatelessWidget {
  final Article noticia;
  final int index;

  _NoticiaVertical({@required this.noticia, @required this.index});

  @override
  Widget build(BuildContext context) {
    final noticiaTitulo = '${noticia.title}'.split("-");

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _ImagenNoticiasVertical(noticia),
            TituloFuenteNoticia(noticia),
          ],
        ));
  }
}

//Titulo y Fuente Vertical
class TituloFuenteNoticia extends StatelessWidget {
  final Article noticia;

  const TituloFuenteNoticia(this.noticia);

  @override
  Widget build(BuildContext context) {
    final noticiaTitulo = '${noticia.title}'.split("-");

    return Container(
      padding: EdgeInsets.all(16),
      height: 110,
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(noticiaTitulo[0].toUpperCase(),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: tituloStyle()),
          SizedBox(
            height: 10,
          ),
          Text(noticia.source.name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: fuenteStyle())
        ],
      ),
    );
  }
}

// Imagen Vertical
class _ImagenNoticiasVertical extends StatelessWidget {
  final Article noticia;

  const _ImagenNoticiasVertical(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: imagenVertical(noticia, 'assets/img/giphy.gif', 'assets/img/no-image.png'),
    );
  }
}

//Estilo de Titulos
TextStyle tituloStyle() {
  return TextStyle(
    color: temaOscuro.primaryColorDark,
    fontSize: 15.5,
    // fontWeight: FontWeight.w400,
    fontFamily: 'SF',
  );
}

//Estilo de fuente
TextStyle fuenteStyle() {
  return TextStyle(
    color: Colors.black54,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    fontFamily: 'SF',
  );
}

//Imagen Horizontal
Widget imagenHorizontal(Article noticia, String placeholder, String noImage) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: (noticia.urlToImage != null)
          ? FadeInImage(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: AssetImage(placeholder),
              image: NetworkImage(noticia.urlToImage))
          : Image(
              image: AssetImage(noImage),
              fit: BoxFit.fitWidth,
            ));
}

Widget imagenVertical(Article noticia, String placeholder, String noImage) {
  ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: (noticia.urlToImage != null)
        ? FadeInImage(
            placeholder: AssetImage(placeholder),
            image: NetworkImage('${noticia.urlToImage}'),
            fit: BoxFit.cover,
          )
        : Image(image: AssetImage(noImage), fit: BoxFit.cover),
  );
}
