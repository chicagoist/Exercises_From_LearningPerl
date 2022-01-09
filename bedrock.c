#include <stdio.h>
#include <locale.h>

int main(void)
{
    char *locale = setlocale(LC_ALL, "");

    printf("Привет мир! \n");
    return 0;
}