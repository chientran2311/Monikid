import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'parent_home_state.freezed.dart';

enum ParentHomeStatus { initial, loading, noFamily, hasFamily, error }

@freezed
abstract class ParentHomeState with _$ParentHomeState {
  const factory ParentHomeState({
    @Default(ParentHomeStatus.initial) ParentHomeStatus status,
    FamilyModel? family,
    @Default([]) List<FamilyMemberModel> members,
    String? selectedMemberId,
    @Default([]) List<TransactionModel> selectedMemberTransactions,
    @Default(0) int selectedMemberExpenseMinor,
    @Default(0) int selectedMemberIncomeMinor,
    @Default(0) int selectedMemberLimitMinor,
    @Default(false) bool isLoadingMemberData,
    @Default(false) bool isCreatingFamily,
    String? errorMessage,
  }) = _ParentHomeState;

  const ParentHomeState._();

  bool get hasFamily =>
      status == ParentHomeStatus.hasFamily && family != null;
  bool get isNoFamily => status == ParentHomeStatus.noFamily;
  bool get isLoading => status == ParentHomeStatus.loading;

  FamilyMemberModel? get selectedMember => selectedMemberId == null
      ? null
      : members.where((m) => m.uid == selectedMemberId).firstOrNull;
}
