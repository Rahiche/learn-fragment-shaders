import 'package:flutter/material.dart';

class SlidingNumber extends StatefulWidget {
  const SlidingNumber({
    super.key,
    required this.number,
    required this.initialAnimation,
    this.style,
  });

  final int number;
  final bool initialAnimation;
  final TextStyle? style;

  @override
  State<SlidingNumber> createState() => _SlidingNumberState();
}

class _SlidingNumberState extends State<SlidingNumber>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    if (widget.initialAnimation) {
      _controller!.forward();
    } else {
      _controller!.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant SlidingNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.number != oldWidget.number) {
      _controller!.reset();
      _controller!.forward();
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -1.0),
    ).animate(_controller!);

    return ClipRRect(
      child: Stack(
        children: [
          if (widget.number > 0)
            SlideTransition(
              position: secondAnimation,
              child: Text((widget.number - 1).toString(), style: widget.style),
            ),
          SlideTransition(
            position: _animation!,
            child: Text(
              widget.number.toString(),
              style: widget.style,
            ),
          ),
        ],
      ),
    );
  }
}
