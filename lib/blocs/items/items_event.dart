abstract class ItemsEvent {
  const ItemsEvent();
}

class LoadItems extends ItemsEvent {
  const LoadItems();
}

class AddItem extends ItemsEvent {
  final String title;
  const AddItem(this.title);
}

class DeleteItem extends ItemsEvent {
  final String id;
  const DeleteItem(this.id);
}
