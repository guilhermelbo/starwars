import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:starwars/database/db.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  AvatarState createState() => AvatarState();
}

class AvatarState extends State<Avatar> {
  late Future<dynamic> futureSvg;
  String svg = '';

  AvatarState() {
    Get.put(FluttermojiController());
  }

  loadSvg() async {
    var db = await DB.instance.database;
    return await db.query('avatar');
  }

  @override
  Widget build(BuildContext context) {
    futureSvg = loadSvg();
    futureSvg.then((value) => {
      setState((){
        svg = value.first['svg'];
      })
    });
    return FutureBuilder(
      future: futureSvg,
      builder:(context, snapshot){
        if(svg != ''){
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SvgPicture.string(
                svg,
                height: 100,
                width: 100,
              ),
            ),
          );
        }
        return Container();
      }
    );
  }
}