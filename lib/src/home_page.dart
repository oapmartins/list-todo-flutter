import 'package:flutter/material.dart';
import 'package:integrando_api_flutter/src/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final controller = HomeControleer(null);

  _success() {
    return ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          var todo = controller.todos[index];
          return ListTile(
            leading: Checkbox(
              value: todo.completed,
              onChanged: (bool ) {},
            ),
            title: Text(todo.title.toString()),
          );
        });
  }

  _error() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          controller.start();
        },
        child: Text('Tentar novamente'),
      ),
    );
  }

  _loading() {
    return Center(
        child: CircularProgressIndicator()
    );
  }

  _start(){
    return Container();
  }

  stateManagement(HomeState state){
    switch(state){

      case HomeState.start:
        return _start();

      case HomeState.loading:
        return _loading();

      case HomeState.error:
        return _error();

      case HomeState.success:
        return _success();

      default:
        return _start();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Todo\'s'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined),
            onPressed: (){
              controller.start();
            },
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },),
    );
  }
}
