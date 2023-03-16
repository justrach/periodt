
//ignore: no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsSelection extends StatefulWidget {
  @override
  _RandomWordsSelectionState createState() => _RandomWordsSelectionState();
}

class _RandomWordsSelectionState extends State<RandomWordsSelection> {
  final _randomWords = generateRandomWords(6);
  final _selectedWords = <String>[];
  final _selectedWordColors = <Color>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            _randomWords.length,
                (index) {
              final word = _randomWords[index];
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_selectedWords.contains(word)) {
                      _selectedWords.remove(word);
                      _selectedWordColors.remove(Colors.green);
                    } else {
                      _selectedWords.add(word);
                      _selectedWordColors.add(Colors.green);
                    }
                  });
                },
                child: Text(word),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedWords.contains(word) ? Colors.green : null,
                ),
              );
            },
          ),
        ),
        // Display the selected words in the order they were pressed
        Text('Selected words: ${_selectedWords.join(', ')}'),
      ],
    );
  }
}

List<String> generateRandomWords(int count) {
  return List.generate(
    count,
        (index) => generateWordPairs().first.asPascalCase,
  );
}
