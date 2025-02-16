import '../models/quote_model.dart'; // Importa el modelo

abstract class QuoteState {}

class QuoteInitial extends QuoteState {
  final String message = "Get a new quote";
}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final QuoteModel quote;

  QuoteLoaded(this.quote);
}

class QuoteError extends QuoteState {
  final String error;

  QuoteError(this.error);
}