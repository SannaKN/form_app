// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//Original version of Form APp can be found here: https://flutter.github.io/samples/form_app.html
//This is modified with Finnish language and Accessibility features, such as Semantics and MergeSemantics

//import 'dart:async';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
//import 'package:flutter/gestures.dart';
//import 'package:url_launcher/url_launcher.dart';

class FormWidgetsDemo extends StatefulWidget {
  const FormWidgetsDemo({super.key});

  @override
  State<FormWidgetsDemo> createState() => _FormWidgetsDemoState();
}

class _FormWidgetsDemoState extends State<FormWidgetsDemo> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime date = DateTime.now();
  double maxValue = 0;
  bool? brushedTeeth = false;
  bool enableFeature = false;

  /* final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lomaketoiminnot'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Kirjoita nimesi...',
                            labelText: 'Nimi',
                          ),
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),

                        /*  TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Kirjoita kuvaus...',
                            labelText: 'Kuvaus',
                          ),
                          onChanged: (value) {
                            description = value;
                          },
                          maxLines: 5,
                        ), */
                        _FormDatePicker(
                          date: date,
                          onChanged: (value) {
                            setState(() {
                              date = value;
                            });
                          },
                        ),
                        MergeSemantics(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Arvioitu arvo',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              Text(
                                intl.NumberFormat.currency(
                                        symbol: "\€", decimalDigits: 0)
                                    .format(maxValue),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Slider(
                                min: 0,
                                max: 21,
                                divisions: 20,
                                value: maxValue,
                                onChanged: (value) {
                                  setState(() {
                                    maxValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        MergeSemantics(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                // title: semanticsLabel("Tehtävä suoritettu"),
                                value: brushedTeeth,
                                onChanged: (checked) {
                                  setState(() {
                                    brushedTeeth = checked;
                                  });
                                },
                              ),
                              Text('Tehtävä suoritettu',
                                  semanticsLabel:
                                      'Merkitse tehtävä suoritetuksi',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                        MergeSemantics(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Jaa vastaukset muille',
                                  semanticsLabel:
                                      'Anna toisten käyttäjien nähdä vastaukset',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Switch(
                                value: enableFeature,
                                onChanged: (enabled) {
                                  setState(() {
                                    enableFeature = enabled;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        /*                   Semantics(
                          child: const ElevatedButton(
                            onPressed: _launchUrl,
                            child: Text('Show Flutter homepage'),
                          ),
                        ), */
                      ].expand(
                        (widget) => [
                          widget,
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MergeSemantics(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Päiväys',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                intl.DateFormat.yMd().format(widget.date),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        OutlinedButton(
          child: const Text(
            'Muokkaa',
            semanticsLabel: 'Vaihda päivämäärä',
          ),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
