import 'package:flutter/material.dart';

import '../../model/news_model.dart';
import 'announcement_detail_screen.dart';

class MoreNewsPage extends StatefulWidget {
  final String pageTitle;
  List<News> Function() loadNews;

  MoreNewsPage({
    super.key,
    required this.pageTitle,
    required this.loadNews,
  });

  @override
  State<MoreNewsPage> createState() => _MoreNewsPageState();
}

class _MoreNewsPageState extends State<MoreNewsPage> {
  List<News>? news;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  void loadNews() {
    news = widget.loadNews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: news == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: news!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(news![index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            news![index].imageURL,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news![index].title,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              news![index].description == null
                                  ? Container()
                                  : Text(
                                      news![index].description!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              const SizedBox(height: 10),
                              Text(
                                news![index].enteredOnString,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Color.fromARGB(255, 233, 233, 233),
                );
              },
            ),
    );
  }
}
