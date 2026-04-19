import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_security_snapshot.freezed.dart';

@freezed
abstract class PinSecuritySnapshot with _$PinSecuritySnapshot {
  const factory PinSecuritySnapshot({
    String? pinCodeHash,
    @Default(0) int failedCount,
    DateTime? lockedUntil,
  }) = _PinSecuritySnapshot;

  const PinSecuritySnapshot._();

  bool get hasPinCode => pinCodeHash != null && pinCodeHash!.isNotEmpty;

  bool get isLocked {
    final until = lockedUntil;
    return until != null && until.isAfter(DateTime.now());
  }

  int get remainingLockSeconds {
    final until = lockedUntil;
    if (until == null) {
      return 0;
    }

    final milliseconds = until.difference(DateTime.now()).inMilliseconds;
    if (milliseconds <= 0) {
      return 0;
    }

    return ((milliseconds + 999) / 1000).floor();
  }
}
