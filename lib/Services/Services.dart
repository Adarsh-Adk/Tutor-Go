
import 'dart:io';

import 'package:Tutor_Go/Models/Channel_Info.dart';
import 'package:Tutor_Go/Models/VideosModel.dart';
import 'package:Tutor_Go/Utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

var CHANNEL_ID=Constants().id;
var _baseUrl=Constants().url;
var key=Constants().key;

class Services{

  /*
  curl \
  'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UC2bNrKQbJLphxNCd6BSnTkA&access_token=AIzaSyCmuCuSNbJO6yoge36NKbkRS5fkeRsERGE&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed

   */

  static Future<ChannelInfo>getChannelInfo()async{
    Map<String,String> parameters={
      'part':'snippet,contentDetails,statistics',
      'id':CHANNEL_ID,
      'key':key,
    };
    Map<String,String> headers={
      HttpHeaders.contentTypeHeader:'application/json'
    };

    Uri uri= Uri.https(_baseUrl, '/youtube/v3/channels',parameters);

    Response response =await http.get(uri,headers: headers);
    // print(response.body);

    ChannelInfo channelInfo =channelInfoFromJson(response.body);
    return channelInfo;

  }
  static Future<VideosModel>getVideosModel({String playListId,String pageToken})async{
  Map<String ,String>parameters={
    'part':'snippet',
    'maxResults':'8',
    'playlistId':playListId,
    'pageToken':pageToken,
    'key':key,

  };
  Map<String,String> headers={
    HttpHeaders.contentTypeHeader:'application/json'
  };

  Uri uri= Uri.https(_baseUrl, '/youtube/v3/playlistItems',parameters);

  Response response =await http.get(uri,headers: headers);
  // print(response.body);

  VideosModel videosModel= videosModelFromJson(response.body);
  return videosModel;
  }



}