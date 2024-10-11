import 'package:flutter/material.dart';
import 'dart:async';

import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'scan_option_configure_widget/scan_option_configure_widget.dart';

void main() => runApp( const MyApp() );

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CardDetails? _cardDetails;
  CardScanOptions scanOptions = const CardScanOptions(
    scanCardHolderName: true,
    // enableDebugLogs: true,
    validCardsToScanBeforeFinishingScan: 5,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
    ],
  );

  Future<void> scanCard() async {
    final CardDetails? cardDetails = await CardScanner.scanCard(scanOptions: scanOptions);
    if ( !mounted || cardDetails == null ) return;
    setState(() {
      _cardDetails = cardDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('credit_card_scanner app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  scanCard();
                },
                child: const Text('scan card'),
              ),
              Text('$_cardDetails'),
              Expanded(
                child: OptionConfigureWidget(
                  initialOptions: scanOptions,
                  onScanOptionChanged: (newOptions) => scanOptions = newOptions,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
