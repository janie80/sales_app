import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';

class RoleBasedWidget extends StatelessWidget {
  final Widget adminWidget;
  final Widget salesRepWidget;

  const RoleBasedWidget({
    super.key,
    required this.adminWidget,
    required this.salesRepWidget,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Determine the role based on the current route or UI flow
    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute == '/admin_dashboard' || currentRoute == '/admin_login') {
      return adminWidget; // Show admin-specific widget
    } else if (currentRoute == '/sales_rep_dashboard' || currentRoute == '/sales_rep_login') {
      return salesRepWidget; // Show sales rep-specific widget
    } else {
      return const SizedBox.shrink(); // Hide if role cannot be determined
    }
  }
}