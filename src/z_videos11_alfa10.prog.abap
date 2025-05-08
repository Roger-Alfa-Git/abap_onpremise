*&---------------------------------------------------------------------*
*& Report Z_VIDEOS11_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_videos11_alfa10.

* Tabla ordenada - Sorted Table
DATA gt_materiales_ord TYPE SORTED TABLE OF mara WITH NON-UNIQUE KEY matnr.

*Tabla hased
DATA gt_materiales_has TYPE HASHED TABLE OF mara WITH UNIQUE KEY matnr.

DATA: gt_empleados TYPE STANDARD TABLE OF zemp_alfa10,
      gwa_empleado TYPE zemp_alfa10.

gwa_empleado-id     = '111111111A'.
gwa_empleado-email  = 'LUIS@LOGALISAP.COM'.
gwa_empleado-ape1   = 'VIÑA'.
*gwa_empleado-APE2
gwa_empleado-nombre = 'LUIS'.
gwa_empleado-fechan = '19910801'.
gwa_empleado-fechaa = '20200314'.

APPEND gwa_empleado TO gt_empleados.

APPEND gwa_empleado TO gt_empleados.

APPEND INITIAL LINE TO gt_empleados.

SELECT * FROM zemp_alfa10
  APPENDING TABLE gt_empleados
  WHERE fechaa GT '20200101'.

DATA gt_empleados_cab TYPE STANDARD TABLE OF zemp_alfa10 WITH HEADER LINE.

gt_empleados_cab-id     = '222222222A'.
gt_empleados_cab-email  = 'RUBEN@LOGALISAP.COM'.
gt_empleados_cab-ape1   = 'VIÑA'.
*gt_empleados_cab-APE2
gt_empleados_cab-nombre = 'RUBEN'.
gt_empleados_cab-fechan = '19910801'.
gt_empleados_cab-fechaa = '20200314'.

*APPEND gt_empleados_cab TO gt_empleados_cab.

APPEND gt_empleados_cab.

gt_empleados_cab-id     = '333333333A'.
gt_empleados_cab-email  = 'RUBEN@LOGALISAP.COM'.
gt_empleados_cab-ape1   = 'VIÑA'.
*gt_empleados_cab-APE2
gt_empleados_cab-nombre = 'RUBEN'.
gt_empleados_cab-fechan = '19910801'.
gt_empleados_cab-fechaa = '20200314'.

APPEND gt_empleados_cab.
*&---------------------------------------------------------------------*
*& Video 2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA: gt_mat_sorted TYPE SORTED TABLE OF mara WITH NON-UNIQUE KEY matnr ersda,
      gt_mat_hashed TYPE HASHED TABLE OF mara WITH UNIQUE KEY matnr,
      gwa_mat       TYPE mara.

gwa_mat-matnr = '3'.

INSERT gwa_mat INTO TABLE gt_mat_sorted.

gwa_mat-matnr = '2'.

INSERT gwa_mat INTO TABLE gt_mat_sorted.

gwa_mat-matnr = '1'.

INSERT gwa_mat INTO TABLE gt_mat_sorted.

INSERT gwa_mat INTO TABLE gt_mat_hashed.

WRITE 'FIN'.

*&---------------------------------------------------------------------*
*& Video 9
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA: gt_materiales TYPE STANDARD TABLE OF mara,
      gv_lineas     TYPE i.

SELECT * FROM mara
  INTO TABLE gt_materiales
  WHERE ersda EQ '20231023'.

IF sy-subrc EQ 0.
  DESCRIBE TABLE gt_materiales LINES gv_lineas.

  WRITE: / 'El numero total de registros = ', gv_lineas.
ENDIF.

*&---------------------------------------------------------------------*
*& Viedo 11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

DATA: gt_proveedores  TYPE STANDARD TABLE OF lfm1,
      gwa_proveedores TYPE lfm1.

SELECT * FROM lfm1
  INTO TABLE gt_proveedores
  WHERE lifnr IN ('DE-001', 'DE-002') AND ekorg EQ '2100' OR ekorg EQ '1000'.

IF sy-subrc EQ 0.

  READ TABLE gt_proveedores INTO gwa_proveedores
  WITH KEY  lifnr = 'DE-001'
            ekorg = '1210'.

  IF sy-subrc EQ 0.
    WRITE: / 'Nombre del responsable = ', gwa_proveedores-ernam.

  ENDIF.

ENDIF.

*&---------------------------------------------------------------------*
*& Viedo 13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

DATA: gt_sociedades  TYPE STANDARD TABLE OF t001,
      gwa_sociedades TYPE t001.

SELECT * FROM t001
  INTO TABLE gt_sociedades
  WHERE bukrs NE space.

IF sy-subrc EQ 0.

  LOOP AT gt_sociedades INTO gwa_sociedades.

*    WRITE: / gwa_sociedades-butxt, gwa_sociedades-waers.

  ENDLOOP.

  LOOP AT gt_sociedades TRANSPORTING NO FIELDS
    WHERE waers EQ 'EUR'.
    EXIT.
  ENDLOOP.

  IF sy-subrc EQ 0.
    WRITE: / 'Existe una sociedad con la moneda EUR'.
  ENDIF.
ENDIF.


*&---------------------------------------------------------------------*
*& Viedo 15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
SKIP 2.
SELECT * FROM t001
  INTO TABLE gt_sociedades
  WHERE bukrs NE space.

IF sy-subrc EQ 0.
  SORT gt_sociedades ASCENDING BY butxt waers.

  LOOP AT gt_sociedades INTO gwa_sociedades.
*    WRITE: / gwa_sociedades-butxt, gwa_sociedades-waers.

  ENDLOOP.
ENDIF.


*&---------------------------------------------------------------------*
*& Viedo 17
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

SKIP 2.
SELECT * FROM t001
  INTO TABLE gt_sociedades
  WHERE bukrs NE space.

IF sy-subrc EQ 0.
  SORT gt_sociedades ASCENDING BY butxt waers.

  LOOP AT gt_sociedades INTO gwa_sociedades.

    gwa_sociedades-waers = 'USD'.

    MODIFY gt_sociedades FROM gwa_sociedades.


  ENDLOOP.

  LOOP AT gt_sociedades INTO gwa_sociedades.
*    WRITE: / gwa_sociedades-butxt, gwa_sociedades-waers.

  ENDLOOP.
ENDIF.

*&---------------------------------------------------------------------*
*& Viedo 19
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA gt_facturas TYPE STANDARD TABLE OF vbrk WITH HEADER LINE.

SELECT * FROM vbrk
  INTO TABLE gt_facturas
  WHERE fkart EQ 'F2'.

IF sy-subrc EQ 0.

*  WRITE: / 'Las facturas antes de eliminar los registros'.
  SKIP.

  LOOP AT gt_facturas.

*    WRITE: / gt_facturas-vbeln.
  ENDLOOP.

  LOOP AT gt_facturas.

    IF sy-subrc GT 5.
      DELETE gt_facturas.
    ENDIF.

  ENDLOOP.

  SKIP 3.
*  WRITE: / 'Las facturas despues de eliminar los registros'.
  SKIP.
  DELETE gt_facturas INDEX 1.
  LOOP AT gt_facturas.

*    WRITE: / gt_facturas-vbeln.
  ENDLOOP.

ENDIF.


*&---------------------------------------------------------------------*
*& Viedo 21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

DATA: gt_proveedor  TYPE STANDARD TABLE OF lfa1 WITH HEADER LINE,
      gwa_proveedor TYPE lfa1.

SELECT * FROM lfa1
 INTO TABLE gt_proveedor
  UP TO 5 ROWS
  WHERE land1 EQ 'DE'.

IF sy-subrc EQ 0.
  LOOP AT gt_proveedor INTO gwa_proveedor.
*    WRITE: / gwa_proveedor-lifnr,
*             gwa_proveedor-stras.
  ENDLOOP.

  LOOP AT gt_proveedor INTO gwa_proveedor.

    IF sy-tabix GT 2.

      DELETE TABLE gt_proveedor FROM gwa_proveedor.

    ENDIF.

  ENDLOOP.

  SKIP 2.

*  WRITE: / 'El nuevo contenido de la tabla'.
  DELETE gt_proveedor INDEX 2.
  LOOP AT gt_proveedor INTO gwa_proveedor.
*    WRITE: / gwa_proveedor-lifnr,
*             gwa_proveedor-stras.
  ENDLOOP.
ENDIF.

*&---------------------------------------------------------------------*
*& Viedeo 23
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

TYPES: BEGIN OF proveedors,
         lifnr TYPE lifnr,
         land1 TYPE land1_gp,
         name1 TYPE name1_gp,
       END OF proveedors.

DATA: gt_mis_prov  TYPE STANDARD TABLE OF proveedors,
      gwa_mis_prov TYPE proveedors,
      gt_bd_prov   TYPE STANDARD TABLE OF lfa1,
      gwa_bd_prov  TYPE lfa1.

SELECT * FROM lfa1
  INTO TABLE gt_bd_prov
  WHERE land1 EQ 'DE'.

IF sy-subrc EQ 0.
  LOOP AT gt_bd_prov INTO gwa_bd_prov.

*    gwa_mis_prov-lifnr = gwa_bd_prov-lifnr.
*    gwa_mis_prov-land1 = gwa_bd_prov-land1.
*    gwa_mis_prov-name1 = gwa_bd_prov-name1.

    MOVE-CORRESPONDING gwa_bd_prov TO gwa_mis_prov.

    APPEND gwa_mis_prov TO gt_mis_prov.
  ENDLOOP.

  LOOP AT gt_mis_prov INTO gwa_mis_prov.
    WRITE: / gwa_mis_prov-lifnr,
             gwa_mis_prov-land1,
             gwa_mis_prov-name1.
  ENDLOOP.
ENDIF.
