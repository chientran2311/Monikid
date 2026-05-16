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
class FamilyManagementState with _$FamilyManagementState {
  const FamilyManagementState._();

  const factory FamilyManagementState({
    @Default(FamilyManagementStatus.initial) FamilyManagementStatus status,
    FamilyModel? family,
    @Default([]) List<FamilyMemberModel> members,
    @Default({}) Map<String, int?> monthlyLimits,
    String? errorMessage,
    @Default(false) bool isProcessing,
  }) = _FamilyManagementState;

  bool get isLoading => status == FamilyManagementStatus.loading;

  List<FamilyMemberModel> get activeMembers =>
      members.where((m) => m.status == 'active').toList();

  List<FamilyMemberModel> get childMembers =>
      activeMembers.where((m) => m.role == 'child').toList();

  List<FamilyMemberModel> get parentMembers =>
      activeMembers.where((m) => m.role == 'parent').toList();

  FamilyMemberModel? get nonHostParent {
    final parents = parentMembers;
    if (parents.isEmpty || family == null) return null;
    return parents.firstWhere(
      (p) => p.uid != family!.parentId,
      orElse: () => parents.first,
    );
  }
}
