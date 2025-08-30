#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_Q 20
#define Q_LEN 10

int main() {
    FILE *solvedFile, *studentFile;
    char solved[MAX_Q][Q_LEN];
    char student[MAX_Q][Q_LEN];
    int total = 0, score = 0;

    // Open the solved answers and student answers file
    solvedFile = fopen("solved_answers.txt", "r");
    studentFile = fopen("student_answers.txt", "r");
    if (solvedFile == NULL || studentFile == NULL) {
        printf("❌ Error: File 'solved_answers.txt' not found.\n");
        fclose(solvedFile);
        fclose(studentFile);
        return 1;
    }

    // Read solved answers into an array
    while (fgets(solved[total], Q_LEN, solvedFile) != NULL) {
        solved[total][strcspn(solved[total], "\n")] = '\0'; // Remove newline
        total++;
    }

    // Read student answers and compare
    for (int i = 0; i < total; i++) {
        if (fgets(student[i], Q_LEN, studentFile) != NULL) {
            student[i][strcspn(student[i], "\n")] = '\0'; // Remove newline

            // Compare answers
            if (strcmp(solved[i], student[i]) == 0) {
                score++;  // Increase score for correct answers
            }
        }
    }

    // Close the files
    fclose(solvedFile);
    fclose(studentFile);

    // Display result
    printf("Final Score: %d/%d\n", score, total);

    return 0;
}
