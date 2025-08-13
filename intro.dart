
abstract class Product {
  String name;
  double price;
  int quantity;
  final String id;
  final DateTime addedDate;

  Product(this.name, this.price, this.quantity, this.id)
      : addedDate = DateTime.now();

  void showDetails() {
    print(
        'ID: $id | Producto: $name | Precio: \$${price.toStringAsFixed(2)} | Cantidad: $quantity | Añadido: ${addedDate.toIso8601String()}');
  }

  void restock(int amount) {
    quantity += amount;
    print('Se han añadido $amount unidades de $name. Total: $quantity');
  }

  double getInventoryValue() => price * quantity;

  void sell({int units = 1});
}

class Smartphone extends Product {
  final String os;
  final int cameraMP;

  Smartphone(
    String name,
    double price,
    int quantity,
    String id, {
    required this.os,
    required this.cameraMP,
  }) : super(name, price, quantity, id);

  @override
  void sell({int units = 1}) {
    if (quantity >= units) {
      quantity -= units;
      print(
          'Smartphone vendido: $name ($units unidad${units > 1 ? "es" : ""}). Quedan $quantity en inventario.');
    } else {
      print('No hay suficiente stock de $name.');
    }
  }

  @override
  void showDetails() {
    super.showDetails();
    print('  Sistema: $os | Cámara: ${cameraMP}MP');
  }
}

class Laptop extends Product {
  final String cpu;
  final int ramGB;

  Laptop(
    String name,
    double price,
    int quantity,
    String id, {
    required this.cpu,
    required this.ramGB,
  }) : super(name, price, quantity, id);

  @override
  void sell({int units = 1}) {
    if (quantity >= units) {
      quantity -= units;
      print(
          'Laptop vendida: $name ($units unidad${units > 1 ? "es" : ""}). Quedan $quantity en inventario.');
    } else {
      print('No hay suficiente stock de $name.');
    }
  }

  @override
  void showDetails() {
    super.showDetails();
    print('  CPU: $cpu | RAM: ${ramGB}GB');
  }
}


class Tablet extends Product {
  final bool stylusIncluded;
  final double screenSize;

  Tablet(
    String name,
    double price,
    int quantity,
    String id, {
    required this.stylusIncluded,
    required this.screenSize,
  }) : super(name, price, quantity, id);

  @override
  void sell({int units = 1}) {
    if (quantity >= units) {
      quantity -= units;
      print(
          'Tablet vendida: $name ($units unidad${units > 1 ? "es" : ""}). Quedan $quantity en inventario.');
    } else {
      print('No hay suficiente stock de $name.');
    }
  }

  @override
  void showDetails() {
    super.showDetails();
    print(
        '  Pantalla: ${screenSize}" | Stylus incluido: ${stylusIncluded ? "Sí" : "No"}');
  }
}


class ProductFactory {
  static Product createProduct(
    String type,
    String name,
    double price,
    int quantity,
    String id, {
    Map<String, dynamic>? extra,
  }) {
    switch (type.toLowerCase()) {
      case 'smartphone':
        return Smartphone(
          name,
          price,
          quantity,
          id,
          os: extra?['os'] ?? 'Android',
          cameraMP: extra?['cameraMP'] ?? 12,
        );
      case 'laptop':
        return Laptop(
          name,
          price,
          quantity,
          id,
          cpu: extra?['cpu'] ?? 'Intel i5',
          ramGB: extra?['ramGB'] ?? 8,
        );
      case 'tablet':
        return Tablet(
          name,
          price,
          quantity,
          id,
          stylusIncluded: extra?['stylusIncluded'] ?? false,
          screenSize: extra?['screenSize'] ?? 10.0,
        );
      default:
        throw Exception('Tipo de producto desconocido');
    }
  }
}


class Inventory {
  final Map<String, Product> _products = {};

  void addProduct(Product product) {
    _products[product.id] = product;
    print('Producto añadido: ${product.name}');
  }

  Product? findById(String id) => _products[id];

  List<Product> searchByName(String query) => _products.values
      .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  void showAll() {
    print('--- Inventario completo ---');
    for (var product in _products.values) {
      product.showDetails();
      print('  Valor total: \$${product.getInventoryValue().toStringAsFixed(2)}');
      print('---');
    }
  }

  double totalInventoryValue() =>
      _products.values.fold(0, (sum, p) => sum + p.getInventoryValue());
}

void main() {
  final inventory = Inventory();

  inventory.addProduct(ProductFactory.createProduct(
    'smartphone',
    'iPhone 15',
    1200,
    5,
    'S001',
    extra: {'os': 'iOS', 'cameraMP': 48},
  ));

  inventory.addProduct(ProductFactory.createProduct(
    'laptop',
    'Dell XPS 13',
    1800,
    3,
    'L001',
    extra: {'cpu': 'Intel i7', 'ramGB': 16},
  ));

  inventory.addProduct(ProductFactory.createProduct(
    'tablet',
    'iPad Pro',
    999,
    2,
    'T001',
    extra: {'stylusIncluded': true, 'screenSize': 12.9},
  ));

  inventory.showAll();

  var found = inventory.findById('S001');
  found?.sell(units: 2);
  found?.showDetails();

  found?.restock(10);


  var results = inventory.searchByName('pro');
  print('Resultados de búsqueda para "pro":');
  for (var p in results) {
    p.showDetails();
  }

  print('Valor total del inventario: \$${inventory.totalInventoryValue().toStringAsFixed(2)}');