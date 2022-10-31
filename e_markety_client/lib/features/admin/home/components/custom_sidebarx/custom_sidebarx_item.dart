import 'package:sidebarx/sidebarx.dart';

class CustomSidebarXItem extends SidebarXItem {
  const CustomSidebarXItem({
    super.onTap,
    super.icon,
    super.iconWidget,
    super.label,
    this.trailing = false,
    this.trailingItems,
  }) : super();

  // assert(
  // trailing && trailingItems != null,
  // 'if trailing is true, then trailingItems must not be empty',
  // )

  final bool trailing;
  final List<SidebarSubItem>? trailingItems;
}

class SidebarSubItem {
  const SidebarSubItem({
    required this.label,
    required this.onTap,
  });

  final String label;
  final void Function() onTap;
}
