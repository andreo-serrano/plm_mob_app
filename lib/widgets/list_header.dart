import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String title;
  final Function() onViewMore;

  const ListHeader({super.key, required this.title, required this.onViewMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          // TextButton(
          //   onPressed: onViewMore,
          //   child: const Text(
          //     'View more',
          //   ),
          // ),
        ],
      ),
    );
  }
}
