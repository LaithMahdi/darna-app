import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helper/cacher_helper.dart';
import '../../../core/providers/cache_provider.dart';
import '../../../routes/routes.dart';
import '../data/onboarding_data.dart';
import '../models/onboarding_model.dart';

/// State class for Onboarding
class OnboardingState {
  final int currentPage;
  final List<OnboardingModel> pages;
  final bool isLastPage;
  final bool isFirstPage;

  OnboardingState({
    required this.currentPage,
    required this.pages,
    required this.isLastPage,
    required this.isFirstPage,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingModel>? pages,
    bool? isLastPage,
    bool? isFirstPage,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
      isLastPage: isLastPage ?? this.isLastPage,
      isFirstPage: isFirstPage ?? this.isFirstPage,
    );
  }
}

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  final CacherHelper _cacherHelper;

  OnboardingViewModel(this._cacherHelper)
    : super(
        OnboardingState(
          currentPage: 0,
          pages: onboardingData,
          isLastPage: false,
          isFirstPage: true,
        ),
      );

  void onPageChanged(int page) {
    state = state.copyWith(
      currentPage: page,
      isLastPage: page == state.pages.length - 1,
      isFirstPage: page == 0,
    );
  }

  void nextPage() {
    if (!state.isLastPage) {
      final nextPage = state.currentPage + 1;
      onPageChanged(nextPage);
    }
  }

  void previousPage() {
    if (!state.isFirstPage) {
      final previousPage = state.currentPage - 1;
      onPageChanged(previousPage);
    }
  }

  void skipToLast() {
    onPageChanged(state.pages.length - 1);
  }

  Future<void> completeOnboarding(BuildContext context) async {
    await _cacherHelper.setOnboardingCompleted(true);
    if (context.mounted) {
      context.go(Routes.login);
    }
  }
}

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel, OnboardingState>((ref) {
      final cacherHelper = ref.watch(cacherHelperProvider);
      return OnboardingViewModel(cacherHelper);
    });
