import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/colocation_model.dart';

class ColocationState {
  final AsyncValue<List<ColocationModel>> colocations;
  final bool isCreating;
  final String? createError;
  final String? generatedInviteCode;

  const ColocationState({
    required this.colocations,
    required this.isCreating,
    this.createError,
    this.generatedInviteCode,
  });

  factory ColocationState.initial() {
    return const ColocationState(
      colocations: AsyncLoading<List<ColocationModel>>(),
      isCreating: false,
    );
  }

  static const _noValue = Object();

  ColocationState copyWith({
    AsyncValue<List<ColocationModel>>? colocations,
    bool? isCreating,
    Object? createError = _noValue,
    Object? generatedInviteCode = _noValue,
  }) {
    return ColocationState(
      colocations: colocations ?? this.colocations,
      isCreating: isCreating ?? this.isCreating,
      createError: createError == _noValue
          ? this.createError
          : createError as String?,
      generatedInviteCode: generatedInviteCode == _noValue
          ? this.generatedInviteCode
          : generatedInviteCode as String?,
    );
  }
}
