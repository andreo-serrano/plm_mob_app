import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  String text = '';
  String image = 'assets/images/plmimage.png';
  Widget? child;
  bool isCenter;

  CustomSliverAppBar({
    required this.text,
    required this.image,
    required this.child,
    required this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35.0),
              bottomRight: Radius.circular(35.0),
            ),
          ),
          pinned: true,
          expandedHeight: 180.0,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35.0),
                  bottomRight: Radius.circular(35.0),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0),
                  ),
                ),
              ),
              FlexibleSpaceBar(
                title: Text(
                  text,
                  style: TextStyle(fontSize: 21.0),
                ),
                centerTitle: isCenter,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(child: child),
      ],
    );
  }
}
