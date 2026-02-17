import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/onboarding_data.dart';
import '../models/onboarding_model.dart';

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
  OnboardingViewModel()
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
}

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel, OnboardingState>((ref) {
      return OnboardingViewModel();
    });
