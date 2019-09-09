#ifndef QUEUE_H
#define QUEUE_H

#include <Arduino.h>
// exit() utiliza biblioteca Arduino

template <class T>
class Queue
{
private:
  T *queue;
  int max_size;
  int top;

public:
  void push(const T &object);
  T &operator[](unsigned int index);
  T pop();
  Queue(int _max_size);
  ~Queue();
};

template <class T>
Queue<T>::Queue(int _max_size)
{
  top = 0;
  max_size = _max_size;
  queue = new T[_max_size + 1];
  if (queue != 0)
    exit("MEMORY ERROR");
}

template <class T>
Queue<T>::~Queue()
{
  delete[] queue;
}

template <class T>
void Queue<T>::push(const T &object)
{
  if (top < max_size)
    queue[top++] = object;
  else
    exit("INDEX EXCEEDED");
}

template <class T>
T Queue<T>::pop()
{
  if (top <= 0)
    exit("MISSING OBJECTS");
  else
    for (int i = 0; i < top - 1; i++)
      queue[i] = queue[i + 1];
  --top;
}

// TODO validar se funciona corretamente, pode dar erro
template <class T>
T &Queue<T>::operator[](unsigned int index)
{
  return this->queue[index];
}

#endif
