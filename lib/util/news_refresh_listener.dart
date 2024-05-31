import 'dart:async';

class NewsRefreshListener {
  final StreamController<bool> _controller = StreamController.broadcast();
  Stream<bool> get refreshStream => _controller.stream;

  void setRefresh() {
    _controller.sink.add(true);
  }

}