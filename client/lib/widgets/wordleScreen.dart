// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class WordleScreen extends StatefulWidget {
//   final bool isNewGame;

//   const WordleScreen({super.key, required this.isNewGame});

//   @override
//   State<WordleScreen> createState() => _WordleScreenState();
// }

// class _WordleScreenState extends State<WordleScreen> {
//   final List<String> _guesses = [];
//   final TextEditingController _guessController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isNewGame) {
//       // Initialize new game
//     } else {
//       // Load previous game
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WORDLE'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info_outline),
//             onPressed: _showHelpDialog,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Game Board
//             Expanded(
//               child: GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 5,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                 ),
//                 itemCount: 30, // 6 rows x 5 letters
//                 itemBuilder: (context, index) {
//                   final row = index ~/ 5;
//                   final col = index % 5;
//                   Color? color;

//                   if (row < _guesses.length) {
//                     // TODO: Add real evaluation logic
//                     color = Colors.grey.withOpacity(0.2);
//                   }

//                   return AnimatedContainer(
//                     duration: 300.ms,
//                     curve: Curves.easeOut,
//                     decoration: BoxDecoration(
//                       color: color,
//                       border: Border.all(
//                         color: Theme.of(context).colorScheme.outline,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(
//                       child: Text(
//                         row < _guesses.length && col < _guesses[row].length
//                             ? _guesses[row][col]
//                             : '',
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Input Area
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _guessController,
//                       maxLength: 5,
//                       textCapitalization: TextCapitalization.characters,
//                       decoration: InputDecoration(
//                         hintText: 'Enter 5-letter word',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         counterText: '',
//                       ),
//                       onChanged: (value) {
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   FloatingActionButton(
//                     onPressed: _guessController.text.length == 5
//                         ? _submitGuess
//                         : null,
//                     child: const Icon(Icons.send),
//                   ),
//                 ],
//               ),
//             ),

//             // Virtual Keyboard
//             Wrap(
//               spacing: 6,
//               runSpacing: 6,
//               children: 'QWERTYUIOPASDFGHJKLZXCVBNM'.split('').map((letter) {
//                 return SizedBox(
//                   width: 30,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     onPressed: () {
//                       if (_guessController.text.length < 5) {
//                         _guessController.text += letter;
//                         setState(() {});
//                       }
//                     },
//                     child: Text(letter),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _submitGuess() {
//     setState(() {
//       _guesses.add(_guessController.text.toUpperCase());
//       _guessController.clear();
//     });
//   }

//   void _showHelpDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('How to Play'),
//         content: const Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('• Guess the 5-letter word in 6 tries'),
//             Text('• Green: Correct letter in correct position'),
//             Text('• Yellow: Correct letter in wrong position'),
//             Text('• Gray: Letter not in word'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Got it!'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WordleScreen extends StatefulWidget {
  final bool isNewGame;

  const WordleScreen({super.key, required this.isNewGame});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  final List<String> _guesses = [];
  final TextEditingController _guessController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.isNewGame) {
      // Initialize new game
    } else {
      // Load previous game
    }
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final tileSize = isDesktop ? 70.0 : 50.0;
    final keyboardKeySize = isDesktop ? 50.0 : 40.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WORDLE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
            tooltip: 'How to play',
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: _restartGame,
            tooltip: 'New game',
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isDesktop ? 800 : 500),
          child: Column(
            children: [
              // Game Board
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isDesktop ? 30.0 : 16.0,
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: isDesktop ? 12 : 8,
                      crossAxisSpacing: isDesktop ? 12 : 8,
                      childAspectRatio: 1,
                    ),
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      final row = index ~/ 5;
                      final col = index % 5;
                      Color? color;
                      String letter = '';

                      if (row < _guesses.length && col < _guesses[row].length) {
                        letter = _guesses[row][col];
                        // TODO: Replace with actual evaluation logic
                        color = _getTileColor(letter, col);
                      }

                      return AnimatedContainer(
                        duration: 300.ms,
                        curve: Curves.easeOut,
                        decoration: BoxDecoration(
                          //   color: color ?? Colors.grey.shade100,
                          color: color ?? Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1.5,
                          ),
                          boxShadow: [
                            if (color != null)
                              BoxShadow(
                                color: color!.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            letter,
                            style: TextStyle(
                              fontSize: isDesktop ? 32 : 28,
                              fontWeight: FontWeight.bold,
                              color: color != null
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Input Area
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 100.0 : 16.0,
                  vertical: isDesktop ? 30.0 : 16.0,
                ),
                child: TextField(
                  focusNode: _focusNode,
                  controller: _guessController,
                  maxLength: 5,
                  textCapitalization: TextCapitalization.characters,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isDesktop ? 24 : 20,
                    letterSpacing: 2,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type your guess...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    counterText: '',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: _guessController.text.length == 5
                          ? _submitGuess
                          : null,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _guessController.text = value.toUpperCase();
                      _guessController.selection = TextSelection.collapsed(
                        offset: _guessController.text.length,
                      );
                    });
                  },
                  onSubmitted: (_) => _submitGuess(),
                ),
              ),

              // Virtual Keyboard
              Padding(
                padding: EdgeInsets.only(
                  bottom: isDesktop ? 40.0 : 20.0,
                  left: 16,
                  right: 16,
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: isDesktop ? 10 : 6,
                  runSpacing: isDesktop ? 12 : 8,
                  children: [
                    ...'QWERTYUIOP'
                        .split('')
                        .map(
                          (letter) =>
                              _buildKey(letter, keyboardKeySize, isDesktop),
                        ),
                    const SizedBox(width: 0, height: 12),
                    ...'ASDFGHJKL'
                        .split('')
                        .map(
                          (letter) =>
                              _buildKey(letter, keyboardKeySize, isDesktop),
                        ),
                    const SizedBox(width: 0, height: 12),
                    _buildSpecialKey('ENTER', keyboardKeySize * 1.5, isDesktop),
                    ...'ZXCVBNM'
                        .split('')
                        .map(
                          (letter) =>
                              _buildKey(letter, keyboardKeySize, isDesktop),
                        ),
                    _buildSpecialKey('⌫', keyboardKeySize * 1.5, isDesktop),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKey(String letter, double size, bool isDesktop) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: EdgeInsets.zero,
        ),
        onPressed: () => _handleKeyPress(letter),
        child: Text(
          letter,
          style: TextStyle(
            fontSize: isDesktop ? 22 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey(String label, double width, bool isDesktop) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () => _handleKeyPress(label),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _handleKeyPress(String key) {
    if (key == 'ENTER') {
      _submitGuess();
    } else if (key == '⌫') {
      if (_guessController.text.isNotEmpty) {
        _guessController.text = _guessController.text.substring(
          0,
          _guessController.text.length - 1,
        );
      }
    } else if (_guessController.text.length < 5) {
      _guessController.text += key;
    }
    setState(() {});
  }

  Color? _getTileColor(String letter, int position) {
    // TODO: Replace with actual evaluation logic from backend
    // Mock implementation for UI demonstration
    if (letter == 'F' && position == 0) return Colors.green;
    if (letter == 'L') return Colors.amber;
    if (letter == 'U') return Colors.grey;
    return null;
  }

  void _submitGuess() {
    if (_guessController.text.length != 5) return;

    setState(() {
      _guesses.add(_guessController.text);
      _guessController.clear();
      _focusNode.requestFocus();
    });

    // TODO: Call backend API here
  }

  void _restartGame() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Game?'),
        content: const Text('Are you sure you want to start a new game?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _guesses.clear();
                _guessController.clear();
              });
              // TODO: Call backend to reset game
            },
            child: const Text('New Game'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Play'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHelpRow('🟩', 'Correct letter in correct position'),
              _buildHelpRow('🟨', 'Correct letter in wrong position'),
              _buildHelpRow('⬜', 'Letter not in word'),
              const SizedBox(height: 20),
              const Text(
                'Type a 5-letter word and press Enter to submit. '
                'You have 6 attempts to guess the hidden word.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpRow(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 16),
          Text(text),
        ],
      ),
    );
  }
}
