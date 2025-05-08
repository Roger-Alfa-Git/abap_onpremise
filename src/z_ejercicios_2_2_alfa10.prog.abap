*&---------------------------------------------------------------------*
*& Report Z_EJERCICIOS_2_2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EJERCICIOS_2_2_ALFA10.

*Ejercicio 3.2
data: TARIFA_BASE type i value 20,
      TARIFA_AREA_CORP type i value 10,
      TARIFA_SER_MEDICO type i value 15,
      TARIFA_TOTAL type i.

TARIFA_TOTAL = TARIFA_BASE + TARIFA_AREA_CORP + TARIFA_SER_MEDICO.

WRITE 'Ejercicio 3.2'.
WRITE: / 'Resultado: ',TARIFA_TOTAL.

ADD 5 TO TARIFA_TOTAL.

WRITE: / 'Resultado: ',TARIFA_TOTAL.

SKIP.

*Ejercicio 3.4
data: TARIFA_MANTENIMIENTO TYPE i VALUE 30,
      TARIFA_MARGEN TYPE i VALUE 10,
      TARIFA_BASE2 TYPE i.

TARIFA_BASE2 = TARIFA_MANTENIMIENTO - TARIFA_MARGEN.

WRITE / 'Ejercicio 3.4'.
WRITE: / 'Resultado: ',TARIFA_BASE2.

SUBTRACT 4 FROM TARIFA_BASE2.

WRITE: / 'Resultado: ',TARIFA_BASE2.

SKIP.

*Ejercicio 3.6
data: TARIFA_SOC_FI  type i VALUE 2,
      TARIFA_SOC_CO type i VALUE 3,
      TARIFA_MULTI  type i.

TARIFA_MULTI = TARIFA_SOC_FI * TARIFA_SOC_CO.

WRITE / 'Ejercicio 3.6'.
WRITE: / 'Resultado: ', TARIFA_MULTI.

MULTIPLY TARIFA_MULTI BY 2.

WRITE: / 'Resultado: ', TARIFA_MULTI.

SKIP.

*Ejercicio 3.8
data: TARIFA_EJERCICIO TYPE i VALUE 28,
      TARIFA_PERIODO TYPE i VALUE 4,
      TARIFA_APLICADA TYPE p LENGTH 8 DECIMALS 2.

TARIFA_APLICADA = TARIFA_EJERCICIO / TARIFA_PERIODO.

WRITE: / 'Ejercicio 3.8 '.
WRITE: / 'Resultado: ',TARIFA_APLICADA.

DIVIDE TARIFA_APLICADA BY 3.

WRITE: / 'Resultado: ',TARIFA_APLICADA.

SKIP.

*Ejercicio 3.10
data: NUM_A TYPE i VALUE 17,
      NUM_B TYPE i VALUE 4,
      RESULTADO TYPE p LENGTH 4 DECIMALS 2.

RESULTADO = NUM_A DIV NUM_B.

WRITE: / 'Ejercicio 3.10'.
WRITE: / 'Resultado: ', RESULTADO.

SKIP.

*Ejercicio 3.12
data: NUMEROA TYPE i VALUE 17,
      NUMEROB TYPE i VALUE 4,
      RESULTADOS TYPE P LENGTH 4 DECIMALS 2.

RESULTADOS = NUMEROA MOD NUMEROB.

WRITE: / 'Ejercicios 3.12'.
WRITE: / 'Resultado: ',RESULTADOS.

SKIP.

*EJERCICIO 3.14
data: NUMERO TYPE i VALUE 5.

NUMERO = NUMERO ** 2.

WRITE: /'Ejercicio 3.14'.
WRITE: / 'Resultado: ',NUMERO.

SKIP.

*Ejercicio 3.16
NUMERO = SQRT( NUMERO ).

WRITE: /'Ejercicio 3.16'.
WRITE: /'Resultado: ',NUMERO.
