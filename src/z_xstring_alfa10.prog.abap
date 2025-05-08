*&---------------------------------------------------------------------*
*& Report Z_XSTRING_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_XSTRING_ALFA10.

* Declaracion de variable para el tipo de cadena de caracteres de longitud dinamica
data cadena_dinamica type string.

cadena_dinamica = 'Hola mundo'.

write cadena_dinamica.

cadena_dinamica = 'Bienvenido al curso de programacion en ABAP'.

skip.

write cadena_dinamica.

data hex type xstring.

hex = '01'.

skip.

write hex.

hex = 'ABC'.

skip.

WRITE 'El nuevo valor '.

write hex.

skip.

hex = 'A2'.

write hex.
