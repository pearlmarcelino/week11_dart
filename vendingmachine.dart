import 'dart:async';

abstract class MachineItem {
  String itemName;
  int _stock;

  MachineItem(this.itemName, this._stock);

  void buyItem();

  Future<String> saveItem() async {
    await Future.delayed(Duration(seconds: 2));
    return '$itemName data saved successfully!';
  }

  void displayInfo() {
    print('Item: $itemName');
    print('Stock: $_stock');
  }

  bool get isAvailable => _stock > 0;

  void reduceStock() {
    if (_stock > 0) {
      _stock--;
    }
  }
}

class VendingMachine extends MachineItem {
  VendingMachine(String itemName, int stock)
      : super(itemName, stock);

  @override
  void buyItem() {
    if (isAvailable) {
      reduceStock();
      print('$itemName purchased successfully!');
    } else {
      print('$itemName is out of stock.');
    }
  }
}

class SnackMachine extends VendingMachine {
  SnackMachine(String itemName, int stock)
      : super(itemName, stock);

  @override
  void buyItem() {
    if (isAvailable) {
      reduceStock();
      print('$itemName snack purchased successfully!');
    } else {
      print('$itemName snack is out of stock.');
    }
  }
}

class DrinkMachine extends VendingMachine {
  DrinkMachine(String itemName, int stock)
      : super(itemName, stock);

  @override
  void buyItem() {
    if (isAvailable) {
      reduceStock();
      print('$itemName drink purchased successfully!');
    } else {
      print('$itemName drink is out of stock.');
    }
  }
}

mixin MachineMaintenance {
  void performMaintenance() {
    print('Machine maintenance completed.');
  }
}

class MaintenanceMachine with MachineMaintenance {}

Future<void> main() async {
  SnackMachine item1 = SnackMachine('Chips', 3);
  DrinkMachine item2 = DrinkMachine('Soda', 2);

  List<VendingMachine> items = [item1, item2];

  for (VendingMachine item in items) {
    item.buyItem();
    item.displayInfo();
    print('----------------');
  }

  MaintenanceMachine machine = MaintenanceMachine();
  machine.performMaintenance();

  print('Saving item data...');

  String result = await item1.saveItem();

  print(result);
  print('Program completed.');
}
