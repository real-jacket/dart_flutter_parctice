Future<String> fetchContent() =>
    Future<String>.delayed(Duration(seconds: 3), () => 'hello')
        .then((x) => "$x 2019");

func() async => print(await fetchContent());

void main() async {
  print('start');
  await func();
  // print(await fetchContent());
  print('end');
  // Future(() => print('f1'))
  //     .then((_) async => await Future(() => print('f2')))
  //     .then((_) => print('f3'));
  // Future(() => print('f4'));
}
