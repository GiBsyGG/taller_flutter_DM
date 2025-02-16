import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/quote_bloc.dart';
import 'bloc/quote_event.dart';
import 'bloc/quote_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      home: BlocProvider(
        create: (context) => QuoteBloc(),
        child: QuoteScreen(),
      ),
    );
  }
}

class QuoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<QuoteBloc>().add(ResetQuoteEvent());
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteInitial) {
              return Text(state.message);
            } else if (state is QuoteLoading) {
              return CircularProgressIndicator();
            } else if (state is QuoteLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.quote,
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state is QuoteError) {
              return Text(state.error);
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<QuoteBloc>().add(FetchQuoteEvent());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}