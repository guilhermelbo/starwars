import 'package:flutter/material.dart';
import 'package:starwars/avatar_customize.dart';
import 'package:starwars/avatar.dart';

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  Widget bodyContent = const Text('testando');
  
  changeBodyContent(){
    setState(() {
      bodyContent = const AvatarCustomize();
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
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
                    onPressed: (){}, 
                    child: const Text('Site Oficial')
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: TextButton(
                    onPressed: ()=>{
                      changeBodyContent()
                    },
                    child: const Avatar()
                  ), 
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: TabBar(
              controller: tabController,
              labelColor: Colors.black,
              tabs: const [
                Tab(text: 'Filmes'),
                Tab(text: 'Personagens'),
                Tab(text: 'Favoritos'),
              ]
            ),
          ),
          SizedBox(
            height: 150,
            child: TabBarView(
              controller: tabController,
              children: const [
                Tab(text: 'text'),
                Tab(text: 'text 2'),
                Tab(text: 'text 3'),
              ]
            ),
          )
        ]
      )
    );
  }
}

