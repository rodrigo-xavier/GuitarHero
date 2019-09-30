#ifndef QUEUE_H
#define QUEUE_H

/********************************************************************************************  
  Descrição Breve: Classe de Fila

  Descrição da Entrada:
  (T *queue) - Ponteiro para variável fila do tipo T
  (max_size) - Define o tamanho máximo da fila
  (next) - Define o próximo espaço vazio da fila
  (IMPORTANTE: <class T> é um objeto de qualquer tipo)

  Descrição Detalhada: Define uma estrutura do tipo fila, com métodos
  construtor, destrutor, método de inserção no final da fila,
  método de remoção no inicio da fila e operador colchete para acesso
  dos indices da fila.
*********************************************************************************************/

template <class T>
class Queue
{
private:
  T *queue;
  int max_size;
  int next;

public:
  Queue(int);
  ~Queue();

  void push(const T &);
  void pop(void);
  T &operator[](unsigned int);
};

/********************************************************************************************  
  Descrição Breve: Método construtor de fila

  Descrição da Entrada: 
  (_max_size) - Define a quantidade de espaços que deve ser alocada, e o topo da fila

  Descrição Detalhada: Recebe um valor que define o tamanho máximo para a fila
  aloca o espaço correspondente e define o valor de topo da fila.
  Se não é possível alocar espaço, então é retornado um erro.
  O espaço alocado é do tipo T (tipo inserido na chamada da função)
*********************************************************************************************/
template <class T>
Queue<T>::Queue(int _max_size)
{
  next = 0;
  max_size = _max_size;
  queue = new T[_max_size];
  if (!queue)
  {
    Serial.print("MEMORY ERROR");
    Serial.end();
  }
}

/********************************************************************************************  
  Descrição Breve: Método destrutor de fila

  Descrição Detalhada: Deleta todas as instancias da fila ao encerrar o algoritmo
*********************************************************************************************/
template <class T>
Queue<T>::~Queue()
{
  delete[] queue;
}

/********************************************************************************************  
  Descrição Breve: Método de inserção no final da fila

  Descrição da Entrada: 
  (&object) - Endereço do objeto que será inserido na fila 
  (obs: o objeto pode ser de qualquer tipo)

  Descrição Detalhada: Recebe o endereço de um objeto de qualquer tipo, verifica se a
  fila não está cheia, comparando a próxima posição vazia com o tamanho da fila. Se a fila
  não estiver cheia, então o objeto é inserido na próxima posição vazia da fila.
*********************************************************************************************/
template <class T>
void Queue<T>::push(const T &object)
{
  if (next <= max_size)
    queue[next++] = object;
  else
  {
    Serial.print("INDEX EXCEEDED");
    Serial.end();
  }
}

/********************************************************************************************  
  Descrição Breve: Método de remoção no início da fila

  Descrição Detalhada: Verifica se a fila não está vazia (Do contrário não é possível remover)
  Se a fila não está vazia, então percorre todos os elementos da fila, copiando os elementos
  da posição n+1 para a posição n. Importante notar, que há uma tremenda gambiarra na linha
  final do método, aparentemente o compilador não trabalha bem com destrutores, por isso foi
  necessário "destruir" manualmente o objeto, ou seja, setar o estado da nota para fechado
  a linha seguinte, que está comentada, serve para chamar o método destrutor da forma correta,
  caso seja necessário reutilizar esta biblioteca.
*********************************************************************************************/
template <class T>
void Queue<T>::pop()
{
  if (next <= 0)
  {
    Serial.print("MISSING OBJECTS");
    Serial.end();
  }
  else
    for (int i = 0; i < next - 1; i++)
      queue[i] = queue[i + 1];
  --next;
  queue[next].open = false; //GAMBIARRA DO CARALHO
  // delete &(queue[next]);
}

/********************************************************************************************  
  Descrição Breve: Método de acesso aos indíces da fila

  Descrição da Entrada: 
  (index) - Indíce que será acessado da fila

  Descrição Detalhada: O método verifica se há um operador [] "colchete" e se um indíce foi
  definido dentro dos colchetes, então é acessado o indice equivalente na fila e retornado
  um endereço para o objeto do tipo que foi definido na fila.
*********************************************************************************************/
template <class T>
T &Queue<T>::operator[](unsigned int index)
{
  return queue[index];
}

#endif
