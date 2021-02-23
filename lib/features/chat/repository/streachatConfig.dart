import 'package:dio/dio.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SConfig{
  static final client = Client(
      's3ppuz6g7vau',
      logLevel: Level.WARNING
  );

  static final Dio dio = new Dio()..options = BaseOptions(
      headers: {
        'Accept-Version' : 'v1',
        'Authorization' : 'Client-ID hmHD_3JNv8PJxroAG0D2PgGE7lxY3_qpKwckT3Z5x_Q'
      }
  );
}