import 'package:flutter/material.dart';

class AddressButton extends StatefulWidget {
  const AddressButton({
    super.key,
  });

  @override
  State<AddressButton> createState() => _AddressButtonState();
}

class _AddressButtonState extends State<AddressButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rua Fictícia, 123',
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.edit_location_alt_rounded,
            ),
          ],
        ));
  }
}
