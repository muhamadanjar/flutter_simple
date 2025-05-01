import 'package:equatable/equatable.dart';

import '../../domain/entities/training.dart';

class TrainingState extends Equatable{
  final bool isLoading;
  final bool isPaginating;
  final List<Training> trainings;
  final String? errorMessage;
  final int page;
  final bool hasMore;
  final String keyword;

  const TrainingState( {
     this.isLoading = false,
     this.trainings = const [],
    this.isPaginating = false,
    this.errorMessage,
    required this.page,
    required this.hasMore,
    required this.keyword,

  });

  TrainingState copyWith({
    bool? isLoading,
    List<Training>? trainings,
    String? error,
    bool? isPaginating,
    int? page,
    bool? hasMore,
    String? keyword,
  }) {
    return TrainingState(
      isLoading: isLoading ?? this.isLoading,
      trainings: trainings ?? this.trainings,
      isPaginating: isPaginating ?? this.isPaginating,
      errorMessage: error,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  List<Object?> get props => [isLoading, trainings, errorMessage, isPaginating, page, hasMore, keyword];

  factory TrainingState.initial() {
    return const TrainingState(
      isLoading: false,
      trainings: [],
      errorMessage: null,
      isPaginating: false,
      page: 1,
      hasMore: true,
      keyword: '',
    );
  }

}