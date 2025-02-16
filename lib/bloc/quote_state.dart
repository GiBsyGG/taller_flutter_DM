abstract class QuoteState {}

class QuoteInitial extends QuoteState {
  final String message = "Get a new quote";
}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final String quote;

  QuoteLoaded(this.quote);
}

class QuoteError extends QuoteState {
  final String error;

  QuoteError(this.error);
}