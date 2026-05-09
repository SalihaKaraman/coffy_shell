import 'package:coffy_shell/branches/domain/entity/branch.dart';

abstract class IBranchRepository {
  Future<List<Branch>> getBranches();
}
