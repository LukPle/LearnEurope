import 'dart:math';

String generateUUID() {
  final Random random = Random();
  final List<int> values = List<int>.generate(16, (i) => random.nextInt(256));

  values[6] = (values[6] & 0x0f) | 0x40;
  values[8] = (values[8] & 0x3f) | 0x80;

  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < values.length; i++) {
    if (i == 4 || i == 6 || i == 8 || i == 10) {
      buffer.write('-');
    }
    buffer.write(values[i].toRadixString(16).padLeft(2, '0'));
  }
  return buffer.toString();
}