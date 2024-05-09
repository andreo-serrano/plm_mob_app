import 'package:flutter/material.dart';

import '../model/news_model.dart';

class StudentNewsContainer extends StatelessWidget {
  final StudentNews news;

  const StudentNewsContainer({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  news.description == null
                      ? SizedBox.shrink()
                      : Text(
                          news.description!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
