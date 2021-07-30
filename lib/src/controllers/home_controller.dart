import 'package:flutter/cupertino.dart';
import 'package:integrando_api_flutter/src/models/todo_model.dart';
import 'package:integrando_api_flutter/src/repositories/todo_repository.dart';

class HomeControleer{
  List<TodoModel> todos = [];
  final TodoRepository _repository;

  final state = ValueNotifier<HomeState>(HomeState.start);

  HomeControleer(TodoRepository? repository) : _repository = repository ?? TodoRepository(null);

  Future start() async{
    state.value = HomeState.loading;
    try{
      todos = await _repository.fetchTodos();
      state.value = HomeState.success;
    }catch(e){
      state.value = HomeState.error;
    }
  }
}

enum HomeState{start, loading, success, error}