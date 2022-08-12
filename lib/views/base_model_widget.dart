import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseModelWidget<T> extends Widget {
  const BaseModelWidget({Key? key}) : super(key: key);

  @protected
  Widget build(BuildContext context, T model);

  @override
  DataProviderElement<T> createElement() => DataProviderElement<T>(this);
}

class DataProviderElement<T> extends ComponentElement {
  DataProviderElement(BaseModelWidget widget) : super(widget);

  @override
  BaseModelWidget get widget => super.widget as BaseModelWidget;

  @override
  Widget build() => widget.build(this, Provider.of<T>(this));

  @override
  void update(BaseModelWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
