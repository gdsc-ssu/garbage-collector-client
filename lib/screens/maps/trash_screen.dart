import 'package:flutter/material.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({super.key});

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'type',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '재활용 쓰레기통에 버려주세요',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '내 주변 쓰레기통',
          style: TextStyle(color: Colors.white),
        ),
        Container(
          child: Text(
            '몰루',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          child: Text(
            '몰루',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          child: Text(
            '버리기',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
