import 'package:flutter/material.dart';
import 'package:untitled1/models/userModel.dart';
import 'package:untitled1/screens/LocationScreens/lokasyonDuzenle.dart';
import 'package:untitled1/screens/UserScreens/kullaniciDuzenle.dart';
import 'package:untitled1/screens/havaDurumu.dart';
import 'package:untitled1/screens/userLogScreen.dart';

class Islemler extends StatefulWidget {
  var user = Users();
  Islemler(user) {
    this.user = user;
  }
  @override
  State<StatefulWidget> createState() {
    return _IslemlerState(user);
  }
}

class _IslemlerState extends State {
  var user = Users();
  _IslemlerState(user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Text("İşlem Seçiniz"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
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
        elevation: 4,
        margin: EdgeInsets.all(10),
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LokasyonDuzenle()),
                (Route<dynamic> route) => true);
          },
          title: Text("Lokasyon Düzenle"),
        ),
      ),

      Card(
        color: Colors.redAccent.shade200,
        elevation: 4,
        margin: EdgeInsets.all(10),
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => KullaniciDuzenle()),
                (Route<dynamic> route) => true);
          },
          title: Text("Kullanıcı Düzenle"),
        ),
      ),
    ];

    var defaultCards = [
      Card(
        color: Colors.redAccent.shade200,
        elevation: 4,
        margin: EdgeInsets.all(10),
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HavaDurumuSorgu(user)),
                (Route<dynamic> route) => true);
          },
          title: Text("Hava Durumu"),
        ),
      ),
      Card(
        color: Colors.deepPurple.shade300,
        elevation: 4,
        margin: EdgeInsets.all(10),
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ULogScreen()),
                    (Route<dynamic> route) => true);
          },
          title: Text("Raporlar(Kullanıcı Logları)"),
        ),
      )
    ];

    if (user.userAdminStatus == 1) {
      return Expanded(
        child: ListView(
          children: [
            defaultCards[0],
            adminCards[0],
            adminCards[1],
            defaultCards[1],
          ],
        ),
      );
    } else {
      print(user.userAdminStatus);
      return Expanded(
        child: ListView(
          children: [
            defaultCards[0],
            defaultCards[1],
          ],
        ),
      );
    }
  }
}
