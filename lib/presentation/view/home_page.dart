import 'dart:async';
import 'dart:math';

import 'package:android_studyjams/presentation/controller/home_controller.dart';
import 'package:android_studyjams/presentation/widget/autocomplete_options.dart';
import 'package:android_studyjams/presentation/widget/custom_scaffold.dart';
import 'package:android_studyjams/presentation/widget/languages_dialog.dart';
import 'package:android_studyjams/utils/dimensions.dart';
import 'package:android_studyjams/utils/profile_utils.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetResponsiveView<HomeController> {
  HomePage({super.key});

  Future<void> _go(value) async {
    final username = ProfileUtils.getUsername(value);
    if (!GetUtils.isUsername(username)) return;
    await controller.getId(username);
    if (controller.state == null || controller.state!.isEmpty) return;
    Get.toNamed('/result/${controller.state}');
  }

  Widget _buildTextField(
    context,
    textEditingController,
    focusNode,
    onFieldSubmitted, {
    canRequestFocus = true,
    canSubmit = true,
    loading = false,
    errorText,
  }) {
    return TextField(
      canRequestFocus: canRequestFocus,
      controller: textEditingController,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      onEditingComplete: onFieldSubmitted,
      onSubmitted: (value) async {
        (focusNode as FocusNode).unfocus();
        await _go(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade900),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        errorText: errorText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Dimensions.m,
          horizontal: Dimensions.m,
        ),
        suffix: loading
            ? const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(),
                ),
              )
            : null,
        suffixIcon: loading
            ? null
            : Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: Dimensions.s,
                ),
                child: IconButton(
                  tooltip: AppStrings.done.tr,
                  icon: const Icon(Icons.check),
                  onPressed: canSubmit
                      ? () async {
                          (focusNode as FocusNode).unfocus();
                          await _go(textEditingController.text);
                        }
                      : null,
                ),
              ),
        hintText: AppStrings.inputHint.tr,
      ),
    );
  }

  Widget _buildFieldView(
    context,
    textEditingController,
    focusNode,
    onFieldSubmitted,
  ) {
    return controller.obx(
      (state) => _buildTextField(
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ),
      onError: (error) {
        return _buildTextField(
          context,
          textEditingController,
          focusNode,
          onFieldSubmitted,
          errorText: error,
        );
      },
      onEmpty: _buildTextField(
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ),
      onLoading: _buildTextField(
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
        loading: true,
      ),
    );
  }

  FutureOr<Iterable<String>> _buildOptions(textEditingValue) {
    final options = [
      'https://g.dev/',
      'https://developers.google.com/profile/u/'
    ];

    // if (textEditingValue.text.isEmpty) {
    //   return const Iterable<String>.empty();
    // }

    if (GetUtils.isUsername(ProfileUtils.getUsername(textEditingValue.text))) {
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
  Widget? desktop() {
    return CustomScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: max(constraints.maxWidth / 2, 584),
              ),
              child: Material(
                elevation: 4.0,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Autocomplete<String>(
                  optionsBuilder: _buildOptions,
                  fieldViewBuilder: _buildFieldView,
                  optionsViewBuilder: (context, onSelected, options) {
                    return AutocompleteOptions(
                      onSelected: onSelected,
                      options: options,
                      maxOptionsHeight: constraints.maxHeight / 3,
                      maxOptionsWidth: max(constraints.maxWidth / 2, 584),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showLanguagesDialog,
        tooltip: AppStrings.languages.tr,
        child: const Icon(Icons.language),
      ),
    );
  }

  @override
  Widget? phone() {
    return CustomScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth / 1.2,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Autocomplete<String>(
                  optionsBuilder: _buildOptions,
                  fieldViewBuilder: _buildFieldView,
                  optionsViewBuilder: (context, onSelected, options) {
                    return AutocompleteOptions(
                      onSelected: onSelected,
                      options: options,
                      maxOptionsHeight: constraints.maxHeight / 3,
                      maxOptionsWidth: constraints.maxWidth / 1.2,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showLanguagesDialog,
        tooltip: AppStrings.languages.tr,
        child: const Icon(Icons.language),
      ),
    );
  }
}
