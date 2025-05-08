*&---------------------------------------------------------------------*
*& Report Z_DIV_SIN_RESTO_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_DIV_SIN_RESTO_ALFA10.
data: numeroA type i,
      numeroB type i,
      resultado type p LENGTH 6 DECIMALS 2.

numeroA = 9.
numeroB = 4.

resultado = numeroA / numeroB.

Write: / 'A = ', numeroA,
       / 'B = ', numeroB,
       / 'Resultado = ', resultado.

resultado = numeroA DIV numeroB.

WRITE: / 'Division sin resto = ',resultado.
