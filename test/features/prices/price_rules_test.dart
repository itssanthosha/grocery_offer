import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pricemate/core/utils/currency_formatter.dart';
import 'package:pricemate/features/prices/data/image_compressor.dart';
import 'package:pricemate/features/prices/domain/price_rules.dart';
import 'package:pricemate/features/prices/presentation/widgets/price_keypad.dart';

void main() {
  group('verification and flags', () {
    test('3 confirmations, or photo + 1', () {
      expect(isVerified(confirmations: 0, hasPhoto: false), isFalse);
      expect(isVerified(confirmations: 2, hasPhoto: false), isFalse);
      expect(isVerified(confirmations: 3, hasPhoto: false), isTrue);
      expect(isVerified(confirmations: 0, hasPhoto: true), isFalse);
      expect(isVerified(confirmations: 1, hasPhoto: true), isTrue);
    });

    test('3 flags hide', () {
      expect(isHiddenByFlags(2), isFalse);
      expect(isHiddenByFlags(3), isTrue);
    });
  });

  group('deviation', () {
    test('more than 50% away from the average needs confirmation', () {
      expect(deviatesTooMuch(1000, null), isFalse);
      expect(deviatesTooMuch(1500, 1000), isFalse); // exactly +50%
      expect(deviatesTooMuch(1501, 1000), isTrue);
      expect(deviatesTooMuch(499, 1000), isTrue);
      expect(deviatesTooMuch(500, 1000), isFalse);
    });

    test('average rounds and ignores empty', () {
      expect(averageBaisa(const []), isNull);
      expect(averageBaisa(const [1000, 1001]), 1001);
      expect(averageBaisa(const [450, 550]), 500);
    });
  });

  group('keypad maths', () {
    test('digits shift in from the right', () {
      var v = 0;
      for (final d in [1, 2, 5, 0]) {
        v = appendDigit(v, d);
      }
      expect(v, 1250);
      expect(formatOmr(v), 'OMR 1.250');
      expect(deleteDigit(v), 125);
      expect(deleteDigit(0), 0);
    });

    test('cannot exceed the maximum', () {
      expect(appendDigit(100000, 0), 1000000);
      expect(appendDigit(1000000, 0), 1000000);
      expect(appendDigit(999999, 9), 999999);
    });

    test('limits', () {
      expect(isValidPrice(0), isFalse);
      expect(isValidPrice(1), isTrue);
      expect(isValidPrice(1000000), isTrue);
      expect(isValidPrice(1000001), isFalse);
    });

    testWidgets('keypad buttons call back', (tester) async {
      final digits = <int>[];
      var deleted = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PriceKeypad(
              onDigit: digits.add,
              onDelete: () => deleted++,
              onClear: () {},
            ),
          ),
        ),
      );
      for (final k in ['key-1', 'key-0', 'key-00', 'key-delete']) {
        await tester.tap(find.byKey(ValueKey(k)));
      }
      expect(digits, [1, 0, 0, 0]);
      expect(deleted, 1);
    });
  });

  group('compressUnder', () {
    test('stops at the first encoding that fits', () async {
      final tried = <(int, int)>[];
      final out = await compressUnder((q, side) async {
        tried.add((q, side));
        return Uint8List(q == 50 ? 150 * 1024 : 400 * 1024);
      });
      expect(out!.length, 150 * 1024);
      expect(tried, [(80, 1280), (65, 1280), (50, 1280)]);
    });

    test('shrinks the side when quality alone is not enough', () async {
      final out = await compressUnder(
        (q, side) async => Uint8List(side == 800 ? 100 : 300 * 1024),
      );
      expect(out!.length, 100);
    });

    test('gives up with null', () async {
      expect(await compressUnder((q, s) async => Uint8List(999999)), isNull);
    });
  });
}
