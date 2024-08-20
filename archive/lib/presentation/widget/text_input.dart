import 'package:android_studyjams/utils/dimensions.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // canRequestFocus: canRequestFocus,
      controller: controller,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      onEditingComplete: onEditingComplete,
      // onSubmitted: (value) async {
      //   (focusNode as FocusNode).unfocus();
      //   await _go(value);
      // },
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
        // errorText: errorText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Dimensions.m,
          horizontal: Dimensions.m,
        ),
        // suffix: loading
        //     ? const Padding(
        //   padding: EdgeInsets.only(right: 8.0),
        //   child: SizedBox(
        //     width: 16,
        //     height: 16,
        //     child: CircularProgressIndicator(),
        //   ),
        // )
        //     : null,
        // suffixIcon: loading
        //     ? null
        //     : Padding(
        //   padding: const EdgeInsetsDirectional.only(
        //     end: Dimensions.s,
        //   ),
        //   child: IconButton(
        //     tooltip: AppStrings.done.tr,
        //     icon: const Icon(Icons.check),
        //     onPressed: canSubmit
        //         ? () async {
        //       (focusNode as FocusNode).unfocus();
        //       await _go(textEditingController.text);
        //     }
        //         : null,
        //   ),
        // ),
        hintText: AppStrings.inputHint.tr,
      ),
    );
  }
}
