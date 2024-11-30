import 'package:flutter/material.dart';

import '../../../../common/components/icon/osk_icon_button.dart';

class SearchIconButton extends StatelessWidget {
  final VoidCallback onSearchTap;
  final bool hasActiveSearch;

  const SearchIconButton({
    required this.onSearchTap,
    this.hasActiveSearch = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (hasActiveSearch)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        OskIconButton(
          icon: const Icon(
            Icons.saved_search,
          ),
          onTap: onSearchTap,
        ),
      ],
    );
  }
}
