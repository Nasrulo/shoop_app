import 'package:flutter/material.dart';
import 'package:shoop_app/app/constants/colors/app_colors.dart';

class FullPage extends StatelessWidget {
  final List<dynamic> imagesList;
  const FullPage({super.key, required this.imagesList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
            )),
      ),
      body: Column(
        children: [
          Text(
            '1/5',
            style: TextStyle(
              fontSize: 24,
              letterSpacing: 8,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: PageView(
              children: List.generate(imagesList.length, (index) {
                return InteractiveViewer(
                  transformationController: TransformationController(),
                  child: Image.network(
                    imagesList[index].toString(),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
//buttu
