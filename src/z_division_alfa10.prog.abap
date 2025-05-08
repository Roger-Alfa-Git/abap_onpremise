*&---------------------------------------------------------------------*
*& Report Z_DIVISION_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_DIVISION_ALFA10.

data: numeroA   type i,
      numeroB   type i,
      resultado type p LENGTH 16 DECIMALS 4.

numeroA = 35.
numeroB = 8.

resultado = numeroA / numeroB.

WRITE: / 'A = ',numeroA,
       / 'B = ',numeroB,
       / 'Resultado = ',resultado.

DIVIDE resultado by 2.

WRITE: / 'Resultado:',resultado.

resultado = 3 * ( numeroA + numeroB ).

WRITE: / 'Resultado = ',resultado.
