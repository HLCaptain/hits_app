import 'dart:async';
import 'package:retrofit/retrofit.dart';

import 'model/network_reply.dart';

abstract class NapsterApi {
  Future<HttpResponse<NetworkReply>> getTopTracks();
  Future<HttpResponse<NetworkReply>> getTrack(String id);
}
