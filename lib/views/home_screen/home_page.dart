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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    id.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold,),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                body,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _key,
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
