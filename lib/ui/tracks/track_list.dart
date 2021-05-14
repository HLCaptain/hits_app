import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/di/di_utils.dart';
import 'package:hits_app/ui/tracks/content/track_list_content.dart';
import 'package:hits_app/ui/tracks/track_list_bloc.dart';
import 'package:hits_app/ui/tracks/track_list_event.dart';
import 'package:hits_app/ui/tracks/track_list_state.dart';
import 'package:hits_app/utils.dart';

class TrackListPage extends StatefulWidget {
  const TrackListPage({required Key key}) : super(key: key);

  @override
  _TrackListPageState createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "TODO: CHANGE THIS TEXT"
        ),
      ),
      body: BlocProvider(
        create: (context) => injector<TrackListBloc>(),
        child: BlocListener<TrackListBloc, TrackListState>(
          listener: (context, state) {
            if (state is Error) {
              context.showSnackBar(
                content: Text("Failed to refresh tracks!"),
              );
            }
          },
          child: BlocBuilder<TrackListBloc, TrackListState>(
            builder: (context, state) {
              if (state is Loading) {
                BlocProvider.of<TrackListBloc>(context).add(LoadTracksEvent());
                return TrackListLoading();
              }

              if (state is Content) {
                return TrackListContent(state);
              }

              return Center(
                child: Text("Something went wrong :("),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TrackListLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
