*&---------------------------------------------------------------------*
*& Report Z_SQRT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_SQRT_ALFA10.

data numero type i.

numero = sqrt( 25 ).

WRITE: / 'Numero = ', numero.

numero = 9.

numero = sqrt( numero ).

WRITE: / 'Numero = ',numero.
