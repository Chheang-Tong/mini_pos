import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList<String> suggestions = <String>[].obs;
  final List<String> history = [
    "sc10c pos",
    "facebook",
    "chatgpt",
    "app connect",
    "google translate",
    "pos sc10c sdk download",
    "missingpluginexception",
    "sdk printer sc10c pos"
  ];

  RxBool isDropdownVisible = false.obs;

  void updateSuggestions(String query) {
    if (query.isEmpty) {
      suggestions.value = history;
    } else {
      suggestions.value =
          history.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  void showDropdown() => isDropdownVisible.value = true;
  void hideDropdown() => isDropdownVisible.value = false;
}

class SearchPage extends StatelessWidget {
  final searchController = Get.put(SearchController());
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    searchController.updateSuggestions(""); // Show history by default

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        searchController.showDropdown();
      } else {
        searchController.hideDropdown();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              focusNode: focusNode,
              controller: textController,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) => searchController.updateSuggestions(value),
              onTap: () => searchController.showDropdown(),
            ),
          ),

          // Suggestions dropdown
          Obx(() => searchController.isDropdownVisible.value
              ? Expanded(
            child: ListView.builder(
              itemCount: searchController.suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = searchController.suggestions[index];
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(suggestion),
                  onTap: () {
                    textController.text = suggestion;
                    searchController.hideDropdown();
                    FocusScope.of(context).unfocus(); // close keyboard
                  },
                );
              },
            ),
          )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
