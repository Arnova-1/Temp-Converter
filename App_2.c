#include <stdio.h>

int main() {
    int choice;
    char buffer[64];
    float temp;

while(1) {
    printf(
        "========================\n"
        " TEMPERATURE CONVERTER\n"
        "========================\n"
        "1. Celcius [°C] -> Fahrenheit [°F]\n"
        "2. Fahrenheit [°F] -> Celcius [°C]\n"
        "0. Exit\n"
    );

    while (1) {
        printf("Please select one of the following operations (0, 1, 2): ");
         if(!fgets(buffer, sizeof(buffer), stdin)) {
                printf("\nInput error. Exiting...\n");
                return 1;
            }

        if (sscanf(buffer, "%d", &choice) == 1 && (choice == 0 || choice == 1 || choice == 2)) {
            break;
        } else {
            printf("Invalid input. Please enter 0, 1, or 2.\n");
        }
    }
    
    if (choice == 1) {
        while (1) {
            printf("Please enter a value in Celcius: ");
            
            if(!fgets(buffer, sizeof(buffer), stdin)) {
                printf("\nInput error. Exiting...\n");
                return 1;
            }

            if(sscanf(buffer, "%f", &temp) == 1) {
                break;
            } else {
                printf("Invalid input. Please enter a number.\n");
            }
        }

        float result = temp * 1.8 + 32;

        printf("Celcius [°C]: %.2f -> Fahrenehit [°F]: %.2f\n", temp, result);
    } else if (choice == 2) {
        while (1) {
            printf("Please enter a value in Fahrenheit: ");
            
            if(!fgets(buffer, sizeof(buffer), stdin)) {
                printf("\nInput error. Exiting...\n");
                return 1;
            }

            if(sscanf(buffer, "%f", &temp) == 1) {
                break;
            } else {
                printf("Invalid input. Please enter a number.\n");
            }
        }

        float result = (temp - 32) / 1.8;

        printf("Fahrenehit [°F]: %.2f -> Celcius [°C]: %.2f\n", temp, result);
    }

    if (choice == 0) {
        printf("Exiting...");
        break;
    }
} 
    return 0;
}