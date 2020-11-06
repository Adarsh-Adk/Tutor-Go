import 'package:Tutor_Go/Models/Channel_Info.dart';
import 'package:Tutor_Go/Models/VideosModel.dart';
import 'package:Tutor_Go/Screens/VideoPlayerScreen.dart';
import 'package:Tutor_Go/Services/Services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ChannelInfo _channelInfo;
  VideosModel _videosModel;
  Item _item;
  bool _loading;
  String _playlistId ='PLlyCyjh2pUe9wv-hU4my-Nen_SvXIzxGB';
  String _nextPageToken;
  ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _nextPageToken="";
    _videosModel=VideosModel();
    _videosModel.videos=List();
    _getChannelInfo();
    _loading=true;
    _scrollController=ScrollController();
  }
  _getChannelInfo()async{
    _channelInfo=await Services.getChannelInfo();
    _item=_channelInfo.items[0];
    await _loadVideos();
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tutor Go"),),
      body: _loading?Center(child: CircularProgressIndicator()):_cont()

    );
  }

  _loadVideos() async{
    VideosModel tempVideosModel= await Services.getVideosModel(
        playListId: _playlistId,
        pageToken:_nextPageToken
    );
    _nextPageToken=tempVideosModel.nextPageToken;
    _videosModel.videos.addAll(tempVideosModel.videos);
    // print(_videosModel.videos.length);
    print(_nextPageToken);
    setState(() {

    });
  }

  _cont(){
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Container(
            height: 100,width: 600,
            child: Card(child: Column(children: [
              CircleAvatar(backgroundImage:CachedNetworkImageProvider(_item.snippet.thumbnails.medium.url),),
              SizedBox(width: 20,),
              Text(_item.snippet.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              Text(_item.statistics.videoCount+" "+"Videos")
            ],),),
          ),
          Container(height: 50,width:600,padding: EdgeInsets.only(left:1,right: 1),child: Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Subject 1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),)),
          )),),
          Container(
            height: 250,
            width: 400,
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification notification)
              {if(_videosModel.videos.length>=int.parse(_item.statistics.videoCount)
              )return true;
                if(notification.metrics.pixels==notification.metrics.maxScrollExtent){
                _loadVideos();
              }
              return true;

              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount:_videosModel.videos.length,
                itemBuilder: (context, index){
                VideoItem videoItem=_videosModel.videos[index];
                return Card(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){return VideoPlayerScreen(videoItem: videoItem,);}));
                    },
                    child: Container(
                      width: 250,
                      child: Column(
                        children: [
                          Container(child: CachedNetworkImage(imageUrl: videoItem.snippet.thumbnails.medium.url,fit: BoxFit.fill,)),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(videoItem.snippet.title,textAlign: TextAlign.center,),
                          )

                        ],
                      ),
                    ),
                  ),

                );
              },),
            ),
          ),
          Container(height: 50,width:600,padding: EdgeInsets.only(left:1,right: 1),child: Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Subject 2",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),)),
          )),),
          Container(
            height: 250,
            width: 400,
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification notification)
              {if(_videosModel.videos.length>=int.parse(_item.statistics.videoCount)
              )return true;
                if(notification.metrics.pixels==notification.metrics.maxScrollExtent){
                _loadVideos();
              }
              return true;

              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount:_videosModel.videos.length,
                itemBuilder: (context, index){
                  VideoItem videoItem=_videosModel.videos[index];
                  return Card(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){return VideoPlayerScreen(videoItem: videoItem,);}));
                      },
                      child: Container(
                        width: 250,
                        child: Column(
                          children: [
                            Container(child: CachedNetworkImage(imageUrl: videoItem.snippet.thumbnails.medium.url,fit: BoxFit.fill,)),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(videoItem.snippet.title,textAlign: TextAlign.center,),
                            )

                          ],
                        ),
                      ),
                    ),

                  );
                },),
            ),
          ),
          Container(height: 50,width:600,padding: EdgeInsets.only(left:1,right: 1),child: Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Subject 3",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),)),
          )),),
          Container(
            height: 250,
            width: 400,
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification notification)
              {
                if(_videosModel.videos.length>=int.parse(_item.statistics.videoCount)
              )return true;

                if(notification.metrics.pixels==notification.metrics.maxScrollExtent){
                _loadVideos();
              }
              return true;

              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount:_videosModel.videos.length,
                itemBuilder: (context, index){
                  VideoItem videoItem=_videosModel.videos[index];
                  return Card(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){return VideoPlayerScreen(videoItem: videoItem,);}));
                      },
                      child: Container(
                        width: 250,
                        child: Column(
                          children: [
                            Container(child: CachedNetworkImage(imageUrl: videoItem.snippet.thumbnails.medium.url,fit: BoxFit.fill,)),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(videoItem.snippet.title,textAlign: TextAlign.center,),
                            )

                          ],
                        ),
                      ),
                    ),

                  );
                },),
            ),
          ),
          Container(height: 50,width:600,padding: EdgeInsets.only(left:1,right: 1),child: Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Subject 4",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),)),
          )),),
          Container(
            height: 250,
            width: 400,
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification notification)
              {
                if(_videosModel.videos.length>=int.parse(_item.statistics.videoCount)
              )return true;
                if(notification.metrics.pixels==notification.metrics.maxScrollExtent){
                _loadVideos();
              }
              return true;

              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount:_videosModel.videos.length,
                itemBuilder: (context, index){
                  VideoItem videoItem=_videosModel.videos[index];
                  return Card(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){return VideoPlayerScreen(videoItem: videoItem,);}));
                      },
                      child: Container(
                        width: 250,
                        child: Column(
                          children: [
                            Container(child: CachedNetworkImage(imageUrl: videoItem.snippet.thumbnails.medium.url,fit: BoxFit.fill,)),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(videoItem.snippet.title,textAlign: TextAlign.center,),
                            )

                          ],
                        ),
                      ),
                    ),

                  );
                },),
            ),
          ),
        ],
      ),
    );
  }
}

