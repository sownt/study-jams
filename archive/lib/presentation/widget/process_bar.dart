import 'package:flutter/material.dart';

class ProcessBar extends StatelessWidget {
  const ProcessBar({
    super.key,
    this.label,
    this.color,
    this.width,
    required this.value,
    required this.total,
    this.height,
    this.tooltip,
  });

  final int value;
  final int total;
  final double? width;
  final double? height;
  final String? label;
  final String? tooltip;
  final MaterialColor? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 300.0,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: value,
              child: Tooltip(
                message: '$value',
                child: Container(
                  decoration: BoxDecoration(
                    color: color ?? Colors.green,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(height ?? 4.0),
                      right: value >= total ? Radius.circular(height ?? 4.0) : Radius.zero,
                    ),
                  ),
                  height: height ?? 8.0,
                ),
              ),
            ),
            Flexible(
              flex: total - value,
              child: Tooltip(
                message: '${total - value}',
                child: Container(
                  decoration: BoxDecoration(
                    color: color?.shade100 ?? Colors.green.shade100,
                    borderRadius: BorderRadius.horizontal(
                      left: value == 0 ? Radius.circular(height ?? 4.0) : Radius.zero,
                      right: Radius.circular(height ?? 4.0),
                    ),
                  ),
                  height: height ?? 8.0,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            label != null
                ? Tooltip(
                    message: '$value/$total',
                    child: Text(
                      label!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : Text(
                    '$value/$total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }
}
