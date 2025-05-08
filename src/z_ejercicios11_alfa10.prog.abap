*&---------------------------------------------------------------------*
*& Report Z_EJERCICIOS11_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ejercicios11_alfa10.

DATA: gt_empleados  TYPE STANDARD TABLE OF zemp_alfa10,
      gwa_empleados TYPE zemp_alfa10.

gwa_empleados-id     = '123456M'.
gwa_empleados-email  = 'FERNANDO@LOGALIGROUP.COM'.
gwa_empleados-ape1   = 'DOMINGUEZ'.
gwa_empleados-ape2   = 'OTERO'.
gwa_empleados-nombre = 'FERNANDO'.
gwa_empleados-fechan = '19850924'.
gwa_empleados-fechaa = '20180101'.

APPEND gwa_empleados TO gt_empleados.

WRITE: / 'Se inserto los datos'.

SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

DATA: gt_empleado  TYPE STANDARD TABLE OF zemp_alfa10 WITH HEADER LINE,
      gwa_empleado TYPE zemp_alfa10.

gwa_empleado-id     = '56864720P'.
gwa_empleado-email  = 'LUIS_TAL@LOGALIGROUP.COM'.
gwa_empleado-ape1   = 'GONZALES'.
gwa_empleado-ape2   = 'TALAVERA'.
gwa_empleado-nombre = 'LUIS'.
gwa_empleado-fechan = '19900726'.
gwa_empleado-fechaa = '19900726'.

APPEND gwa_empleado TO gt_empleado.

WRITE: / 'Se inserto los datos'.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

DATA: gt_clientes_ord  TYPE SORTED TABLE OF kna1 WITH UNIQUE KEY kunnr,
      gwa_clientes_ord TYPE kna1,

      gt_clientes_has  TYPE HASHED TABLE OF kna1 WITH UNIQUE KEY kunnr,
      gwa_clientes_has TYPE kna1.

gwa_clientes_ord-kunnr = '123456789'.

INSERT gwa_clientes_ord INTO TABLE gt_clientes_ord.

gwa_clientes_has-kunnr = '123456789'.

INSERT gwa_clientes_has INTO TABLE gt_clientes_has.


WRITE: / 'Se inserto los datos'.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA: gt_deudores  TYPE STANDARD TABLE OF kna1,
      gv_lineas    TYPE i,
      gwa_deudores TYPE kna1.

SELECT * FROM kna1
  INTO TABLE gt_deudores
  WHERE land1 EQ 'US'.

IF sy-subrc EQ 0.

  DESCRIBE TABLE gt_deudores LINES gv_lineas.

  WRITE: / 'El numero total de deudores = ', gv_lineas.
ENDIF.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

SELECT * FROM kna1
  INTO TABLE gt_deudores
  WHERE land1 EQ 'US'.

IF sy-subrc EQ 0.

*Se uso la region NE porque la IL que indica la plactica ya no exciste
  READ TABLE gt_deudores INTO gwa_deudores
  WITH KEY land1 = 'US'
           regio = 'NE'.

  IF sy-subrc EQ 0.

*    WRITE: / gwa_deudores-kunnr, gwa_deudores-land1, gwa_deudores-regio.

  ENDIF.

ENDIF.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

SELECT * FROM kna1
  INTO TABLE gt_deudores
  WHERE erdat GT '20050101'.

IF sy-subrc EQ 0.

  LOOP AT gt_deudores INTO gwa_deudores.
*    WRITE: / gwa_deudores-kunnr, gwa_deudores-erdat.
  ENDLOOP.

ENDIF.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

SELECT * FROM kna1
  INTO TABLE gt_deudores
  WHERE erdat GT '20050101'.

IF sy-subrc EQ 0.

  SORT gt_deudores DESCENDING BY erdat.

  LOOP AT gt_deudores INTO gwa_deudores.
*    WRITE: / gwa_deudores-kunnr, gwa_deudores-erdat.
  ENDLOOP.

ENDIF.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.18
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

SELECT * FROM kna1
  INTO TABLE gt_deudores
  WHERE erdat GT '20050101'.

*WRITE / 'Tabla del ejercicio 11.18'.

IF sy-subrc EQ 0.

*Cambie la fecha a 03.12.2020 ya que es el dato mas antiguo
  LOOP AT gt_deudores INTO gwa_deudores WHERE erdat = '20201203'.

    gwa_deudores-erdat = sy-datum.

    MODIFY gt_deudores FROM gwa_deudores .

  ENDLOOP.

  LOOP AT gt_deudores INTO gwa_deudores.
*    WRITE: / gwa_deudores-kunnr, gwa_deudores-erdat.
  ENDLOOP.

ENDIF.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.20
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA: gt_maestro TYPE STANDARD TABLE OF kna1 WITH HEADER LINE.

SELECT * FROM kna1
  INTO TABLE gt_maestro
  WHERE land1 EQ 'DE'.

*WRITE / 'Tabla del ejercicio 11.20'.
IF sy-subrc EQ 0.

*Se cambio la fecha de 24.06.1992 a 05.12.2020 porque el primer dato ya no existe
  LOOP AT gt_maestro WHERE erdat EQ '20201205'.

    DELETE gt_maestro.

  ENDLOOP.

  LOOP AT gt_maestro.
*    WRITE: / gt_maestro-kunnr, gt_maestro-erdat.
  ENDLOOP.
ENDIF.
SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA: gt_deudor  TYPE STANDARD TABLE OF kna1 WITH HEADER LINE,
      gwa_deudor TYPE kna1.

SELECT * FROM kna1
  INTO TABLE gt_deudor
  UP TO 5 ROWS
  WHERE land1 EQ 'US'.

*WRITE / 'Tabla del ejercicio 11.20'.
IF sy-subrc EQ 0.

  LOOP AT gt_deudor INTO gwa_deudor.
    "  WRITE: / gwa_deudor-kunnr,
    "          gwa_deudor-land1,
    "         gwa_deudor-erdat.
  ENDLOOP.


  LOOP AT gt_deudor INTO gwa_deudor.
    IF sy-tabix EQ 1.
      DELETE TABLE gt_deudor FROM gwa_deudor.
      EXIT.
    ENDIF.
  ENDLOOP.

  SKIP.

  "WRITE / 'Tabla 2 del ejercicio 11.20'.
  LOOP AT gt_deudor INTO gwa_deudor.
    " WRITE: / gwa_deudor-kunnr,
    "         gwa_deudor-land1,
    "        gwa_deudor-erdat.
  ENDLOOP.

ENDIF.

SKIP.
*&---------------------------------------------------------------------*
*& Ejercicio 11.24
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA: gt_mis_deud  TYPE STANDARD TABLE OF kna1 WITH HEADER LINE,
      gwa_mis_deud TYPE kna1,

      gt_bd_deud   TYPE STANDARD TABLE OF kna1,
      gwa_bd_deud  TYPE kna1.

SELECT * FROM kna1
  INTO TABLE gt_bd_deud
  WHERE land1 EQ 'US'.

IF sy-subrc EQ 0.

  LOOP AT gt_bd_deud INTO gwa_bd_deud.

    MOVE-CORRESPONDING gwa_bd_deud TO gwa_mis_deud.

    APPEND gwa_mis_deud TO gt_mis_deud.

  ENDLOOP.

WRITE / 'Tabla del Ejercicio 11.24'.
  LOOP AT gt_mis_deud INTO gwa_mis_deud.
    WRITE: / gwa_mis_deud-kunnr,
             gwa_mis_deud-land1,
             gwa_mis_deud-erdat.
  ENDLOOP.

ENDIF.
