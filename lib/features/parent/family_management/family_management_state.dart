import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';

part 'family_management_state.freezed.dart';

enum FamilyManagementStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

@freezed
abstract class FamilyManagementState with _$FamilyManagementState {
  const factory FamilyManagementState({
    @Default(FamilyManagementStatus.initial) FamilyManagementStatus status,
    FamilyModel? family,
    @Default([]) List<FamilyMemberModel> members,
    @Default({}) Map<String, int?> monthlyLimits,
    String? errorMessage,
    @Default(false) bool isProcessing,
  }) = _FamilyManagementState;

  const FamilyManagementState._();

  bool get isLoading => status == FamilyManagementStatus.loading;

  List<FamilyMemberModel> get childMembers =>
      members.where((m) => m.userRole == 'child').toList();

  List<FamilyMemberModel> get parentMembers =>
      members.where((m) => m.userRole == 'parent').toList();

  String? get hostUid => members.where((m) => m.isHost).firstOrNull?.uid;

  FamilyMemberModel? get nonHostParent {
    final host = hostUid;
    return parentMembers.where((p) => p.uid != host).firstOrNull;
  }

  /// Members ordered for the unified list: host first, then other parents,
  /// then children.
  List<FamilyMemberModel> get sortedMembers {
    int rank(FamilyMemberModel m) =>
        m.isHost ? 0 : (m.userRole == 'parent' ? 1 : 2);
    final list = [...members]..sort((a, b) => rank(a).compareTo(rank(b)));
    return list;
  }
}
