import 'package:flutter/material.dart';

import '../../model/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  const NewsDetailPage(this.news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: news.type == 0
                      ? Theme.of(context).colorScheme.primary
                      : Color.fromARGB(255, 231, 181, 43),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    news.typeString,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                news.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                news.enteredOnString,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                news.description == null ? "" : news.description!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  news.imageURL,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
