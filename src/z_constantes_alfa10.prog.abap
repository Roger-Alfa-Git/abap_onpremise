*&---------------------------------------------------------------------*
*& Report Z_CONSTANTES_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_CONSTANTES_ALFA10.

CONSTANTS: c_numero  type i          VALUE 5,
           c_car_num type n length 4 value '1234',
           c_fecha   type d          VALUE '20240607',
           c_num_paq type p LENGTH 6 DECIMALS 2 VALUE '4500.36',
           c_moneda  type c LENGTH 3 VALUE 'EUR'.

WRITE: 'Constante tipo I = ', c_numero,
     / 'Constante tipo N = ', c_car_num,
     / 'Constante tipo D = ', c_fecha DD/MM/YYYY,
     / 'Constante tipo P = ', c_num_paq.
