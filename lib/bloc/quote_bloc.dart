import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'quote_event.dart';
import 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
    on<FetchQuoteEvent>(_onFetchQuoteEvent);
    on<ResetQuoteEvent>(_onResetQuoteEvent);
  }

  Future<void> _onFetchQuoteEvent(FetchQuoteEvent event, Emitter<QuoteState> emit) async {
    emit(QuoteLoading());
    try {
      final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final quote = data[0]['q'];
        emit(QuoteLoaded(quote));
      } else {
        emit(QuoteError('Failed to fetch quote'));
      }
    } catch (e) {
      emit(QuoteError('Connection error'));
    }
  }

  void _onResetQuoteEvent(ResetQuoteEvent event, Emitter<QuoteState> emit) {
    emit(QuoteInitial());
  }
}