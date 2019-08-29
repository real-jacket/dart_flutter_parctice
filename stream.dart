import 'dart:async';

import 'dart:io';

class NumberCreator {
  static StreamController _controller = StreamController();
  // StreamSubscription subscription =
  //     controller.stream.listen((data) => print("$data"));

  int _count = 1;

  NumberCreator() {
    print('start !');
    Timer.periodic(Duration(seconds: 1), (t) async {
      if (_count > 10) {
        exit(1);
      } else {
        await _controller.sink.add(_count);
        _count++;
      }
      print('time-end');
    });
    print('end !');
  }

  Stream get stream => _controller.stream;
}

void main() {
  // 单一订阅的 stream ，只能有一个监听
  // final stream = NumberCreator().stream;

  // 使用 asBroadcastStream ，变成 广播 stream ，便可以有多个 stream。
  final stream = NumberCreator().stream.asBroadcastStream();

  stream.listen((n) => print(n));

  stream.listen((n) => print("another-$n"));
}
