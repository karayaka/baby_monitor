import 'dart:async';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewerTimerComponent extends StatefulWidget {
  final void Function(int)? tickTrigged;
  int? triggerSecond = 5;
  ViewerTimerComponent({this.tickTrigged, this.triggerSecond, super.key});

  @override
  State<ViewerTimerComponent> createState() => _ViewerTimerComponentState();
}

class _ViewerTimerComponentState extends State<ViewerTimerComponent> {
  int currntSecond = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  String get formattedTime {
    final minutes = currntSecond ~/ 60;
    final seconds = currntSecond % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currntSecond++;
      });
      if (widget.tickTrigged != null &&
          (currntSecond % (widget.triggerSecond ?? 5) == 0)) {
        widget.tickTrigged!(currntSecond);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(formattedTime);
  }
}
