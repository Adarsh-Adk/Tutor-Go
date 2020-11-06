import 'package:Tutor_Go/Models/VideosModel.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {

  VideoPlayerScreen({this.videoItem});
  final VideoItem videoItem;


  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  YoutubePlayerController _controller;
  bool _isPlayerReady;

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoItem.snippet.resourceId.videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: false,
          controlsVisibleAtStart: true,
        )
    )
      ..addListener(_listener);
  }

  void _listener(){
  if(_isPlayerReady&&mounted){}
}
@override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation){
        if(orientation == Orientation.portrait){
          return Scaffold(
              appBar: AppBar(title: Text(widget.videoItem.snippet.title),),
              body: videoBody()
          );
        }else return Scaffold(
          body: videoBody(),
        );
      },

    );
  }
  videoBody() {
    return Container(
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: (){_isPlayerReady=true;},
      ),);

  }
}



