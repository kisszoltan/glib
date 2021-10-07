import 'package:flutter/foundation.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

abstract class GlibSearchModel extends ChangeNotifier {
  static const int kHistoryLength = 5;

  bool isLoading = false;
  List<dynamic> _suggestions = [];
  String query = '';
  FloatingSearchBarController? controller;

  List<dynamic> get suggestions =>
      _suggestions.isEmpty ? history : _suggestions;
  set suggestions(List<dynamic> list) => _suggestions = list;

  void onQueryChanged(String query) async {
    if (query == this.query) return;

    this.query = query;
    isLoading = true;
    notifyListeners();

    doQuery(query);

    isLoading = false;
    notifyListeners();
  }

  void saveQuery(String q) {
    if (q.isEmpty) return;
    if (history.contains(q)) {
      history.removeWhere((i) => i == q);
      saveQuery(q); // remove first, and then call ourself again
      return;
    }
    history.add(q);
    if (history.length > kHistoryLength) {
      history.removeRange(0, history.length - kHistoryLength);
    }

    notifyListeners();
  }

  void saveAndClose() {
    if (controller != null) {
      saveQuery(controller!.query);
      controller!.close();
    }
  }

  void clear() {
    _suggestions.clear();
    notifyListeners();
  }

  void doQuery(String query);
}

List<dynamic> history = [];
