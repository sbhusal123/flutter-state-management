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
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: BlocProvider(
        create: (context)=> CounterBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page')
      )
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
            BlocBuilder<CounterBloc, CounterState>(
              buildWhen: (previousState, currentState){
                  print("Previous Value: ${previousState.count}");
                  print("Current State: ${currentState.count}");
                  if (currentState.count % 2 == 0) {
                    return true;
                  }
                  return false;
                // return true;
              },
              // bloc: counterBloc,
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
      floatingActionButton: Row(
        mainAxisAlignment: .center,
        children: [
          FloatingActionButton(
            onPressed: (){
              counterBloc.add(CounterIncreamentEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(width: 20,),
          FloatingActionButton(
            onPressed: (){
              counterBloc.add(CounterDecreamentEvent());
            },
            tooltip: 'Decreament',
            child: const Icon(Icons.remove),
          ),          
        ],
      )

    );
  }
}
