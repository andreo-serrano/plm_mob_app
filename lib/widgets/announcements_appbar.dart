import 'package:flutter/material.dart';

import '../model/news_model.dart';

class AnnouncementsSliverAppBar extends StatefulWidget {
  String pageTitle;
  News? featuredArticle;
  Function() onReadMore;
  Widget? child;

  AnnouncementsSliverAppBar({
    required this.pageTitle,
    required this.featuredArticle,
    required this.onReadMore,
    required this.child,
  });

  @override
  State<AnnouncementsSliverAppBar> createState() =>
      _AnnouncementsSliverAppBarState();
}

class _AnnouncementsSliverAppBarState extends State<AnnouncementsSliverAppBar> {
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 250;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: _scrollController, slivers: <Widget>[
      widget.featuredArticle != null
          ? SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35.0),
                  bottomRight: Radius.circular(35.0),
                ),
              ),
              elevation: 0,
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                title: _isShrink
                    ? Text(
                        widget.pageTitle,
                      )
                    : null,
                centerTitle: true,
                background: SafeArea(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35.0),
                            bottomRight: Radius.circular(35.0),
                          ),
                          child: Image.network(
                            widget.featuredArticle!.imageURL,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withAlpha(120),
                                Colors.black
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35.0),
                              bottomRight: Radius.circular(35.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: !_isShrink
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.featuredArticle!.typeString,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.featuredArticle
                                                  ?.enteredOnString ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          widget.featuredArticle!.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(color: Colors.white),
                                        ),
                                        const SizedBox(height: 10),
                                        OutlinedButton(
                                          onPressed: widget.onReadMore,
                                          child: Text(
                                            'Read More',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : SliverAppBar(),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: widget.child,
          ),
        ),
      ),
    ]);
  }
}
