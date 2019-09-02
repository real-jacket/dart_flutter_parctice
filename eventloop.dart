import 'dart:async';
import 'dart:core';

void main() {
  // 异步任务 按先后顺序执行
  Future(() => print('f1'));
  Future fx = Future(() => null);

  Future(() => print('f2')).then((_) {
    print('f3');
    scheduleMicrotask(() => print('f4'));
  }).then((_) => print('f5'));

  Future(() => print('f6'))
      .then((_) => Future(() => print('f7')))
      .then((_) => print('f8'));
  Future(() => print('f9'));

  fx.then((_) => print('f10'));

  // 微任务 优先执行
  scheduleMicrotask(() => print('f11'));
  // 同步代码 最先执行
  print('f12');
}
