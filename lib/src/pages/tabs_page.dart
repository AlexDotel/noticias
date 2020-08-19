import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias/src/pages/tab1_page.dart';
import 'package:noticias/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Aqui envolvemos el Scaffold en un ChangeNotifierProvider
    //esto podria hacerse hasta del main.dart dependiendo de
    //los widgets que necesiten escuchar el cambio del Provider.
    return ChangeNotifierProvider(
      //Y le aportamos el create con la instancia del modelo
      create: (_) => new _NavegacionModel(),
      child: SafeArea(
        child: Scaffold(
          body: _Paginas(),
          bottomNavigationBar: _Navegacion(),
        ),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navModel = Provider.of<_NavegacionModel>(context);
    //Aqui obtenemos la instancia, como si fuera un singleton.

    return BottomNavigationBar(
        currentIndex: navModel.getPagina,
        onTap: (i) => navModel.setPagina = i,
        //Aqui utilizamos la instancia para asignar el valor
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fiber_new),
              title: Text(
                'Noticias',
                style: TextStyle(fontFamily: 'SF'),
              )),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.elementor),
              title: Text(
                'Categorias',
                style: TextStyle(fontFamily: 'SF'),
              )),
        ]);
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navModel = Provider.of<_NavegacionModel>(context);
    //Aqui obtenemos la instancia, como si fuera un singleton.

    return PageView(
        
        scrollDirection: Axis.horizontal,
        controller: navModel.getController,
        onPageChanged: (i) => navModel.setPagina = i,
        // physics: BouncingScrollPhysics(),
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Tab1Page(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Tab2Page(),
            ),
          ),
        ]);
  }
}

class _NavegacionModel with ChangeNotifier {
  //Hacemos un mixin de la clase con el ChangeNotifier

  int _paginaActual = 1;
  final _controlador = PageController(viewportFraction: 0.95, initialPage: 1);

  int get getPagina => this._paginaActual;

  set setPagina(int valor) {
    this._paginaActual = valor;
    _controlador.animateToPage(valor,
        duration: Duration(milliseconds: 250),
        curve: Curves.ease);

    notifyListeners();
    //Aqui notificamos a todos los widget que
    //obtienen el valor desde esta varadbiable.
  }

  PageController get getController => this._controlador;
}
