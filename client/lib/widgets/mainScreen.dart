import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wordle/widgets/menuScreen.dart' show MenuScreen;
import 'package:wordle/provider/accountProv.dart' show AccountProvider;
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final isDesktop = screenWidth > 600;
    // final accountProvider = Provider.of<AccountProvider>(
    //   context,
    //   listen: false,
    // );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? screenWidth * 0.5 : screenWidth * 0.9,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
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

                    SizedBox(height: screenHeight * 0.05),

                    // Name Input
                    TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Enter your name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.person),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideX(begin: -0.1, curve: Curves.easeOut),

                    SizedBox(height: screenHeight * 0.03),

                    // Submit Button with Loading State
                    Consumer<AccountProvider>(
                          builder: (context, provider, child) {
                            return FilledButton.tonal(
                              onPressed: provider.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await provider.login(
                                            _nameController.text,
                                          );
                                          if (mounted) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MenuScreen(),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          if (mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Error: ${e.toString()}',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: provider.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Continue'),
                            );
                          },
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
