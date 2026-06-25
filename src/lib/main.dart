import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:src/bloc/counter_bloc.dart';
import 'package:src/bloc/counter_event.dart';
import 'package:src/bloc/counter_state.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            BlocBuilder<CounterBloc,CounterState>(
              bloc: counterBloc,
              builder: (context, state) {
                return Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          counterBloc.add(CounterIncreamentEvent());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
