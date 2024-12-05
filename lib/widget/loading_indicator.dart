import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading; // 로딩 상태 여부
  final Widget child; // 로딩 중에도 보여줄 메인 화면

  const LoadingIndicator({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // 메인 화면
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3), // 반투명 배경
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
