import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Odontologia',
            style: TextStyle(color: Colors.deepPurple, fontSize: 25),
          ),
        ),
        leading: Icon(
          Icons.dehaze_rounded,
          color: Colors.deepPurple,
          size: 35,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.deepPurple,
              size: 35,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                this._Welcome(),
                this._CardCitas(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _Welcome() {
    return Container();
  }

  Widget _CardCitas() {
    return Container();
  }
}
