import 'package:flutter/material.dart';
import 'package:starwars/avatar_customize.dart';
import 'package:starwars/avatar.dart';
import 'package:starwars/site_oficial.dart';
import 'package:starwars/tab_bar_star_wars.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars App',
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  Widget bodyContent = const TabBarStarWars();

  changeBodyContent(Widget newBodyContent){
    setState(() {
      bodyContent = newBodyContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: OutlinedButton(
                    onPressed: (){
                      if(bodyContent is SiteOficial || bodyContent is AvatarCustomize){
                        changeBodyContent(const TabBarStarWars());
                      }
                      else{
                        changeBodyContent(const SiteOficial());
                      }
                    }, 
                    child: const Text('Site Oficial')
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: TextButton(
                    onPressed: ()=>{
                      if(bodyContent is AvatarCustomize || bodyContent is SiteOficial){
                        changeBodyContent(const TabBarStarWars())
                      }
                      else{
                        changeBodyContent(const AvatarCustomize())
                      }
                    },
                    child: const Avatar()
                  ), 
                ),
              ],
            ),
          ),
          bodyContent
        ]
      )
    );
  }
}

