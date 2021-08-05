import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomSliverAppBar({
    Key? key,
    required this.myTabs,
    required this.title,
  }) : super(key: key);

  final List<Tab> myTabs;
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      pinned: true,
      snap: true,
      floating: true,
      centerTitle: true,
      forceElevated: true,
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  const Icon(Icons.clear_all),
                  const SizedBox(width: 5.0),
                  const Text('Mark all as done'),
                ],
              ),
            ),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Icon(Icons.restore),
                    const SizedBox(width: 5.0),
                    const Text('Restart'),
                  ],
                )),
          ],
          offset: const Offset(0, 100),
        ),
      ],
      bottom: TabBar(
        tabs: myTabs,
        indicatorColor: Colors.blueAccent,
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }
}
