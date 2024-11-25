import 'package:flutter/material.dart';

class BccSubheaderLabel extends StatelessWidget {
  const BccSubheaderLabel(
      {super.key, required this.label, this.showButton, this.onPressed});

  final String label;
  final bool? showButton;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 7),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        showButton ?? false
            ? ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(CircleBorder()),
                    elevation: const MaterialStatePropertyAll(0),
                    iconColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary),
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(255, 89, 133, 208);
                      }
                      return Colors.white;
                    })),
                child: const Icon(Icons.add),
              )
            : const Center()
      ],
    );
  }
}
