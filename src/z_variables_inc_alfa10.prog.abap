*&---------------------------------------------------------------------*
*& Report Z_VARIABLES_INC_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_VARIABLES_INC_ALFA10.

data cadena type c LENGTH 4.

cadena = 'Hola'.

WRITE: cadena, ' Alumno ABAP'.

data numero TYPE p LENGTH 10 DECIMALS 2.

numero = '45.10'.

WRITE / numero.

data: cadena2 TYPE c LENGTH 4,
      numero2 TYPE p LENGTH 10 DECIMALS 2.

skip.

cadena2 = 'Hola'.
write: cadena2,
        ' alumnos de ABAP'.

numero2 = '50.511'.

WRITE / numero2.

data: car_num type n LENGTH 4,
      num_entero type i.

car_num = 35.

write / car_num.

num_entero = 35.

WRITE / num_entero.

data: hex type x LENGTH 10.

hex = 'F07'.

WRITE: / hex.
