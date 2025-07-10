import 'dart:async';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DownTimerComponent extends StatefulWidget {
  Function? onTimeEnd;
  int cout = 15;
  int startTime = 15;
  String label = "";
  DownTimerComponent({
    super.key,
    this.onTimeEnd,
    this.startTime = 10,
    this.label = "",
  });

  @override
  State<DownTimerComponent> createState() => _DownTimerState();
}

class _DownTimerState extends State<DownTimerComponent> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _startCountdown();
    widget.cout = widget.startTime;
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.cout == 0) {
        //timer.cancel();
        if (widget.onTimeEnd != null) {
          widget.onTimeEnd!();
          _timer?.cancel();
        }
      } else {
        setState(() {
          widget.cout--;
        });
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              widget.cout.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(value: widget.cout / widget.startTime),
              Text(widget.label),
            ],
          ),
        ),
      ],
    );
  }
}
