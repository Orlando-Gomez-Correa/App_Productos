import 'package:flutter/material.dart';
import 'package:productos_app/models/producto.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductoService extends ChangeNotifier {
  final String _baseUrl = 'productosorlando-ce64b-default-rtdb.firebaseio.com';

  final List<Producto> productos = [];

  bool isLoading = true;
  bool isSaving = false;

  Producto? productoSeleccionado;

  //contructor
  ProductoService() {
    this.obtenerProductos();
  }

  //MAL
  //método que obtiene los productos de la BD
  Future obtenerProductos() async {
    bool isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'productos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productosMap = json.decode(resp.body);

    //print(productosMap);

    productosMap.forEach((key, value) {
      final productoTemp = Producto.fromMap(value);
      productoTemp.id = key;
      this.productos.add(productoTemp);
    });

    this.isLoading = false;
    notifyListeners();

    //print(this.productos[0].nombre);
    return this.productos;
  }

  //Método para actualizar un producto en la BD
  Future<String> updateProducto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'productos/${producto.id}.json');

    final resp = await http.put(url, body: producto.toJson());

    final decodeData = resp.body;
    print(decodeData);

    //actualizar el listado de productos
    final index =
        this.productos.indexWhere((element) => element.id == producto.id);
    this.productos[index] = producto;

    return producto.id!;
  }

  //método para crear o actualizar un prodcutos
  Future saveOrCreateProducto(Producto producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
      //producto nuevo
      await this.createProducto(producto);
    } else {
      //actualizar
      await this.updateProducto(producto);
    }

    isSaving = false;
    notifyListeners();
  }

  //metodo para crear un producto nuevo
  Future<String> createProducto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'productos.json');
    final resp = await http.post(url, body: producto.toJson());
    final decodedData = json.decode(resp.body);

    producto.id = decodedData['name'];
    this.productos.add(producto);

    return producto.id!;
  }
}
