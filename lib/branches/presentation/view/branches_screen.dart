import 'package:flutter/material.dart';
import 'package:coffy_shell/branches/presentation/mvvm/branches_view_model.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  late final BranchesViewModel branchesViewModel;

  @override
  void initState() {
    super.initState();
    branchesViewModel = BranchesViewModel();
    branchesViewModel.fetchBranches();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: branchesViewModel,
      builder: (context, child) {
        if (branchesViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: branchesViewModel.branches.length,
          itemBuilder: (context, index) {
            final branch = branchesViewModel.branches[index];
            return ListTile(title: Text(branch.name ?? ''));
          },
        );
      },
    );
  }
}
