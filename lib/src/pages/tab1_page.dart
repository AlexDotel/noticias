import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:noticias/src/widgets/lista.dart';
import 'package:noticias/src/services/news_services.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Headlines',
            style: TextStyle(fontFamily: 'SF'),
          ),
        ),
        body: headlines.length != 0
            ? ListaNoticias(
                noticias: headlines,
              )
            : Center(child: CircularProgressIndicator()));
  }

  @override
  // TODO: Aqui iria una condicion para desactivar el mantenimento del estado
  bool get wantKeepAlive => true;
}
