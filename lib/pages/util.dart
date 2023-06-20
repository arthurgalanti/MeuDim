import 'package:flutter/material.dart';

void erro(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent.withOpacity(0.4),
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

void sucesso(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.greenAccent.withOpacity(0.4),
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

String modifyLastComma(String input) {
  int lastDotIndex = input.lastIndexOf('.');

  if (lastDotIndex == -1) {
    input = input.replaceAll(',', '.');
    return input;
  } else {
    String part1 = input.substring(0, lastDotIndex + 1);
    String part2 = input.substring(lastDotIndex + 1);
    part1 = part1.replaceAll('.', '');
    part2 = part2.replaceAll(',', '.');
    print(('$part1'));
    print(('$part2'));
    print(('$part1$part2'));
    return ('$part1$part2');
  }
}
