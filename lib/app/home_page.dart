import 'package:flutter/material.dart';
import 'package:shoop_app/app/widgets/app_bar/search_widget.dart';

import 'suppliers/galleries/page.dart';
import 'widgets/tab_bar_widgets/repeated_tab_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const SearchWidget(),
            bottom: const TabBar(
              indicatorColor: Colors.yellow,
              indicatorWeight: 8,
              isScrollable: true,
              tabs: [
                RepeatedTabBarWidget(label: 'Men'),
                RepeatedTabBarWidget(label: 'Women'),
                RepeatedTabBarWidget(label: 'Accessories'),
                RepeatedTabBarWidget(label: 'Shoes'),
                RepeatedTabBarWidget(label: 'Bags'),
                RepeatedTabBarWidget(label: 'Kids'),
                RepeatedTabBarWidget(label: 'Home & Garden'),
                RepeatedTabBarWidget(label: 'Electronics'),
                RepeatedTabBarWidget(label: 'Beauty'),
              ],
            )),
        body: const TabBarView(children: [
          MenGallery(),
          WomenGallery(),
          AccessoriesGallery(),
          ShoesGallery(),
          BagsGallery(),
          KidsGallery(),
          HomeGardenGallery(),
          ElectronisGallery(),
          BeautyGallery(),
        ]),
      ),
    );
  }
}
