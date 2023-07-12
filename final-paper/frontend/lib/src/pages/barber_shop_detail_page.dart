import 'package:flutter/material.dart';
import 'package:iBarber/src/components/barbers_card_component.dart';
import 'package:iBarber/src/models/barber_shop_model.dart';

class BarberShopDetailPage extends StatefulWidget {
  const BarberShopDetailPage({super.key});

  @override
  State<BarberShopDetailPage> createState() => _BarberShopDetailPageState();
}

class _BarberShopDetailPageState extends State<BarberShopDetailPage> {
  DateTime _dateTime = DateTime.now();
  showDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
    ).then((value) => {
          setState(() {
            _dateTime = value ?? _dateTime;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BarberShop;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(args.name),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                              '${(_dateTime.day).toString().padLeft(2, '0')}/${(_dateTime.month + 1).toString().padLeft(2, '0')}/${_dateTime.year}'),
                        ),
                        const Icon(Icons.calendar_month_rounded)
                      ],
                    ),
                    onPressed: () {
                      showDateTimePicker();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: List.generate(
                  100,
                  (index) => const SizedBox(
                    // height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BarbersCard(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
