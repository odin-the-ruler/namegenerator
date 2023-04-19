import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namegenerator/core/pallate/colors.dart';
import 'package:namegenerator/provider/providers.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              color: NameGeneratorColors.kLeftPannelColor,
              child: Center(
                child: Card(
                  child: ListTile(
                    title: Text(ref.watch(wordStateProvider)),
                    trailing: GestureDetector(
                      onTap: () {
                        final List<String> fevList = [
                          ...ref.watch(fevListStateProvider)
                        ];
                        !(ref
                                .watch(fevListStateProvider)
                                .contains(ref.watch(wordStateProvider)))
                            ? {
                                fevList.add(ref.watch(wordStateProvider)),
                                ref.read(fevListStateProvider.notifier).state =
                                    fevList,
                                log(ref.watch(fevListStateProvider).toString()),
                              }
                            : null;
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              color: NameGeneratorColors.kPannelColor,
              child: Center(
                child: Column(
                  children: [
                    // Fev List
                    Flexible(
                      flex: 6,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        itemCount: ref.watch(fevListStateProvider).length,
                        itemBuilder: (BuildContext context, int index) {
                          final String item =
                              ref.watch(fevListStateProvider)[index];
                          return FevWordTile(item: item);
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            ref.read(wordStateProvider.notifier).state =
                                WordPair.random().toString();
                            log(ref.read(wordStateProvider.notifier).state =
                                WordPair.random().toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: NameGeneratorColors.kbtnColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Generate',
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                // color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FevWordTile extends ConsumerWidget {
  const FevWordTile({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        item,
        textScaleFactor: 1.5,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: InkWell(
        onTap: () {
          final List<String> fevList = [...ref.watch(fevListStateProvider)];
          fevList.remove(item);
          ref.watch(fevListStateProvider.notifier).state = fevList;
        },
        child: const Icon(
          Icons.delete_outline_sharp,
          color: Colors.white38,
        ),
      ),
    );
  }
}
