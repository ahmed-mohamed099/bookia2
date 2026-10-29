/// States used by Edit Profile and Update Password:
/// the user fills a form, presses a button, and waits for the result.
abstract class SubmitState {}

class SubmitInitial extends SubmitState {}

class SubmitLoading extends SubmitState {}

class SubmitSuccess extends SubmitState {}

class SubmitError extends SubmitState {
  final String message;

  SubmitError(this.message);
}
