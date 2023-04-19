import 'package:english_words/english_words.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wordStateProvider = StateProvider<String>((ref) {
  return ref.read(wordProvider);
});

final wordProvider = Provider<String>((ref) {
  return WordPair.random().toString();
});

final fevListStateProvider = StateProvider<List<String>>((ref) => <String>[]);
