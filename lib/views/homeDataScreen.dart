import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sugandh/models/dummymodel.dart';
import 'package:sugandh/providers/homeProvider.dart';

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
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              homeData.id.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: Text(
                                homeData.title ?? '',
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
                          homeData.body ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
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
