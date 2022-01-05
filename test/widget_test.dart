void main() {
  print('Hello, World!');
  fetchUserOrder3();
  fetchUserOrder2();
  fetchUserOrder();
  print('Hello, World!');
}

Future<void> fetchUserOrder() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      const Duration(seconds: 1),
      () => print('Large Latte'),
    );

Future<void> fetchUserOrder2() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => print('Large Latte2'),
    );

void fetchUserOrder3() async {
  // Imagine that this function is
  // more complex and slow.
  await Future.delayed(
    const Duration(seconds: 3),
    () => print('Large Latte3'),
  );
}
