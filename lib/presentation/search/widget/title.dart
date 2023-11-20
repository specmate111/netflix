import 'package:flutter/cupertino.dart';

class SearchTextTitile extends StatelessWidget {
  final String title;
  const SearchTextTitile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
