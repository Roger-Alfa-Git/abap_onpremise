*&---------------------------------------------------------------------*
*& Report Z_RESTA_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_RESTA_ALFA10.

 data: numeroA type i,
       numeroB type i,
       resultado type i.

 numeroA = 10.
 numeroB = 4.

 resultado = numeroA - numeroB.

 WRITE: 'El resultado de los numeros:',numeroA,' menos',numeroB,' es: ',resultado.

 SUBTRACT 2 from resultado.

 WRITE: / 'Resultado: ',resultado.

 resultado = resultado - 1.

 write: / 'Resultado: ',resultado.
