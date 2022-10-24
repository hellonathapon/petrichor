import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchScreen._());
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  // important when using any kind of Controller, always dispose it to release memory allocation.
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Wrap GestureDetecture to hide soft input keyboard when clicking the screen
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('City Search'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'City name',
                  hintText: 'Luang Prabang',
                  prefixIcon: const Icon(
                    Icons.sunny_snowing,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pop(_text);
          },
          label: const Text(
            'Search',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
