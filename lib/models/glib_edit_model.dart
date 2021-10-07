import 'package:flutter/foundation.dart';

class GlibEditModel<T> extends ChangeNotifier {
  late T draft;
  late T complete;

  void save() {
    this.complete = this.draft;
    notifyListeners();
  }

  void cancel() {
    this.draft = this.complete;
    notifyListeners();
  }
}