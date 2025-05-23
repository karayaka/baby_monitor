import 'package:flutter/material.dart';

class OnLiveComonent extends StatefulWidget {
  const OnLiveComonent({super.key});

  @override
  State<OnLiveComonent> createState() => _OnLiveComonentState();
}

class _OnLiveComonentState extends State<OnLiveComonent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnim;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _colorAnim = ColorTween(
      begin: Colors.red,
      end: Colors.white,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.camera_indoor_rounded, size: 44, color: Colors.white),
        Positioned(
          top: 2,
          right: 2,
          child: AnimatedBuilder(
            animation: _colorAnim,
            builder: (context, child) {
              return Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _colorAnim.value,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
