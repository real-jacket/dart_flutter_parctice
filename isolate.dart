import 'dart:isolate';

Isolate isolate;

start() async {
  // 创建管道
  ReceivePort receivePort = ReceivePort();

  // 创建并发 isolate ，并传入发送管道
  isolate = await Isolate.spawn(getMsg, receivePort.sendPort);

  // 监听管道消息
  receivePort.listen((data) {
    print('Data: $data');
    receivePort.close();
    isolate?.kill(priority: Isolate.immediate);
    isolate = null;
  });
}

// 并发 Isolate 往管道发送一个字符串
getMsg(sendPort) => sendPort.send('hello');

Future<dynamic> asyncFactorial(n) async {
  // 创建管道
  final response = ReceivePort();

  // 创建 isola 并传入管道
  await Isolate.spawn(_isolate, response.sendPort);

  // 等待 isola 回传管道
  final sendPort = await response.first as SendPort;

  // 创建另一个管道
  final answer = ReceivePort();

  // 往 isolate 回传的管道中发送参数，同时传入 answer 管道
  sendPort.send([n, answer.sendPort]);

  // 等待 isolate 通过 answer 管道回传执行结果
  return answer.first;
}

// Isolate 函数体，参数主要是 Isolate 传入的管道
_isolate(initialReplyTo) async {
  // 创建管道
  final port = ReceivePort();

  // 往主 Isolate 回传管道
  initialReplyTo.send(port.sendPort);

  // 等待主 Isolate 发送信息（参数和回传结果的管道）
  final message = await port.first as List;

  // 参数
  final data = message[0] as int;
  // 回传结果的管道
  final send = message[1] as SendPort;
  // 调用同步计算阶乘的函数回传结果
  send.send(asyncFactorial(data));
}

// 同步计算阶乘
int syncFactorial(n) => n < 2 ? n : n * syncFactorial(n - 1);

void main() async {
  // start();
  print(await syncFactorial(4));
}
