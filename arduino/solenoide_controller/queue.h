#ifndef QUEUE_H
#define QUEUE_H

#include <iostream>
using namespace std;

// #include <Arduino.h>
// exit() utiliza biblioteca Arduino

template <class T>
class Queue
{
private:
  T *queue;
  int max_size;
  int top;

public:
  Queue(int);
  ~Queue();

  void push(const T &);
  void pop(void);
  T &operator[](unsigned int);
};

/*
  Método construtor de fila, recebe um valor que define o tamanho máximo para a fila
  aloca o espaço correspondente e define o valor de topo da fila.
  Se não é possível alocar espaço, então é retornado um erro.
  O espaço alocado é do tipo T (tipo inserido na chamada da função)
*/
template <class T>
Queue<T>::Queue(int _max_size)
{
  top = 0;
  max_size = _max_size;
  queue = new T[_max_size];
  if (!queue)
    printf("MEMORY ERROR");
}

/*
  Método destrutor de fila, destrói o espaço de memória alocado para a fila.
*/
template <class T>
Queue<T>::~Queue()
{
  delete[] queue;
}

/*
  Método push, insere
*/
template <class T>
void Queue<T>::push(const T &object)
{
  if (top <= max_size)
    queue[top++] = object;
  else
    printf("INDEX EXCEEDED");
}

/*
  Método pop, remove o primeiro elemento da fila.
  Importante notar, que o primeiro elemento é apenas sobrescrito pelos próximos elementos da fila,
  E que o elemento do topo (último elemento da fila) não é alterado. 
  Apenas é setado um novo valor para o topo.
*/
template <class T>
void Queue<T>::pop()
{
  if (top <= 0)
    printf("MISSING OBJECTS");
  else
    for (int i = 0; i < top - 1; i++) // O topo sempre aponta para a próxima posição vazia da fila
      queue[i] = queue[i + 1];
  --top;
}

template <class T>
T &Queue<T>::operator[](unsigned int index)
{
  return queue[index];
}

#endif
