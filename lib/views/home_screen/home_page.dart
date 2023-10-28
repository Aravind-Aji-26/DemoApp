import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sugandh/models/dummymodel.dart';
import 'package:sugandh/providers/homeProvider.dart';
import 'package:sugandh/views/homeDataScreen.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<DummyModel?>> _futureHomeData() async {
    return await Provider.of<HomeProvider>(context, listen: false)
        .fetchHomeData();
  }

  ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Widget _homePostWidget(id,title, body) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, HomeDataScreen.routeName,arguments: HomeDataScreen(id: id,));
      },
      child: Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: const EdgeInsets.only(right: 12.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child:  Text(
                  id.toString(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),

              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.linear_scale, color: Colors.yellowAccent),
                  const SizedBox(width: 10,),
                  Expanded(child: Text(body, style: const TextStyle(color: Colors.white)))
                ],
              ),
              trailing:
              const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
        ),
      ),
    );
  }


  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
    title: const Text('Demo App'),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _key,
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _futureHomeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  radius: 15,
                ),
              );
            } else {
              if (snapshot.hasData) {
                final homeData = snapshot.data as List<DummyModel>;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView.separated(
                      controller: _controller,
                      separatorBuilder: (ctx, ind) => const SizedBox(
                            width: 30,
                          ),
                      itemCount: homeData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _homePostWidget( homeData[index].id,
                            homeData[index].title, homeData[index].body);
                      }),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
