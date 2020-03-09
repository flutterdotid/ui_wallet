import 'package:flutter/material.dart';
import 'package:page_view/model/User.dart';

class CardSendMoney extends StatelessWidget {
  CardSendMoney({this.user, Key key}) : super(key: key);
  User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        width: 120,
        height: MediaQuery.of(context).size.height * 150 / 896,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: SizedBox(
                height: 65,
                width: 65,
                child: CircleAvatar(
                  backgroundImage: AssetImage(user.avartar_assets),
                ),
              ),
            ),
            Text(
              user.name,
              style: TextStyle(
                  color: Color.fromRGBO(158, 158, 158, 1),
                  fontSize: 18,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CardAddMoney extends StatelessWidget {
  CardAddMoney({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        width: 120,
        height: MediaQuery.of(context).size.height * 150 / 896,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        print(MediaQuery.of(context).size);
                      },
                      heroTag: 'btnAddMoney',
                      child: Icon(Icons.add),
                      backgroundColor: Colors.blue,
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Add Money",
                style: TextStyle(
                    color: Color.fromRGBO(158, 158, 158, 1),
                    fontSize: 18,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
