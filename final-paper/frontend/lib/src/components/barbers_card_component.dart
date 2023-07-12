import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BarbersCard extends StatefulWidget {
  const BarbersCard({
    super.key,
  });

  @override
  State<BarbersCard> createState() => _BarbersCardState();
}

class _BarbersCardState extends State<BarbersCard> {
  var profileImage = '';
  getProfileImage() async {
    final firebaseStorage = FirebaseStorage.instance.ref();
    final imageRef = await firebaseStorage
        .child('berbers_profile/barber.png')
        .getDownloadURL();
    setState(() {
      profileImage = imageRef;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: profileImage == ''
                    ? const CircularProgressIndicator()
                    : CircleAvatar(
                        minRadius: 40,
                        // backgroundImage: AssetImage('assets/barber.png'),
                        backgroundImage: NetworkImage(profileImage),
                      ),
              )
            ],
          ),
          Wrap(
            children: List.generate(
                6,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: FilledButton(
                        onPressed: () {},
                        child: Text(
                            '${(09 + index).toString().padLeft(2, '0')}:00'),
                      ),
                    ),
                growable: true),
          )
        ],
      ),
    );
  }
}
