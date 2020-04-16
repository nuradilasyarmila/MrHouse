// import 'package:employee_activity_tracker/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_stock/models/item.dart';

class EditItem extends StatefulWidget {

  final Item item;

  EditItem({this.item});

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {

  final _formKey = GlobalKey<FormState>();
  final List<String> categories = ['Fresh Food', 'Dry Food', 'Grocery', 'Household', 'Other'];
  final List<String> metrics = ['Grams', 'Kilograms', 'Milliliters', 'Liters', 'Packets', 'Tins', 'Other'];

  String _name;
  String _category;
  String _metric;
  int _quantity;

  @override
  Widget build(BuildContext context) {
    _name = _name ?? widget.item.name;
    _category = _category ?? widget.item.category;
    _metric = _metric ?? widget.item.metric;
    _quantity = _quantity ?? widget.item.quantity;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Add Item',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: _name ?? 'Name',
            validator: (val) => val.isEmpty ? 'Please enter a Name' : null,
            onChanged: (val) => setState(() => _name = val),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            value: _category.isEmpty ? null : categories[categories.indexOf(_category)],
            items: categories.map((category){
              return DropdownMenuItem(
                value: category,
                child: Text('$category'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _category = val),
          ),
          DropdownButtonFormField(
            value: _metric.isEmpty ? null : metrics[metrics.indexOf(_metric)],
            items: metrics.map((metric){
              return DropdownMenuItem(
                value: metric,
                child: Text('$metric'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _metric = val),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: _quantity.toString().isEmpty ? '0' : _quantity.toString(),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? 'Please enter Quantity' : null,
            onChanged: (val) => setState(() => _quantity = int.parse(val)),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Edit Item',
              style: TextStyle(color: Colors.white)
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}