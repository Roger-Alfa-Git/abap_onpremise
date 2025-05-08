*&---------------------------------------------------------------------*
*& Report Z_MOD_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_MOD_ALFA10.

data: numeroA type i,
      numeroB type i,
      resultado type p LENGTH 4 DECIMALS 2.

numeroA = 9.
numeroB = 4.

resultado = numeroA / numeroB.

WRITE: / 'A = ', numeroA,
       / 'B = ', numeroB,
       / 'Resultado = ', resultado.

resultado = numeroA mod numeroB.

WRITE: / 'Division su resto = ', resultado.

resultado = numeroA DIV numeroB.

WRITE: / 'Resultado sin resto = ', resultado.
