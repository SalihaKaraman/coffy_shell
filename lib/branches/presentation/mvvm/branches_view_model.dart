import 'package:flutter/material.dart';
import 'package:coffy_shell/branches/domain/entity/branch.dart';
import 'package:coffy_shell/branches/domain/use_case/get_branches_use_case.dart';

class BranchesViewModel extends ChangeNotifier {
  final _getBranchesUseCase = GetBranchesUseCase();

  bool loading = false;
  List<Branch> branches = [];

  Future<void> fetchBranches() async {
    loading = true;
    notifyListeners();

    branches = await _getBranchesUseCase();

    loading = false;
    notifyListeners();
  }
}
