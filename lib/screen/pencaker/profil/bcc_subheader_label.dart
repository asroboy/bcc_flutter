import 'package:flutter/material.dart';

class BccSubheaderLabel extends StatelessWidget {
  const BccSubheaderLabel(
      {super.key,
      required this.label,
      this.showButton,
      this.onPressed,
      this.icon});

  final String label;
  final bool? showButton;
  final Function()? onPressed;
  final IconData? icon;

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
                    shape: const WidgetStatePropertyAll(CircleBorder()),
                    elevation: const WidgetStatePropertyAll(0),
                    iconColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.primary),
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return const Color.fromARGB(255, 89, 133, 208);
                      }
                      return Colors.white;
                    })),
                child: Icon(
                  icon ?? Icons.add,
                  size: 16,
                ),
              )
            : const Center()
      ],
    );
  }
}
