*&---------------------------------------------------------------------*
*& Report Z_MULTIPLICACION_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_MULTIPLICACION_ALFA10.

data: numeroA   type i,
      numeroB   type i,
      resultado type i.

numeroA = 4.
numeroB = 3.

resultado = numeroA * numeroB.

WRITE: / 'Resultado de',numeroA,' por',numeroB,' es:',resultado.

MULTIPLY resultado by 2.

WRITE: / 'Resultado:',resultado.

resultado = resultado * 2.

WRITE: / 'Resultado:',resultado.
