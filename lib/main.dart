import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_login/Anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool>oturumKontrol() async {


    var sp = await SharedPreferences.getInstance();


      String spKullaniciAdi = sp.getString("KullaniciAdi") ?? "Kullanıcı adı yok";
      String spSifre = sp.getString("Sifre") ?? "şifre yok" ;

      if(spKullaniciAdi == "admin" && spSifre == "123"){
        return true;
      }else{
       return false;
      }


  }


  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context,snapshot){
          if(snapshot.hasData){
              bool? gecisIzni = snapshot.data;
              return gecisIzni ? Anasayfa() : LoginEkrani();
          }else{
            return Container();
          }
        },
      ),
    );
  }
}

class LoginEkrani extends StatefulWidget {


  @override
  State<LoginEkrani> createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {

  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void>girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if(ka == "admin" && s == "123"){

      var sp = await SharedPreferences.getInstance();
      sp.setString("kullaniciadi", ka);
      sp.setString("şifre", s);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Anasayfa()));

    }else{

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Login Ekranı"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              TextField(
                controller: tfKullaniciAdi ,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                ),
              ),
              TextField(
                obscureText: true,
                controller: tfSifre,
                decoration: InputDecoration(
                  hintText: "Şifre",
                ),
              ),

              ElevatedButton(
                child: Text("Giriş Yap"),
                onPressed: (){
                    girisKontrol();
                },
              ),

            ],
          ),
        ),
      ),

    );
  }
}
