import 'package:flutter/material.dart';
import 'package:hits_app/domain/model/track.dart';


class TrackCard extends StatelessWidget {
  final Track track;
  TrackCard({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: ListTile(
          minVerticalPadding: 0,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FittedBox(
              fit: BoxFit.fill,
              child: track.imagePath != null
                  ? Image.network(track.imagePath!, height: 80, width: 80,)
                  : Icon(
                Icons.image,
                size: 80,
              ),
            ),
          ),
          title: Text(
            track.name!,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      track.artistName!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chevron_right,
                size: 20,
              ),
              // Icon(
              //   Icons.access_time_rounded,
              //   size: 15,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  (track.playbackSeconds! / 60).floor().toString() +
                      ":" +
                      ((track.playbackSeconds! % 60 < 10)
                          ? ("0" +
                          (track.playbackSeconds! % 60)
                              .toString())
                          : track.playbackSeconds! % 60)
                          .toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

