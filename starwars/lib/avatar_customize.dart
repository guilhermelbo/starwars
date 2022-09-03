import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:starwars/database/db.dart';

class AvatarCustomize extends StatefulWidget{
  const AvatarCustomize({Key? key}) : super(key: key);

  @override
  AvatarCustomizeState createState() => AvatarCustomizeState();
}

class AvatarCustomizeState extends State<AvatarCustomize>{
  salvar() async {
    var db = await DB.instance.database;
    db.update('avatar', {'svg': Get.find<FluttermojiController>().getFluttermojiFromOptions()});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FluttermojiCircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 75,
              ),
            ),
            SizedBox(
              width: min(600, width * 0.85),
              child: Row(
                children: [
                  Text(
                    "Customize:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Spacer(),
                  FluttermojiSaveWidget(
                    onTap: salvar,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              child: FluttermojiCustomizer(
                scaffoldWidth: min(600, width * 0.85),
                autosave: false,
                theme: FluttermojiThemeData(
                    boxDecoration: const BoxDecoration(boxShadow: [BoxShadow()])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}