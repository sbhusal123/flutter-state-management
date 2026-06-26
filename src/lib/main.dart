import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Counter Blocs
import 'package:src/bloc/counter/counter_bloc.dart';
import 'package:src/bloc/counter/counter_event.dart';
import 'package:src/bloc/counter/counter_state.dart';


// Visibility Blocs
import 'package:src/bloc/visibility/visibility_bloc.dart';
import 'package:src/bloc/visibility/visibility_event.dart';
import 'package:src/bloc/visibility/visibility_state.dart';


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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterBloc()),
          BlocProvider(create: (context) => VisibilityBloc())
        ],
        child: MyHomePage(title: "Flutter Demo Home Page"),
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
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            BlocBuilder<VisibilityBloc, VisibilityState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.show,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.indigoAccent,
                      child: Center(child: Text('Show'),),
                    ),
                  ),
                );
              },
            ),
            BlocListener<CounterBloc, CounterState>(
              listenWhen: (previous, current) {
                return true;
              },
              listener: (context, state) {
                if(state.count == 3){
                  final snackbar = SnackBar(
                    content: Text('Counter value is ${state.count}')
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              child: SizedBox(
                width: 0,
                height: 0,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: (){
              context.read<CounterBloc>().add(CounterIncreamentEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(width: 20,),
          FloatingActionButton(
            onPressed: (){
              context.read<CounterBloc>().add(CounterDecreamentEvent());
            },
            tooltip: 'Decreament',
            child: const Icon(Icons.remove),
          ),
          SizedBox(width: 20,),
          ElevatedButton(
            onPressed: () => {
              context.read<VisibilityBloc>().add(VisibilityShowEvent())
            },
            child: Text("Show")
          ),
          SizedBox(width: 20,),
          ElevatedButton(
            onPressed: () => {
              context.read<VisibilityBloc>().add(VisibilityHideEvent())
            },
            child: Text("Hide")
          ),       
        ],
      )
    );
  }
}
