abstract class Observer<T> {
  void update(T notification);
}

abstract class Subject<R extends Observer> {
  void attach(R observer);
  void detattach(R observer);

  void notifyObserver();
}
