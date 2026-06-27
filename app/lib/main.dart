import 'package:app/bloc/user_bloc.dart';
import 'package:app/bloc/user_event.dart';
import 'package:app/bloc/user_state.dart';
import 'package:app/data/model/user_model.dart';
import 'package:app/data/provider/user_provider.dart';
import 'package:app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: MyHomePage()
      home: RepositoryProvider(
        create: (context) => UserRepository(UserProvider()),
        child: BlocProvider(
          create: (context) => UserBloc(context.read<UserRepository>()),
          child: MyHomePage()
        ),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repository Provider')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {

          // loading indicator on loading state
          if(state is UserLoadingState) {
            return Center(
              child: CircularProgressIndicator()
            );
          }

          // on error show error message
          if(state is UserErrorState) {
            return Center(
              child: Text("Error: ${state.error}")
            );
          }

          if(state is UserSucessState) {
            List<Datum> userList =  state.userModel.data;

            return userList.isNotEmpty?
            ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 4, horizontal: 8),
                child: Card(
                  child: ListTile(
                    title: Text(
                      "${userList[index].firstName.toString()} ${userList[index].lastName.toString()}"
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userList[index].avatar.toString())
                    ),
                    subtitle: Text(userList[index].email.toString()),
                  ),
                ),
              );
            })
            : Text("No Data Found");
          }

          return SizedBox();
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.read<UserBloc>().add(LoadUserEvent())},
        child: Icon(Icons.refresh),
      ),
    );
  }
}
