import 'package:flutter/material.dart';

class RowShimmerWidget extends StatelessWidget {
  const RowShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skelton(
          height: 120,
          width: 120,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skelton(width: 80),
              const SizedBox(height: 8),
              const Skelton(),
              const SizedBox(height: 8),
              const Skelton(),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Expanded(
                    child: Skelton(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Skelton(),
                  ),
                ],
              ),
              // const SizedBox(height: 16),
            ],
          ),
        )
      ],
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          )),
    );
  }
}
