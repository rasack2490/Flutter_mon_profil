import 'package:flutter/material.dart';
import 'Profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Profile myProfile = Profile(
    surname: 'Blackoder',
    name: 'Abdoul Razack Nana',
  );

  late TextEditingController surname;
  late TextEditingController name;
  late TextEditingController age;
  late TextEditingController secrete;
  bool showSecret = false;
  Map<String, bool> hobbies = {
    "Petanque": false,
    "Piscine": false,
    "Ski": false,
    "Cyclisme": false,
    "Football": false,
    "Tennis": false,
    "Volleyball": false,
    "Badminton": false,
    "Handball": false,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    surname = TextEditingController();
    name = TextEditingController();
    secrete = TextEditingController();
    age = TextEditingController();
    age.text = myProfile.age.toString();
    surname.text = myProfile.surname;
    name.text = myProfile.name;
    secrete.text = myProfile.secret;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    surname.dispose();
    name.dispose();
    secrete.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
              color: Colors.deepPurpleAccent.shade100,
              elevation: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(myProfile.setName()),
                    Text("Age: ${myProfile.setAge()}"),
                    Text("Taille: ${myProfile.setHeigth()}"),
                    Text("Genre: ${myProfile.genderString()}"),
                    Text("Hobbies: ${myProfile.setHobbies()}"),
                    Text(
                        "Language de programmation favori: ${myProfile.favoriteLang}"),
                    ElevatedButton(
                      onPressed: updateSecrete,
                      child: Text((showSecret)
                          ? "Masquer le secret"
                          : "Afficher le secret"),
                    ),
                    (showSecret)
                        ? Text(myProfile.secret)
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.deepPurpleAccent,
              thickness: 2,
            ),
            myTittle("Mes informations personnelles"),
            myTextField(controller: surname, hint: "Entrer votre prenom"),
            myTextField(controller: name, hint: "Entrer votre nom"),
            myTextField(
                controller: secrete,
                hint: "Dites nous un secret",
                isSecrte: true),
            myTextField(
                controller: age,
                hint: "Entrer votre age",
                type: TextInputType.number),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gender: ${myProfile.genderString()}"),
                Switch(
                  value: myProfile.gender,
                  onChanged: ((newBool) {
                    setState(() {
                      myProfile.gender = newBool;
                    });
                  }),
                ),
              ],
            ),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Taille: ${myProfile.setHeigth()}"),
                  Slider(
                      min: 0,
                      max: 250,
                      value: myProfile.height,
                      onChanged: ((newHeight) {
                        setState(() {
                          myProfile.height = newHeight;
                        });
                      }))
                ]),
            Divider(
              color: Colors.deepPurpleAccent,
              thickness: 2,
            ),
            myHobbies(),
            Divider(
              color: Colors.deepPurpleAccent,
              thickness: 2,
            ),
            myRadios()
          ],
        ),
      ),
    );
  }

  TextField myTextField(
      {required TextEditingController controller,
      required String hint,
      bool isSecrte = false,
      TextInputType type = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      keyboardType: type,
      obscureText: isSecrte,
      onSubmitted: (newValue) {
        updateUser();
      },
    );
  }

  updateUser() {
    setState(() {
      myProfile = Profile(
        surname: (surname.text != myProfile.surname)
            ? surname.text
            : myProfile.surname,
        name: (name.text != myProfile.name) ? name.text : myProfile.name,
        secret: secrete.text,
        gender: myProfile.gender,
        height: myProfile.height,
        favoriteLang: myProfile.favoriteLang,
        hobbies: myProfile.hobbies,
        age: int.parse(age.text),
      );
    });
  }

  updateSecrete() {
    setState(() {
      showSecret = !showSecret;
    });
  }

  Column myHobbies() {
    List<Widget> widgets = [myTittle("Mes hobbies")];
    hobbies.forEach((hobby, like) {
      Row r = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hobby),
            Checkbox(
                value: like,
                onChanged: (newBool) {
                  setState(() {
                    hobbies[hobby] = newBool ?? false;
                    List<String> str = [];
                    hobbies.forEach((key, value) {
                      if (value) {
                        str.add(key);
                      }
                    });
                    myProfile.hobbies = str;
                  });
                })
          ]);
      widgets.add(r);
    });
    return Column(
      children: widgets,
    );
  }

  Column myRadios() {
    List<Widget> w = [myTittle("Language preferer")];
    List<String> langs = [
      "Dart",
      "Java",
      "Kotlin",
      "Python",
      "PHP",
      "JavaScript",
      "C++",
      "C#",
      "Ruby",
      "Swift",
      "Scala",
      "Go",
      "Rust",
      "Elixir",
      "Erlang",
      "F#",
      "Haskell",
      "Julia",
      "Lisp",
    ];
    int index =
        langs.indexWhere((lang) => lang.startsWith(myProfile.favoriteLang));
    for (int x = 0; x < langs.length; x++) {
      Row r = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(langs[x]),
            Radio(
                value: x,
                groupValue: index,
                onChanged: (newValue) {
                  setState(() {
                    myProfile.favoriteLang = langs[newValue as int];
                  });
                })
          ]);
      w.add(r);
    }
    return Column(
      children: w,
    );
  }

  Text myTittle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.deepPurpleAccent,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
