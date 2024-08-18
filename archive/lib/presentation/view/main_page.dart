import 'dart:async';

import 'package:android_studyjams/presentation/controller/main_controller.dart';
import 'package:android_studyjams/presentation/widget/autocomplete_options.dart';
import 'package:android_studyjams/presentation/widget/text_input.dart';
import 'package:android_studyjams/utils/dimensions.dart';
import 'package:android_studyjams/utils/profile_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MainPage extends GetResponsiveView<MainController> {
  MainPage({super.key});

  bool isUsername(String s) => hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.-]+[a-zA-Z0-9]$');

  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  FutureOr<Iterable<String>> _buildOptions(textEditingValue) {
    final options = [
      'https://g.dev/',
      'https://developers.google.com/profile/u/'
    ];

    // if (textEditingValue.text.isEmpty) {
    //   return const Iterable<String>.empty();
    // }

    if (isUsername(ProfileUtils.getUsername(textEditingValue.text))) {
      return [
        ProfileUtils.getUsername(textEditingValue.text),
        ...options
            .map((option) =>
        '$option${ProfileUtils.getUsername(textEditingValue.text)}')
            .toList(),
      ];
    }

    return options;
  }

  @override
  Widget? phone() {
    // TODO: implement phone
    return super.phone();
  }

  @override
  Widget? desktop() {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 584,
            minWidth: 396,
          ),
          child: Material(
            elevation: 8.0,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Autocomplete<String>(
              optionsBuilder: _buildOptions,
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) => TextInput(
                controller: textEditingController,
                focusNode: focusNode,
                onEditingComplete: onFieldSubmitted,
              ),
              optionsViewBuilder: (context, onSelected, options) {
                return Material(
                  elevation: 8.0,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 584,
                      minWidth: 396,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        return InkWell(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Builder(builder: (BuildContext context) {
                            final bool highlight =
                                AutocompleteHighlightedOption.of(context) == index;
                            if (highlight) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((Duration timeStamp) {
                                Scrollable.ensureVisible(context, alignment: 0.5);
                              });
                            }
                            return Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.m,
                                horizontal: Dimensions.m,
                              ),
                              child: Text(RawAutocomplete.defaultStringForOption(option)),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
