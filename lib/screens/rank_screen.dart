import 'package:flutter/material.dart';
import 'package:garbage_collector/models/models.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:garbage_collector/styles/color.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});
  @override
  State<RankScreen> createState() => _RankScreen();
}

class _RankScreen extends State<RankScreen> {
  List<Ranker> _rankers = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Ranker>> _loadRanker() async {
    _rankers = await Ranker.totalRank();
    return _rankers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadRanker(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      ColorSystem.primary,
                      Colors.white,
                    ],
                    stops: [
                      0.6,
                      1
                    ]),
              ),
              child: Column(
                children: [
                  TopThreeRanks(_rankers),
                  Flexible(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      child: Container(
                        color: Colors.white,
                        child: RankListView(rankers: _rankers),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class TopThreeRanks extends StatelessWidget {
  final List<Ranker> ranker;

  const TopThreeRanks(this.ranker, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Container(
          height: 50,
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber,
          ),
          child: const Text(
            "Weekly best!",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (ranker[1].profileImg == "")
                        ? const Icon(
                            Icons.account_circle_rounded,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            size: 80,
                          )
                        : CircularProfileImage(imgUrl: ranker[1].profileImg),
                    Text(
                      ranker[1].nickname,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ranker[1].totalScore.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(192, 192, 192, 1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 5.0,
                            offset: const Offset(5, 0),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "2nd",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (ranker[0].profileImg == "")
                        ? const Icon(
                            Icons.account_circle_rounded,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            size: 80,
                          )
                        : CircularProfileImage(imgUrl: ranker[0].profileImg),
                    Text(
                      ranker[0].nickname,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ranker[0].totalScore.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: 80,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 5.0,
                            offset: const Offset(5, 0),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "1st",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (ranker[2].profileImg == "")
                        ? const Icon(
                            Icons.account_circle_rounded,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            size: 80,
                          )
                        : CircularProfileImage(imgUrl: ranker[2].profileImg),
                    Text(
                      ranker[2].nickname,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ranker[2].totalScore.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: 80,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(240, 151, 101, 1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 5.0,
                            offset: const Offset(5, 0),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "3rd",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class RankListView extends StatelessWidget {
  final List<Ranker> rankers;
  const RankListView({required this.rankers, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemCount: rankers.length,
        itemBuilder: (context, index) {
          final ranker = rankers[index];
          if (index <= 2) {
            return const SizedBox.shrink();
          }
          return Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                width: 2,
                color: Color.fromRGBO(240, 242, 244, 1),
              ),
            )),
            height: 60,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 60,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: CircularProfileImage(
                        imgUrl: rankers[index].profileImg, size: 40),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      ranker.nickname,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      '${ranker.totalScore}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
