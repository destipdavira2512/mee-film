import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/presentasi/provider/tvls/popular_tvls_notifier.dart';
import 'package:cinta_film/presentasi/widgets/tvls_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvlsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvlsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvlsNotifier>(context, listen: false)
            .fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvlsNotifier>(
          builder: (context, data, child) {
            switch (data.state) {
              case RequestState.Loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.Loaded:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvs = data.tv[index];
                    return TvlsCard(tvs);
                  },
                  itemCount: data.tv.length,
                );
              default:
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
            }
          },
        ),
      ),
    );
  }
}
