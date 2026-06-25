import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/bloc/counter_event.dart';
import 'package:src/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(count: 0)) {
    on<CounterIncreamentEvent>(
      (event, emit) => emit(CounterState(count: state.count+1))
    );

    on<CounterDecreamentEvent>(
      (event, emit) => emit(CounterState(count: state.count-1))
    );    
  }
}
