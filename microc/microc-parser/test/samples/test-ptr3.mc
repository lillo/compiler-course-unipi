void double(int* i)
{
    *i = *i * 2;
}

int main()
{
    int i;
    i = 2;

    print(i);
    double(&i);
    print(i);
    return 0;
}