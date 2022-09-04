import 'package:flutter/material.dart';
import 'package:starwars/api_consumer.dart';
import 'package:starwars/database/db.dart';

class TabBarStarWars extends StatefulWidget {
  const TabBarStarWars({super.key});

  @override
  State<TabBarStarWars> createState() => _TabBarStarWarsState();
}

class _TabBarStarWarsState extends State<TabBarStarWars> with TickerProviderStateMixin{
  late TabController tabController;
  List movieList = [];
  List characterList = [];
  late Future<dynamic> futureFavorites;
  Map<String,int> favorites = <String,int>{};
  
  _TabBarStarWarsState(){
    ApiConsumer.fetchMovies().then((value)=>{
      setState((){
        movieList = value;
      })
    });
    ApiConsumer.fetchCharacters().then((value)=>{
      setState((){
        characterList = value;
      })
    });
    futureFavorites = loadFavoriteButtonIcon();
    futureFavorites.then((value)=>{
      for(var element in value){
        favorites.addAll({element['name']: element['num_border_color']})
      },
    });
  }

  @override
  initState(){
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  loadFavoriteButtonIcon() async {
    var db = await DB.instance.database;
    return db.rawQuery("SELECT name,num_border_color FROM favorites");
  }

  saveFavorite(String name, int numBorderColor) async{
    var db = await DB.instance.database;
    var favorites = await db.rawQuery("SELECT name FROM favorites");
    for(var element in favorites){
      if(element['name'] == name){
        return;
      }
    }
    db.insert('favorites', {'name': name, 'num_border_color': numBorderColor});
    setState(() {
      this.favorites.addAll({name: numBorderColor});
    });
    if(numBorderColor == 2){
      tabController.animateTo(1);
    }
  }

  removeFavorite(String name, int numBorderColor) async{
    var db = await DB.instance.database;
    db.delete('favorites', where: 'name = ?', whereArgs: [name]);
    setState(() {
      favorites.remove(name);
    });
    if(numBorderColor == 2){
      tabController.animateTo(1);
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          height: MediaQuery.of(context).size.height-200,
          width: MediaQuery.of(context).size.width-50,
          child: TabBarView(
            controller: tabController,
            children: [
              Tab(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int filme){
                    return ListTile(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Colors.black),
                      ),
                      title: Text(movieList[filme]),
                      trailing: IconButton(
                        onPressed: (){
                          if(favorites.containsKey(movieList[filme])){
                            removeFavorite(movieList[filme], 1);
                          }
                          else{
                            saveFavorite(movieList[filme], 1);
                          }
                        }, 
                        icon: FutureBuilder(
                          future: futureFavorites,
                          builder: (context, snapshot) {
                            if(favorites.containsKey(movieList[filme])){
                              return const Icon(Icons.favorite);
                            }
                            return const Icon(Icons.favorite_border_outlined);
                          },
                        )
                      ),
                    );
                  }, 
                  separatorBuilder: (_,__) => const Divider(), 
                  itemCount: movieList.length
                ),
              ),
              Tab(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int character){
                    return ListTile(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Colors.black),
                      ),
                      title: Text(characterList[character]),
                      trailing: IconButton(
                        onPressed: (){
                          if(favorites.containsKey(characterList[character])){
                            removeFavorite(characterList[character], 2);
                          }
                          else{
                            saveFavorite(characterList[character], 2);
                            tabController.animateTo(0);
                          }
                        }, 
                        icon: FutureBuilder(
                          future: futureFavorites,
                          builder: (context, snapshot) {
                            if(favorites.containsKey(characterList[character])){
                              return const Icon(Icons.favorite);
                            }
                            return const Icon(Icons.favorite_border_outlined);
                          },
                        )
                      ),
                    );
                  }, 
                  separatorBuilder: (_,__) => const Divider(), 
                  itemCount: characterList.length
                ),
              ),
              Tab(
                child: ListView.separated(
                  itemBuilder: (context, index){
                    Color color;
                    if(favorites.entries.elementAt(index).value == 1){
                      color = Colors.red;
                    }
                    else{
                      color = Colors.green;
                    }
                    return ListTile(
                      title: Text(favorites.entries.elementAt(index).key.toString()),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2, 
                          color: color,
                        ),
                      ),
                    );
                  }, 
                  separatorBuilder:  (_,__) => const Divider(), 
                  itemCount: favorites.length
                ),
              )
            ]
          ),
        )
      ],
    );
  }
}