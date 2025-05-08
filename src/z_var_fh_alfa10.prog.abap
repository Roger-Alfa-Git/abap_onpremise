*&---------------------------------------------------------------------*
*& Report Z_VAR_FH_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_VAR_FH_ALFA10.

*Ejercicio 2.3
data fecha type d value '20241127'.
data hora type t value '124500'.
WRITE 'Ejercicio 2.3'.

write: / fecha DD/MM/YYYY,
     / hora ENVIRONMENT TIME FORMAT.

skip.

*Ejercicio 2.5
data iva type i.

iva = 7.

data reparto type f.

reparto = '18.95'.

write: / 'Ejercicio 2.5',
       / iva,
       / reparto.

skip.

*Ejercicio 2.7
data: impuesto_directo type decfloat16,
      impuesto_indirecto type decfloat34.

impuesto_directo = '18.23'.
impuesto_indirecto = '23.81'.

WRITE: / 'Ejercicio 2.7',
       / impuesto_directo,
       / impuesto_indirecto.

skip.

*Ejercicio 2.9
data: nombre type string,
      hexadecimal TYPE xstring.

nombre = 'Prueba de Alfa10'.
hexadecimal = '12ABC'.

WRITE: / 'Ejercicio 2.9',
       / nombre,
       / hexadecimal.

SKIP.

*Ejercicio 2.11
data: sociedad type c LENGTH 6,
      tarifa type p LENGTH 4 DECIMALS 2.

sociedad = 'LOGALI'.
tarifa = '1489.36'.

WRITE: / 'Ejercicio 2.11',
       / sociedad,
       / tarifa.

skip.

*Ejercicio 2.13
data: codigo_sociedad type n LENGTH 4,
      datos type x LENGTH 5.

codigo_sociedad = '321'.
datos = '123'.

WRITE: / 'Ejercicio 2.13',
       / codigo_sociedad,
       / datos.

skip.

*Ejercicio 2.15
CONSTANTS: valorD TYPE d VALUE '20240610',
           valorT TYPE t VALUE '120600',
           valorI TYPE i VALUE '505',
           valorF TYPE f VALUE '464',
           valorDecF16 TYPE decfloat16 VALUE '202.36',
           valorDec34 TYPE decfloat34 VALUE '101.45',
           valorString TYPE string VALUE 'Prueba constante',
           valorXString TYPE xstring VALUE '987FED',
           valorC type c VALUE '159',
           valorP type p LENGTH 5 DECIMALS 2 VALUE '15976.36',
           valorN TYPE n VALUE '456',
           valorX TYPE x VALUE '987'.

WRITE: / 'Ejercicio 2.15',
       / valorD DD/MM/YYYY,
       / valorT ENVIRONMENT TIME FORMAT,
       / valorI,
       / valorF,
       / valordecf16,
       / valordec34,
       / valorstring,
       / valorxstring,
       / valorC,
       / valorP,
       / valorN,
       / valorX.
