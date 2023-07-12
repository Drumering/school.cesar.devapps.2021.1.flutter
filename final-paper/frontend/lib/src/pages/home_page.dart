import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iBarber/src/atoms/barber_shop_list_atom.dart';
import 'package:iBarber/src/components/address_button_component.dart';
import 'package:iBarber/src/models/barber_shop_model.dart';

import '../components/barber_shop_grid_view_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var barberShopRequest = [
    BarberShop(
      name: 'Spartani',
      profileImage: 'profileImage',
      favorite: false,
    ),
    BarberShop(
      name: 'Barbecue',
      profileImage: 'profileImage',
      favorite: false,
    ),
    BarberShop(
      name: 'BarberBaby',
      profileImage: 'profileImage',
      favorite: false,
    ),
    BarberShop(
      name: 'BarberBaby',
      profileImage: 'profileImage',
      favorite: false,
    ),
    BarberShop(
      name: 'BarberBaby',
      profileImage: 'profileImage',
      favorite: false,
    ),
    BarberShop(
      name: 'BarberBaby',
      profileImage: 'profileImage',
      favorite: false,
    ),
    BarberShop(
      name: 'BarberBaby',
      profileImage: 'profileImage',
      favorite: false,
    ),
  ];

  List<BarberShop> barbershops = [];
  Future getBarberShops() async {
    final db = FirebaseFirestore.instance.collection('barbershops');
    db.get().then((QuerySnapshot querySnapshot) => {
          setState(() {
            for (int i = 0; i < querySnapshot.docs.length; i++) {
              barberShopList.value.add(BarberShop.fromJson(
                  querySnapshot.docs[i].data() as Map<String, dynamic>));
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    if (barberShopList.value.isEmpty) {
      getBarberShops();
    }
    return Scaffold(
      body: SafeArea(
        child: barberShopList.value.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const AddressButton(),
                  BarberShopGridView(
                    barberShopList: barberShopList.value,
                  ),
                ],
              ),
      ),
    );
  }
}
