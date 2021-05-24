import 'package:flutter/material.dart';

class LokasyonDuzenle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LokasyonDuzenleState();
  }
}

class _LokasyonDuzenleState extends State{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Islemler(users)),
                  (Route<dynamic> route) => true);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Lokasyonlar"),
      ),
      body: locListBuilder(),
    );
  }
  //api sorgularının nasıl gerçekleştiğini öğren
//lokasyon tablosu oluştur modelini yaz veritabnaını yaz default veri gir ekle
  locListBuilder() {
      return Expanded(
        child: ListView.builder(
            itemCount: degerim.length,
            itemBuilder: (BuildContext context, int pos) {
              return ListTile(
                title: Text(degerim[pos].productName +
                    " " +
                    degerim[pos].productPrice.toString() +
                    "₺"),
                onTap: () {
                  setState(() {
                    count++;
                    degerim.removeAt(pos);
                  });
                },
              );
            }),
      );
  }
}