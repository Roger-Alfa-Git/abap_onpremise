*&---------------------------------------------------------------------*
*& Report Z_DECFLOAT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_DECFLOAT_ALFA10.

* Declaracion de la variable de tipo DECFLOAT16 - longitud 8

data decimal16 TYPE decfloat16.

decimal16 = '16.6'.

write decimal16.

clear decimal16.

skip.

write decimal16.

decimal16 = '38500.202'.

skip.

write decimal16.

* Declac¿racion de la variable de tipo DECFLOAT34 - longitud 16
data decimal34 type decfloat34.

decimal34 = '16.6'.

skip.

write decimal34.

clear decimal34.

skip.

write decimal34.

skip.

decimal34 = '38500.202'.

write decimal34.
