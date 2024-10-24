class ScanState {}

class ScanInitial extends ScanState {}

class ScanLoadingState extends ScanState {}

class ScanSuccessState extends ScanState {}

class ScanErrorState extends ScanState {
  final String error;
  ScanErrorState(this.error);
}
