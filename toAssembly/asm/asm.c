#include "asm.h"

TabAsm *Tab[TSIZE] ;



void init_TabAsm()
{
    for (int i = 0; i < TSIZE; i++)
        Tab[i] = NULL;
}


char OptoAsm(enum Operateur op)
{
    switch (op)
    {
    case NOP:
        return '0';
    case ADD:
        return '1';
    case MUL:
        return '2';
    case SOU:
        return '3';
    case DIV:
        return '4';
    case COP:
        return '5';
    case AFC:
        return '6';
    case JMP:
        return '7';
    case JMF:
        return '8';
    case INF:
        return '9';
    case SUP:
        return 'A';
    case EQU:
        return 'B';
    case PRI:
        return 'C';
    default:
        return '&';
    }
}

char* stringtoAsm(char op)
{
    switch (op)
    {
    case '0':
        return "NOP";
    case '1':
        return "ADD";
    case '2':
        return "MUL";
    case '3':
        return "SOU";
    case '4':
        return "DIV";
    case '5':
        return "COP";
    case '6':
        return "AFC";
    case '7':
        return "JMP";
    case '8':
        return "JMF";
    case '9':
        return "INF";
    case 'A':
        return "SUP";
    case 'B':
        return "EQU";
    case 'C':
        return "PRI";
    default:
        return "symbole non reconue";
    }
}

void addElem(TabAsm *Tab, int Elem)
{
    AsmElement *newElem = (AsmElement *)malloc(sizeof(AsmElement));
    newElem->suivant = NULL;
    newElem->Elem = Elem;    
    if (Tab->instructions == NULL)
    {
        Tab->instructions = newElem;
        return;
    }
    AsmElement *listeElem = Tab->instructions;
    while (listeElem->suivant != NULL)
        listeElem = listeElem->suivant;
    listeElem->suivant = newElem;
}

int suivantTabAsm()
{
    for (int i = 0; i < TSIZE; i++)
    {
        if (Tab[i] == NULL)
            return i;
    }
    fprintf(stderr, "%s\n", "Plus d'espace dans le tableau d'instructions ASM!");
    return -1;
}
int addTabAsm(enum Operateur operateur, int argumentNumber, ...)
{
    TabAsm *newInstruct = (TabAsm *)malloc(sizeof(TabAsm));
    newInstruct->Name = OptoAsm(operateur);
    newInstruct->instructions = NULL;

    // Traiter chaque opérateur et ses arguments
    switch (operateur)
    {
    case NOP:
        break;
    case ADD:
    case MUL:
    case SOU:
    case DIV:
    case COP:
    case AFC:
    case SUP:
    case INF:
    case EQU:
    case PRI:
    {
        va_list arguments;
        va_start(arguments, argumentNumber);

        // Ajouter les arguments à la liste des instructions
        for (int i = 0; i < argumentNumber; i++)
        {
            int arg = va_arg(arguments, int);
            addElem(newInstruct, arg);
        }

        va_end(arguments);
        break;
    }
    case JMP:
    case JMF:
    {
        va_list arguments;
        va_start(arguments, argumentNumber);

        // Ajouter les arguments à la liste des instructions
        for (int i = 0; i < argumentNumber; i++)
        {
            int arg = va_arg(arguments, int);
            addElem(newInstruct, arg);
        }

        va_end(arguments);
        break;
    }
    default:
        fprintf(stderr, "Operateur non supporte : %d\n", operateur);
        free(newInstruct);
        return -1;
    }

    int suivantInstruct = suivantTabAsm();
    if (suivantInstruct < 0)
    {
        fprintf(stderr, "%s\n", "Ne peux pas ajouter instruction!");
        free(newInstruct);
        return -1;
    }

    Tab[suivantInstruct] = newInstruct;
    printf("fin add Asm, suivantInstruct = %d\n", suivantInstruct);
    printf("newInstruct = %c\n", newInstruct->Name);
    return suivantInstruct;
}

void editAsmBranch(int adressif, enum Operateur operateur, enum Branch branch)
{
    int supplement = 0;
    if (branch == IF)
    {
        supplement = 1;
    } // Si on fait un if on saute un cran plus loin pour éviter d'enjamber le JMP du else
    
    TabAsm *instruct = Tab[adressif];
    instruct->Name = OptoAsm(operateur);

    if (instruct->instructions != NULL)
    {
        if (branch == ELSE && instruct->instructions->suivant != NULL) // JMP donc 1 OP
        {
            instruct->instructions->Elem = suivantTabAsm();
        }
        else if (branch != ELSE && instruct->instructions->suivant != NULL && instruct->instructions->suivant->suivant != NULL) // 2 OP avec JMF
        {
            instruct->instructions->suivant->Elem = suivantTabAsm() + supplement;
        }
        else
        {
            fprintf(stderr, "Erreur : Structure de données incorrecte.\n");
        }
    }
    else
    {
        fprintf(stderr, "Erreur : instruct->instructions == NULL\n");
    }

    // On est un JMP donc on a un seul opérande
    if (branch == ELSE)
    {
        instruct->instructions->Elem = suivantTabAsm();
    }
    // On a 2 opérandes avec JMF
    else
    {
        instruct->instructions->suivant->Elem = suivantTabAsm() + supplement;
    }
}

void printTabAsm()
{
    FILE *fp;
    fp = fopen("Code_assembleur", "w");
    TabAsm *asm1;
    for (int i = 0; i < TSIZE; i++)
    {
        asm1 = Tab[i];
        if (!asm1)
            break;
        fflush(stdout);
        fprintf(fp, "%s", stringtoAsm(asm1->Name));
        printf(" %s", stringtoAsm(asm1->Name));
        fflush(stdout);
        AsmElement *instructions = asm1->instructions;
        while (instructions != NULL)
        {
            char srt[4];
            sprintf(srt, "%d", instructions->Elem);
            fprintf(fp, " %s", srt);
            printf(" %d", instructions->Elem);
            fflush(stdout);
            instructions = instructions->suivant;
        }
        fprintf(fp, "\n");
        printf("\n");
    }
    fclose(fp);
}

