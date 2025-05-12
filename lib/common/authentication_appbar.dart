import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthenticationAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const AuthenticationAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton.outlined(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.clear),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
