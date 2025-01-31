import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // Firebase configuration file
import 'screens/auth/sales_rep_login_screen.dart'; // Sales Rep Login screen
import 'screens/auth/sales_rep_signup_screen.dart'; // Sales Rep Signup screen
import 'screens/auth/admin_login_screen.dart'; // Admin Login screen
import 'screens/admin/admin_dashboard.dart'; // Admin dashboard
import 'screens/admin/manage_products.dart'; // Manage products screen
import 'screens/admin/manage_customers.dart'; // Manage customers screen
import 'screens/admin/manage_orders.dart'; // Manage orders screen
import 'screens/admin/view_sales_data.dart'; // View sales data screen
import 'screens/sales_rep/sales_rep_dashboard.dart'; // Sales Rep dashboard
import 'screens/sales_rep/submit_data.dart'; // Submit data screen
import 'screens/common/profile_screen.dart'; // Profile screen
import 'screens/common/error_screen.dart'; // Error screen
import 'services/auth_service.dart'; // Authentication service
import 'services/firestore_service.dart'; // Firestore service
import 'services/user_provider.dart'; // User provider for state management

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load the .env file
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // User provider
        Provider(create: (_) => AuthService()), // Auth service
        Provider(create: (_) => FirestoreService()), // Firestore service
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RoleSelectionScreen(), // Start with the Role Selection Screen
      debugShowCheckedModeBanner: false,
      routes: {
        '/role_selection': (context) => const RoleSelectionScreen(),
        '/sales_rep_login': (context) => SalesRepLoginScreen(),
        '/sales_rep_signup': (context) => SalesRepSignUpScreen(),
        '/admin_login': (context) => AdminLoginScreen(),
        '/admin_dashboard': (context) => const AdminDashboard(),
        '/manage_products': (context) => const ManageProducts(),
        '/manage_customers': (context) => const ManageCustomers(),
        '/manage_orders': (context) => const ManageOrders(),
        '/view_sales_data': (context) => const ViewSalesData(),
        '/sales_rep_dashboard': (context) => const SalesRepDashboard(),
        '/submit_data': (context) => const SubmitData(),
        '/profile': (context) => const ProfileScreen(),
        '/error': (context) => const ErrorScreen(errorMessage: 'An error occurred'),
      },
    );
  }
}

// Role Selection Screen
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sales_rep_login');
              },
              child: const Text('Sales Rep'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_login');
              },
              child: const Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}