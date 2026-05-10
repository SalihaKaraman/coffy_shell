import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffy_shell/branches/data/model/branch_model.dart';
import 'package:coffy_shell/branches/domain/entity/branch.dart';

class BranchRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Branch>> getBranches() async {
    try {
      final snapshot = await _firestore.collection('branches').get();
      return snapshot.docs.map((doc) => BranchModel.fromMap(doc.data(), doc.id).toEntity()).toList();
    } catch (e) {
      print('BranchRepository Error: $e');
      return [];
    }
  }
}
