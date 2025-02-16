import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/quote_bloc.dart';
import 'bloc/quote_event.dart';
import 'bloc/quote_state.dart';
import 'models/quote_model.dart';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.quote.quote,
                      style: TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '- ${state.quote.author}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (state is QuoteError) {
              return Text(state.error);
            }
            return Container();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Centra el botón
      floatingActionButton: Container(
        width: 200, // Ancho del botón
        height: 50, // Alto del botón
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), // Esquinas redondeadas
          color: Colors.purple[200], // Color morado claro
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            shadowColor: Colors.transparent, // Sin sombra
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
            ),
          ),
          onPressed: () {
            context.read<QuoteBloc>().add(FetchQuoteEvent());
          },
          child: Text(
            'Get New Quote',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white, // Texto en blanco
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}