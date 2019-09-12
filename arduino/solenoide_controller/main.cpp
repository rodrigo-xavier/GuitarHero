// #include <iostream>
// #include <assert.h>
// #include "queue.h"
// #include "note.h"

// using namespace std;

// int main()
// {

//     Queue<int> test = Queue<int>(5);

//     for (int i = 0; i < 5; i++)
//     {
//         test.push(i);
//         cout << "Test i: " << test[i];
//         assert(test[i] == i);
//         printf("\n");
//     }
//     cout << "OK1";

//     printf("\n\n");

//     for (int i = 0; i < 5; i++)
//     {
//         test.pop();
//         for (int j = 0; j < 5; j++)
//             cout << "test i: " << test[j] << "\n";
//         printf("\n");
//     }
//     cout << "OK2";

//     /*************************************************************************************/

//     // Note const note(1);

//     Queue<Note> test_note = Queue<Note>(5);

//     for (int i = 0; i < 5; i++)
//     {
//         test_note.push(Note());
//         cout << "Test open: " << test_note[i].open;
//         printf("\n");
//     }
//     cout << "OK3";

//     printf("\n\n");

//     for (int i = 0; i < 5; i++)
//     {
//         test_note[i].pin = i;
//         cout << "Test pin: " << test_note[i].open;
//         printf("\n");
//     }
//     cout << "OK4";

//     printf("\n\n");

//     for (int i = 0; i < 5; i++)
//     {
//         test_note[i].drop = true;
//         cout << "Test drop: " << test_note[i].open;
//         printf("\n");
//     }
//     cout << "OK5";

//     printf("\n\n");

//     for (int i = 0; i < 5; i++)
//     {
//         test_note.pop();
//         for (int j = 0; j < 5; j++)
//             cout << "test_note i: " << test_note[j].open << "\n";
//         printf("\n");
//     }
//     cout << "OK6";

//     return 0;
// }
