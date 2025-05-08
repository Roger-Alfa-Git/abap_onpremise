*&---------------------------------------------------------------------*
*& Report Z_SUMA_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_SUMA_ALFA10.

DATA: numeroA type i,
      numeroB type i,
      resultado type i.

numeroA = 6.
numeroB = 4.

resultado = numeroA + numeroB.

write: 'La suma de ',numeroA,' y ',numeroB,' es: ',resultado.

add 3 to resultado.

write: / 'Resultado: ',resultado.

resultado = resultado + 4.

WRITE: / 'Resultado: ', resultado.

resultado = resultado + numeroA + numeroB + 3.

WRITE: / 'Resultado: ', resultado.

Clear resultado.

WRITE: / 'Resultado: ', resultado.
