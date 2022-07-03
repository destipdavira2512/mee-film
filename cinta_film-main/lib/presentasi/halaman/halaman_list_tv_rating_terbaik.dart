import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/presentasi/provider/tvls/top_rated_tvls_notifier.dart';
import 'package:cinta_film/presentasi/widgets/tvls_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HalamanSerialTvTerbaik extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<HalamanSerialTvTerbaik> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvlsNotifier>(context, listen: false)
            .fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial Tv Ranting Tertinggi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvlsNotifier>(
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
