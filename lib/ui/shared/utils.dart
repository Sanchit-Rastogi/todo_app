enum TodoStatus {
  todo('TODO'),
  inprogress('IN-PROGRESS'),
  done('DONE');

  const TodoStatus(this.value);
  final String value;
}
