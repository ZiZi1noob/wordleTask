import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wordle/widgets/menuScreen.dart' show MenuScreen;

// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});

//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _accountController = TextEditingController();

//   @override
//   void dispose() {
//     _accountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = MediaQuery.of(context).size.width > 600;

//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: isDesktop ? 300 : 24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Animated Title
//                 Text(
//                       'WORDLE',
//                       style: Theme.of(context).textTheme.displayLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 4,
//                       ),
//                     )
//                     .animate()
//                     .fadeIn(duration: 500.ms)
//                     .then(delay: 200.ms)
//                     .slideY(begin: -0.5, end: 0),

//                 const SizedBox(height: 40),

//                 // Account Input
//                 TextFormField(
//                   controller: _accountController,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your account',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     prefixIcon: const Icon(Icons.person),
//                     filled: true,
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your account';
//                     }
//                     return null;
//                   },
//                 ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.5, end: 0),

//                 const SizedBox(height: 24),

//                 // Submit Button
//                 FilledButton.tonal(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               MenuScreen(account: _accountController.text),
//                         ),
//                       );
//                     }
//                   },
//                   style: FilledButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text('Continue'),
//                 ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.5, end: 0),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? screenWidth *
                        0.5 // 桌面端：最大宽度 50%
                  : screenWidth * 0.9, // 移动端：最大宽度 90%
            ),
            child: Padding(
              padding: const EdgeInsets.all(24), // 内部留白
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Title
                    Text(
                          'WORDLE',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                              ),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .then(delay: 200.ms)
                        .slideY(begin: -0.1, curve: Curves.easeOut),

                    SizedBox(height: screenHeight * 0.05), // 5% 屏幕高度
                    // Account Input
                    TextFormField(
                          controller: _accountController,
                          decoration: InputDecoration(
                            labelText: 'Enter your account',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.person),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your account';
                            }
                            return null;
                          },
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideX(begin: -0.1, curve: Curves.easeOut),

                    SizedBox(height: screenHeight * 0.03), // 3% 屏幕高度
                    // Submit Button
                    FilledButton.tonal(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuScreen(
                                    account: _accountController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              50,
                            ), // 固定高度
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Continue'),
                        )
                        .animate()
                        .fadeIn(delay: 400.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOut),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
