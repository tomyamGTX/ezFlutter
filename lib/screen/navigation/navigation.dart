import 'dart:math' as math;

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:ez_flutter/providers/local.provider.dart';
import 'package:ez_flutter/providers/notification.provider.dart';
import 'package:ez_flutter/providers/sandbox.payment.provider.dart';
import 'package:ez_flutter/screen/navigation/blog.list.dart';
import 'package:ez_flutter/screen/navigation/update.profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../providers/auth.provider.dart';
import '../../widgets/drawer.home.dart';
import '../home/notification.screen.dart';
import 'home.dart';
import 'setting.dart';

class Navigation extends StatefulWidget {
  const Navigation(this.index, {Key? key}) : super(key: key);
  final int index;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with TickerProviderStateMixin {
  late int _bottomNavIndex = widget.index; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.home,
    Icons.format_list_bulleted_outlined,
    Icons.person,
    Icons.settings,
  ];
  late AnimationController _controller;
  late PageController _pageController;
  late AssetsAudioPlayer _assetsAudioPlayer;

  bool play = false;

  @override
  void initState() {
    super.initState();
    Provider.of<AppUser>(context, listen: false).getName();
    Provider.of<LocalProvider>(context, listen: false).getList();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _assetsAudioPlayer.open(
      Audio.network(
          "https://firebasestorage.googleapis.com/v0/b/emailandphoneauth-6ab6d.appspot.com/o/music%2Fmusic.mp3?alt=media&token=cbf3bf9d-8440-4e6f-ad77-e8f2732638df"),
      autoStart: false,
      showNotification: true,
    );
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _controller.stop();
    _pageController = PageController(initialPage: _bottomNavIndex);
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: ListTile(
          leading: AdvancedAvatar(
            image: AppUser.instance.user!.photoURL != null
                ? NetworkImage(AppUser.instance.user!.photoURL!)
                : null,
            size: 40,
            name: AppUser.instance.user!.photoURL != null
                ? null
                : AppUser.instance.user!.displayName ?? 'User',
            statusColor: Colors.green,
            foregroundDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          title: Text('${Provider.of<AppUser>(context).name}',
              style: themeStyle()),
        ),
        actions: [
          IconButton(
              onPressed: () {
                launchWhatsApp();
              },
              icon: const Icon(Icons.contact_support))
        ],
      ),
      body: DoubleBackToCloseApp(
        child: Consumer<NotificationProvider>(builder: (context, noti, child) {
          if (noti.bodyReceive == null &&
              noti.titleReceive == null &&
              noti.dateTime == null) {
            return Consumer<SandBoxPaymentProvider>(
                builder: (context, pay, child) {
              return PageView(
                controller: _pageController,
                children: const [
                  Home(),
                  SearchScreen(),
                  UpdateProfile(),
                  Setting(),
                ],
              );
            });
          }
          return const NotificationList();
        }),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: AvatarGlow(
              glowColor: Colors.blue,
              endRadius: 40.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: FloatingActionButton(
                onPressed: () async {
                  setState(() {});
                  play = !play;
                  if (play) {
                    _assetsAudioPlayer.play();
                    _controller.repeat();
                  } else {
                    _assetsAudioPlayer.stop();
                    _controller.stop();
                  }
                },
                child: Icon(
                  Icons.headphones,
                  color: Theme.of(context).primaryColorLight,
                ),
                //params
              ),
            ),
          );
        },
        animation: _controller,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: Theme.of(context).primaryColorLight,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor: Theme.of(context).primaryColor,
        splashColor: Theme.of(context).splashColor,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            _pageController.jumpToPage(_bottomNavIndex);
          });
        },
        //other params
      ),
    ));
  }

  TextStyle themeStyle() =>
      TextStyle(color: Theme.of(context).primaryColorLight);

  launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+6013-6595741',
      text: "Hey! I want to ask something related to EZFlutter App",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }
}
