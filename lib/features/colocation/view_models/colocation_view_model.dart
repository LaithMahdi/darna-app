import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/colocation_model.dart';
import '../service/colocation_service.dart';
import 'colocation_state.dart';

final colocationServiceProvider = Provider<ColocationService>((ref) {
  return ColocationService();
});

final colocationViewModelProvider =
    StateNotifierProvider<ColocationViewModel, ColocationState>((ref) {
      final service = ref.watch(colocationServiceProvider);
      return ColocationViewModel(service);
    });

class ColocationViewModel extends StateNotifier<ColocationState> {
  final ColocationService _service;
  StreamSubscription<List<ColocationModel>>? _subscription;

  ColocationViewModel(this._service) : super(ColocationState.initial()) {
    _listenToColocations();
  }

  void _listenToColocations() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      state = state.copyWith(
        colocations: const AsyncData<List<ColocationModel>>(
          <ColocationModel>[],
        ),
      );
      return;
    }

    _subscription?.cancel();
    _subscription = _service
        .watchUserColocations(userId: currentUser.uid)
        .listen(
          (items) {
            state = state.copyWith(
              colocations: AsyncData<List<ColocationModel>>(items),
            );
          },
          onError: (Object error, StackTrace stackTrace) {
            state = state.copyWith(
              colocations: AsyncError<List<ColocationModel>>(error, stackTrace),
            );
          },
        );
  }

  Future<bool> createColocation({
    required String name,
    required int maxMembers,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      state = state.copyWith(createError: 'You must login first.');
      return false;
    }

    state = state.copyWith(
      isCreating: true,
      createError: null,
      generatedInviteCode: null,
    );

    final result = await _service.createColocation(
      name: name,
      maxMembers: maxMembers,
      createdBy: currentUser.uid,
    );

    return result.fold(
      (error) {
        state = state.copyWith(isCreating: false, createError: error);
        return false;
      },
      (colocation) {
        state = state.copyWith(
          isCreating: false,
          createError: null,
          generatedInviteCode: colocation.inviteCode,
        );
        return true;
      },
    );
  }

  Future<String?> addMemberByEmail({
    required String colocationId,
    required String email,
  }) async {
    final result = await _service.addMemberByEmail(
      colocationId: colocationId,
      email: email,
    );

    return result.fold((error) => error, (_) => null);
  }

  Future<Either<String, ColocationModel>> joinColocationByInviteCode({
    required String inviteCode,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Left('You must login first.');
    }

    return _service.joinColocationByInviteCode(
      inviteCode: inviteCode,
      userId: currentUser.uid,
    );
  }

  Future<String?> removeMember({
    required String colocationId,
    required String memberUserId,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return 'You must login first.';
    }

    final result = await _service.removeMember(
      colocationId: colocationId,
      adminUserId: currentUser.uid,
      memberUserId: memberUserId,
    );

    return result.fold((error) => error, (_) => null);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
