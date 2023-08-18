import 'package:cached_network_image/cached_network_image.dart';
import 'package:doonung/controllers/auth_controller.dart';
import 'package:doonung/utils/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: MyTheme.appBarColor));
    String? picUrl = AuthController.instance.user!.photoURL;
    picUrl = picUrl ?? Constants.dummyAvatar;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: picUrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
