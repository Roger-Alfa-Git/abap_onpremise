*&---------------------------------------------------------------------*
*& Report Z_EJERCICIOS_4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EJERCICIOS_4_ALFA10.

*Ejercicio 4.2
data: ejercicio type n LENGTH 4,
      no_ejercicio type n LENGTH 8,
      codigo_factura TYPE string.

ejercicio = '98cd'.
no_ejercicio = '1234abcd'.

CONCATENATE ejercicio no_ejercicio INTO codigo_factura SEPARATED BY '/'.

WRITE: / 'Ejercicio 4.2',
       / ejercicio,
       / no_ejercicio,
       / codigo_factura.

skip.

*Ejercicio 4.4
data: expediente TYPE string.

expediente = 'Eexpediente laboral con estado    en tramite'.

WRITE: / 'Ejercicio 4.4',
       / expediente.

CONDENSE expediente.

WRITE / expediente.

skip.

*Ejercicio 4.6
data: solicitud TYPE string.

solicitud = 'SOL-327-ACCESO-28'.

WRITE: / 'Ejercicio 4.6',
       / solicitud.

REPLACE ALL OCCURRENCES OF '-' IN solicitud WITH '/'.

WRITE / solicitud.

skip.

*Ejercicio 4.8
data: empresa TYPE string,
      posicion TYPE i.

empresa = 'SYSTEME ANWENDUNGEN PRODUKTE AG'.

SEARCH empresa FOR 'PRO'.

posicion = sy-fdpos + 1.

WRITE: / 'Ejercicio 4.8',
       /  empresa,
       / 'Posicion: ', posicion.

skip.

*Ejercicio 4.10
data: no_instalacion type c LENGTH 10.

no_instalacion = '2015ABCD'.

WRITE: / 'Ejercicio 4.10',
       / no_instalacion.

SHIFT no_instalacion LEFT DELETING LEADING '20'.

WRITE: / no_instalacion.

skip.

*Ejercicio 4.12
data: frase TYPE string.

frase = 'Hola soy Roger'.

WRITE: / 'Ejercicio 4.12',
       / frase.

TRANSLATE frase TO UPPER CASE.

WRITE: / frase.

skip.

*Ejercicio 4.14
data: registro TYPE string,
      campo1 TYPE string,
      campo2 TYPE string,
      campo3 TYPE string,
      campo4 TYPE string.

registro = 'Ejercicio;2020;Sociedad;SAP'.

WRITE: / 'Ejercicio 4.14',
       / registro.

SPLIT registro AT ';' INTO campo1 campo2 campo3 campo4.

WRITE: / campo1,
       / campo2,
       / campo3,
       / campo4.
