//ignore: no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'word_list_provider.dart';

class RandomWordsSelection extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
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
              return Consumer(builder: (context, ref, child) {
                // final wordListProvider2 = ref.watch(wordListProvider);
                // Future.microtask(() => ref.read(wordListProvider.state).state );
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_selectedWords.contains(word)) {
                        _selectedWords.remove(word);
                        _selectedWordColors.remove(Colors.greenAccent);
                        ref.read(selectedWordsProvider.notifier).removeWord(word);

                      } else {
                        _selectedWords.add(word);
                        _selectedWordColors.add(Colors.greenAccent);
                        ref.read(selectedWordsProvider.notifier).addWord(word);



                      }
                    });
                  },
                  child: Text(
                    word,
                    style: _selectedWords.contains(word)
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Color(0xff333333)


                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedWords.contains(word)
                        ? const Color(0xfff6cee3)
                        : null,
                  ),
                );
              });
            },
          ),
        ),
        // Display the selected words in the order they were pressed
        // Text('Selected words: ${_selectedWords.join(', ')}'),
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
