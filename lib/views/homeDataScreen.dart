import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dummymodel.dart';
import '../providers/homeProvider.dart';

class HomeDataScreen extends StatefulWidget {
  static const routeName = '/home-data-screen';
  final int? id;
  const HomeDataScreen({Key? key, this.id}) : super(key: key);

  @override
  State<HomeDataScreen> createState() => _HomeDataScreenState();
}

class _HomeDataScreenState extends State<HomeDataScreen> {

  HomeDataScreen get _args {
    final args = ModalRoute.of(context)!.settings.arguments as HomeDataScreen;
    return args;
  }

  Future<DummyModel?> _futureHomeDataById({required int? id}) async {
    return await Provider.of<HomeProvider>(context, listen: false)
        .fetchHomeDataById(id: id);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _key,
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: const Text('Data Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _futureHomeDataById(id: _args.id),
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
                final homeData = snapshot.data as DummyModel;
                return Card(
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
                            homeData.id.toString(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            homeData.title ?? '',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),

                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Icon(Icons.linear_scale, color: Colors.yellowAccent),
                            const SizedBox(width: 10,),
                            Expanded(child: Text(homeData.body ?? '', style: const TextStyle(color: Colors.white)))
                          ],
                        ),
                        trailing:
                        const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
                  ),
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
