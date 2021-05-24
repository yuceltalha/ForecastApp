import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';

class Islemler extends StatefulWidget {
  var user = Users();
  Islemler(user){
    this.user;
  }
  @override
  State<StatefulWidget> createState() {
    return _IslemlerState(user);
  }
}

class _IslemlerState extends State {
  var user = Users();
  _IslemlerState(caller){this.user;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Text("İşlem Seçiniz"),
      ),
      body: Container(
        child: Column(
          children: [
           menuItems(),
            ],
        ),
      ),
    );
  }

  menuItems() {
    var adminCards = [
      Card(
        color: Colors.deepPurple.shade300,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Islemler(users)),
                    (Route<dynamic> route) => true);
          },
          title: Text("Lokasyon Düzenle"),
        ),
      ),
      Card(
        color: Colors.deepPurple.shade300,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Islemler(users)),
                    (Route<dynamic> route) => true);
          },
          title: Text("Kullanıcı Düzenle"),
        ),
      ),
    ];
    var defaultCards = [
      Card(
        color: Colors.redAccent.shade200,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Islemler(users)),
                    (Route<dynamic> route) => true);
          },
          title: Text("Hava Durumu"),
        ),
      ),
      Card(
        color: Colors.redAccent.shade200,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Islemler(users)),
                    (Route<dynamic> route) => true);
          },
          title: Text("Raporlar"),
        ),
      ),

    ];
    if(user.userAdminStatus == 1){
      return ListView(
        children: [
          defaultCards[0],
          adminCards[0],
          defaultCards[1],
          adminCards[1],
        ],
      );
    }
    else{
      return ListView(
        children: [
          defaultCards[0],
          defaultCards[1],
        ],
      );
    }
  }
}
