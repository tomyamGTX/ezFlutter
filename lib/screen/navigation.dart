import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:ez_flutter/providers/local.provider.dart';
import 'package:ez_flutter/providers/sandbox.payment.provider.dart';
import 'package:ez_flutter/screen/mall.item.dart';
import 'package:ez_flutter/screen/search.dart';
import 'package:ez_flutter/screen/update.profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.provider.dart';
import '../widgets/drawer.home.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'Setting.dart';
import 'home.dart';

class Navigation extends StatefulWidget {
  const Navigation(this.index, {Key? key}) : super(key: key);
  final int index;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  late int _bottomNavIndex = widget.index; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.person,
    Icons.settings,
  ];

  late PageController _pageController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _note = TextEditingController();
  final _price = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<AppUser>(context, listen: false).getName();
    Provider.of<LocalProvider>(context, listen: false).getList();
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Welcome ${Provider.of<AppUser>(context).name}'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_rounded)),
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MallItem())),
              icon: const Icon(Icons.local_mall))
        ],
      ),
      body: DoubleBackToCloseApp(
        child: Consumer<SandBoxPaymentProvider>(builder: (context, pay, child) {
          return PageView(
            controller: _pageController,
            children: const [
              Home(),
              SearchScreen(),
              UpdateProfile(),
              Setting(),
            ],
          );
        }),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          await buildShowModalBottomSheet(context);
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).canvasColor,
        ),
        //params
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

  buildShowModalBottomSheet(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.monetization_on),
                title: const Text('Debt List'),
                onTap: () async {
                  Navigator.pop(context);

                },
              ),
            ],
          );
        });
  }
}
