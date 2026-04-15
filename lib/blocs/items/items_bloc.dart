import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'items_event.dart';
import 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ApiService _apiService;

  ItemsBloc(this._apiService) : super(const ItemsLoading()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_onAddItem);
    on<DeleteItem>(_onDeleteItem);
  }

  Future<void> _onLoadItems(
    LoadItems event,
    Emitter<ItemsState> emit,
  ) async {
    emit(const ItemsLoading());
    try {
      final items = await _apiService.getItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      // TODO: maybe show snackbar instead of replacing the whole state
      emit(ItemsError(e.toString()));
    }
  }

  Future<void> _onAddItem(
    AddItem event,
    Emitter<ItemsState> emit,
  ) async {
    final currentState = state;
    try {
      final newItem = await _apiService.createItem(event.title);
      if (currentState is ItemsLoaded) {
        emit(ItemsLoaded([newItem, ...currentState.items]));
      }
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  Future<void> _onDeleteItem(
    DeleteItem event,
    Emitter<ItemsState> emit,
  ) async {
    final currentState = state;
    try {
      await _apiService.deleteItem(event.id);
      if (currentState is ItemsLoaded) {
        // filter out the deleted item locally
        final updatedList =
            currentState.items.where((item) => item.id != event.id).toList();
        emit(ItemsLoaded(updatedList));
      }
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }
}
