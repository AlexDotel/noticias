import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/pages/tabs_page.dart';
import 'src/services/news_services.dart';
import 'src/theme/tema.dart';

void main() => runApp(Noticias());

class Noticias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Noticias',
        theme: temaOscuro,
        initialRoute: 'tabs',
        routes: {
          'tabs' : (BuildContext context) => TabsPage(),
        },
      ),
    );
  }
}
