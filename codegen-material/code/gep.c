#include<stddef.h>

int *ptr = {1, 2, 3};
int array[3] = {1, 2, 3};
int matrix[3][3] = {0};

struct person {
    char name[20];
    unsigned int age;
} p;

int get_elem_ptr(int i){
    return ptr[i];
}

int get_elem_ar(int i){
    return array[i];
}

int get_age(){
    return p.age;
}

int get_elem_m(size_t i, size_t j){
    return matrix[i][j];
}