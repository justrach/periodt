import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatrixSelectionState extends StateNotifier<String> {
  MatrixSelectionState() : super('Matrix A');

  void setMatrix(String matrix) {
    state = matrix;
  }
}

final matrixSelectionProvider =
StateNotifierProvider<MatrixSelectionState, String>((ref) {
  return MatrixSelectionState();
});