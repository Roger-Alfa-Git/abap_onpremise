*&---------------------------------------------------------------------*
*& Include          ZGI_COVATEX_F04
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form INIT_4013
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4013 .

DYN_MOV = 'SAL_MAT'.
IF ztt_sal_mat-folio_sal_mat IS INITIAL.

  SELECT MAX( FOLIO_SAL_MAT )
    FROM ztc_sal_material
    INTO ( gv_max ).
  MOVE gv_max TO res.
  res = res + 1.
  MOVE res TO gv_max.
  ztt_sal_mat-folio_sal_mat = gv_max.
  ZTT_SAL_MAT-ALMACENISTA = SY-UNAME.
  ZTT_SAL_MAT-FECHA_SALIDA = SY-DATUM.
  ZTT_SAL_MAT-PESO_TOTAL = 0.
  ZTT_SAL_MAT-PESO_RESTANTE = 0.
ENDIF.

*BTN_ADD-Boton agregar
*BTN_REM-Registrar
*BTN_CAN-Cancelar
  PERFORM CONTAINERS_ENT_SAL USING 'SM'.

  CHECK OK_CODE_4013 IS NOT INITIAL.

  CASE OK_CODE_4013.
    WHEN 'BTN_ADD'.
      CLEAR OK_CODE_4013.
      PERFORM VALID_INSERTAR_SAL_MAT.
    WHEN 'BTN_REM'.
      CLEAR OK_CODE_4013.
      CLEAR: FGL.
      PERFORM VALID_INSERT_ALL_SAL_MAT.
*      PERFORM INSERT_ALL_SAL_MAT.
      IF FGL EQ abap_false.
        PERFORM DELETE_SAL_MAT.
        CLEAR: ztt_sal_mat-folio_sal_mat,
               ZTC_EMPLEADOS-NOMBRE,
               ztt_sal_mat-id_empleado,
               ztt_sal_mat-fecha_salida,
               ztt_sal_mat-almacenista,
               ztt_sal_mat-peso_total,
               ztt_sal_mat-peso_restante.
          LEAVE TO SCREEN 0.
      ENDIF.

    WHEN 'BTN_CAN'.
      CLEAR OK_CODE_4013.
      PERFORM DELETE_SAL_MAT.
      CLEAR: ztt_sal_mat-peso_total,
             ztt_sal_mat-peso_restante.
    WHEN OTHERS.
  ENDCASE.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_SAL_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_sal_mat .

  DATA: lv_rollos TYPE I,
        lv_peso TYPE I.

   SELECT SINGLE ROLLOS
    INTO lv_rollos
    FROM ZTC_MATERIALES
    WHERE ID_MATERIAL = ztt_sal_mat-id_material.

   SELECT SINGLE PESO
    INTO lv_peso
    FROM ZTC_MATERIALES
    WHERE ID_MATERIAL = ztt_sal_mat-id_material.

     IF lv_rollos < ztt_sal_mat-rollos.
       tc = 'Rollos'.
       MESSAGE s018(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No puedes pedir mas material del que hay en el almacen' TYPE 'I'.
        EXIT.
       ELSE.

     ENDIF.

     IF lv_peso < ztt_sal_mat-peso.
       tc = 'Peso'.
       MESSAGE s018(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No puedes pedir mas material del que hay en el almacen' TYPE 'I'.
        EXIT.
       ELSE.

     ENDIF.

          ztt_sal_mat-peso_total = ztt_sal_mat-peso_total + ztt_sal_mat-peso.
          ztt_sal_mat-peso_restante = ztt_sal_mat-peso_restante + ztt_sal_mat-peso.


          gwa_sal_mat-mandt = sy-uname.
          gwa_sal_mat-folio_sal_mat = ztt_sal_mat-folio_sal_mat.
          gwa_sal_mat-id_empleado = ztt_sal_mat-id_empleado.
          gwa_sal_mat-fecha_salida = ztt_sal_mat-fecha_salida.
          gwa_sal_mat-almacenista = ztt_sal_mat-almacenista.
*----------------------------------------------------------------------
          gwa_sal_mat-estatus = 'NUEVO'.
          gwa_sal_mat-peso_total = ztt_sal_mat-peso_total.
          gwa_sal_mat-peso_restante = ztt_sal_mat-peso_restante.
          gwa_sal_mat-tipo_rollo = ztt_sal_mat-tipo_rollo.
*----------------------------------------------------------------------
          gwa_sal_mat-id_material = ztt_sal_mat-id_material.
          gwa_sal_mat-descripcion = ztt_sal_mat-descripcion.
          gwa_sal_mat-color = ztt_sal_mat-color.
          gwa_sal_mat-rollos = ztt_sal_mat-rollos.
          gwa_sal_mat-metros = ztt_sal_mat-metros.
          gwa_sal_mat-peso = ztt_sal_mat-peso.
          gwa_sal_mat-icon = '@02@'.

          INSERT INTO ztt_sal_mat VALUES gwa_sal_mat.

          IF sy-subrc EQ 0.
              MESSAGE 'Material Disponible' TYPE 'I'.
              CLEAR: "ztt_sal_mat-folio_sal_mat,
                     "ztt_sal_mat-id_empleado,
                     "ztt_sal_mat-fecha_salida,
                     "ztt_sal_mat-almacenista,
                     "ztt_sal_mat-peso_total,
                     "ztt_sal_mat-peso_restante,
                     ztt_sal_mat-tipo_rollo,
                     ztt_sal_mat-id_material,
                     ztt_sal_mat-descripcion,
                     ztt_sal_mat-color,
                     ztt_sal_mat-rollos,
                     ztt_sal_mat-metros,
                     ztt_sal_mat-peso.
              PERFORM CONTAINERS_ENT_SAL USING 'SM'.
            ELSE.
              MESSAGE s014(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
          ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERT_ALL_SAL_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_all_sal_mat .

  CLEAR: mlt_sal_mat,
         t_sal_matt,
         mls_tc_sal_materiales,
         t_sal_matc,
         s_sal_matc.

  FGL = abap_false.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
    SELECT FOLIO_SAL_MAT
           ID_EMPLEADO
           FECHA_SALIDA
           ALMACENISTA
           ESTATUS
           PESO_TOTAL
           PESO_RESTANTE
      INTO CORRESPONDING FIELDS OF TABLE mlt_sal_mat
      FROM ztt_sal_mat.

    SELECT FOLIO_SAL_MAT
           ID_MATERIAL
           ROLLOS
           TIPO_ROLLO
           METROS
           PESO
     INTO CORRESPONDING FIELDS OF TABLE t_sal_matt
      FROM ztt_sal_mat.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

    IF t_sal_matt IS NOT INITIAL.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

          mls_tc_sal_materiales-FOLIO_SAL_MAT = ztt_sal_mat-FOLIO_SAL_MAT.
          mls_tc_sal_materiales-ID_EMPLEADO   = ztt_sal_mat-ID_EMPLEADO.
          mls_tc_sal_materiales-FECHA_SALIDA  = ztt_sal_mat-FECHA_SALIDA.
          mls_tc_sal_materiales-ALMACENISTA   = ztt_sal_mat-ALMACENISTA.
          mls_tc_sal_materiales-ESTATUS       = 'NUEVO'.
          mls_tc_sal_materiales-PESO_TOTAL    = ztt_sal_mat-PESO_TOTAL.
          mls_tc_sal_materiales-PESO_RESTANTE = ztt_sal_mat-PESO_RESTANTE.

          INSERT INTO ZTC_SAL_MATERIAL VALUES mls_tc_sal_materiales.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

      LOOP AT t_sal_matt INTO s_sal_matt.
        CLEAR: s_sal_matc.
        s_sal_matc-folio_sal_mat = s_sal_matt-folio_sal_mat.
        s_sal_matc-id_material = s_sal_matt-id_material.
        s_sal_matc-rollos = s_sal_matt-rollos.
        s_sal_matc-tipo_rollo = s_sal_matt-tipo_rollo.
        s_sal_matc-metros = s_sal_matt-metros.
        s_sal_matc-peso = s_sal_matt-peso.
        APPEND s_sal_matc TO t_sal_matc.
      ENDLOOP.

      INSERT ztc_sal_mat_deta FROM TABLE t_sal_matc.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**----------------------------------SALIDA DE ROLLOS-------------------------------------------------
* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_sal_mat INTO TABLE lt_sal_mat.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_materiales INTO TABLE lt_sal_materiales.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_sal_mat INTO ls_sal_mat.
  CLEAR lv_sal_mat_resta.
  lv_sal_mat_id = ls_sal_mat-id_material.

  " Paso 4: Hace la operacion en los valores de CampoTabla1
  LOOP AT lt_sal_mat INTO ls_sal_mat WHERE id_material = lv_sal_mat_id.
    lv_sal_mat_resta = lv_sal_mat_resta - ls_sal_mat-rollos.
  ENDLOOP.

  " Paso 5: Agregar la operacion a CampoTabla2 en Tabla2
  LOOP AT lt_sal_materiales INTO ls_sal_materiales WHERE id_material = lv_sal_mat_id.
    IF ls_sal_mat-tipo_rollo = 'COMPLETO'.
        ls_sal_materiales-rollos = ls_sal_materiales-rollos + lv_sal_mat_resta.
      ELSEIF ls_sal_mat-tipo_rollo = 'INCOMPLETO'.
        ls_sal_materiales-rollos_incompletos = ls_sal_materiales-rollos_incompletos + lv_sal_mat_resta.
    ENDIF.

*    ls_sal_materiales-rollos = ls_sal_materiales-rollos + lv_sal_mat_resta.
          APPEND ls_sal_materiales TO lt_sal_result.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
      LOOP AT lt_sal_result INTO ls_sal_materiales.
           MODIFY ztc_materiales FROM ls_sal_materiales.
      ENDLOOP.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**----------------------------------SALIDA DE ROLLOS-------------------------------------------------
* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_sal_mat INTO TABLE lt_sal_mat.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_materiales INTO TABLE lt_sal_materiales.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_sal_mat INTO ls_sal_mat.
  CLEAR lv_sal_mat_resta.
  lv_sal_mat_id = ls_sal_mat-id_material.

  " Paso 4: Hace la operacion en los valores de CampoTabla1
  LOOP AT lt_sal_mat INTO ls_sal_mat WHERE id_material = lv_sal_mat_id.
    lv_sal_mat_resta = lv_sal_mat_resta - ls_sal_mat-peso.
  ENDLOOP.

  " Paso 5: Agregar la operacion a CampoTabla2 en Tabla2
  LOOP AT lt_sal_materiales INTO ls_sal_materiales WHERE id_material = lv_sal_mat_id.
    ls_sal_materiales-peso = ls_sal_materiales-peso + lv_sal_mat_resta.
          APPEND ls_sal_materiales TO lt_sal_result.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
      LOOP AT lt_sal_result INTO ls_sal_materiales.
           MODIFY ztc_materiales FROM ls_sal_materiales.
      ENDLOOP.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------


                IF sy-subrc = 0.
                    MESSAGE 'Se ha realizado el registro.' TYPE 'I'.
                  ELSE.
                    MESSAGE 'Error al registrar entrada de datos.' TYPE 'I'.
                  ENDIF.
            ELSE.
              MESSAGE s022(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No se encontraron registros.'TYPE 'I'.
        FGL = abap_true.
        EXIT.
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DELETE_SAL_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_sal_mat .

  DELETE FROM ztt_sal_mat WHERE folio_sal_mat GT 0.

  CLEAR:ztt_sal_mat-tipo_rollo,
        ztt_sal_mat-id_material,
        ztt_sal_mat-descripcion,
        ztt_sal_mat-color,
        ztt_sal_mat-rollos,
        ztt_sal_mat-metros,
        ztt_sal_mat-peso.
  PERFORM CONTAINERS_ENT_SAL USING 'SM'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERTAR_SAL_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insertar_sal_mat .

     IF ZTC_EMPLEADOS-NOMBRE IS INITIAL.
         tc = 'ID MAQUILERO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No existe este maquilero' TYPE 'I'.
        EXIT.
     ENDIF.

     IF ztt_sal_mat-id_empleado = 0 OR ztt_sal_mat-id_empleado IS INITIAL.
       tc = 'ID MAQUILERO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.


      tc = 'ALMACENISTA'.
      l_string = ztt_sal_mat-ALMACENISTA.
      IF ztt_sal_mat-ALMACENISTA IS NOT INITIAL.
          PERFORM valid_espacios.
          IF  reg_prod eq abap_true.
              PERFORM valid_nums_lets.
              IF  reg_prod eq abap_true.
                    PERFORM valid_palabras_ofensivas.
                      IF  reg_prod eq abap_true.

                        ELSE.
                          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                          EXIT.
                        ENDIF.
                  ELSE.
                    MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                    EXIT.
              ENDIF.
              ELSE.
              MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
              EXIT.
          ENDIF.
        ELSE.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
          EXIT.
      ENDIF.

     IF ztt_sal_mat-fecha_salida IS INITIAL.
       tc = 'FECHA DE SALIDA'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_sal_mat-id_material = 0 OR ztt_sal_mat-id_material IS INITIAL.
       tc = 'ID MATERIAL'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_sal_mat-rollos = 0 OR ztt_sal_mat-rollos IS INITIAL.
       tc = 'ROLLOS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_sal_mat-metros = 0 OR ztt_sal_mat-metros IS INITIAL.
       tc = 'METROS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_sal_mat-peso = 0 OR ztt_sal_mat-peso IS INITIAL.
       tc = 'PESO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

*     IF ztt_sal_mat-peso_total = 0 OR ztt_sal_mat-peso_total IS INITIAL.
*       tc = 'PESO_TOTAL'.
*       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*       EXIT.
*     ENDIF.
*
*     IF ztt_sal_mat-peso_restante IS INITIAL.
*       tc = 'PESO RESTANTE'.
*       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*       EXIT.
*     ENDIF.

     IF ztt_sal_mat-tipo_rollo IS INITIAL.
       tc = 'TIPO DE ROLLO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     PERFORM INSERTAR_SAL_MAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ICON_ELI_MAT_ENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM icon_eli_mat_ent .

*MESSAGE s011(zgi_cv_ms) WITH fol DISPLAY LIKE 'E'.

DATA: lt_ztt_ent_mat TYPE TABLE OF ZTT_ENT_MAT,
      ls_selected_row TYPE ZTT_ENT_MAT.

* Realiza la selección de los registros de la tabla
SELECT * FROM ZTT_ENT_MAT INTO TABLE lt_ztt_ent_mat UP TO fol ROWS.

* Verifica si hay al menos 5 registros en la tabla
IF lines( lt_ztt_ent_mat ) >= fol.
* Obtén el quinto registro
  ls_selected_row = lt_ztt_ent_mat[ fol ].

* Ahora ls_selected_row contiene el registro que estás buscando
DATA lv_folio_ent_mat TYPE ZTT_ENT_MAT-FOLIO_ENT_MAT.
     lv_folio_ent_mat = ls_selected_row-FOLIO_ENT_MAT.

DATA lv_id_mat TYPE ZTT_ENT_MAT-id_material.
     lv_id_mat = ls_selected_row-id_material.
* Muestra el valor del campo FOLIO_ENT_MAT
*    MESSAGE s011(zgi_cv_ms) WITH lv_id_mat DISPLAY LIKE 'E'
ENDIF.

DELETE FROM ztt_ent_mat WHERE folio_ent_mat eq lv_folio_ent_mat AND id_material eq lv_id_mat.

IF SY-SUBRC EQ 0.
*  MESSAGE 'Se elimino el registro' TYPE 'I'.
ENDIF.

CLEAR: FOL.

PERFORM CONTAINERS_ENT_SAL USING 'EM'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ICON_ELI_SAL_ENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM icon_eli_sal_ent .

  DATA: lt_ztt_sal_mat TYPE TABLE OF ZTT_SAL_MAT,
        ls_selected_row TYPE ZTT_SAL_MAT.

*     Realiza la selección de los registros de la tabla
    SELECT * FROM ZTT_SAL_MAT INTO TABLE lt_ztt_sal_mat UP TO fol ROWS.

*     Verifica si hay al menos 5 registros en la tabla
IF lines( lt_ztt_sal_mat ) >= fol.
*     Obtén el quinto registro
      ls_selected_row = lt_ztt_sal_mat[ fol ].

*     Ahora ls_selected_row contiene el registro que estás buscando
    DATA lv_folio_sal_mat TYPE ZTT_SAL_MAT-FOLIO_SAL_MAT.
         lv_folio_sal_mat = ls_selected_row-FOLIO_SAL_MAT.

    DATA lv_id_mat TYPE ZTT_SAL_MAT-id_material.
         lv_id_mat = ls_selected_row-id_material.

    DATA lv_peso_sal_mat TYPE ZTT_SAL_MAT-peso.
         lv_peso_sal_mat = ls_selected_row-peso.

    ztt_sal_mat-peso_total    = ztt_sal_mat-peso_total    - lv_peso_sal_mat.
    ztt_sal_mat-peso_restante = ztt_sal_mat-peso_restante - lv_peso_sal_mat.

ENDIF.

DELETE FROM ztt_sal_mat WHERE folio_sal_mat eq lv_folio_sal_mat AND id_material eq lv_id_mat.

  IF SY-SUBRC EQ 0.
*    MESSAGE 'Se elimino el registro' TYPE 'I'.
  ENDIF.

  CLEAR: FOL.
  PERFORM CONTAINERS_ENT_SAL USING 'SM'.
*  REFRESH CONTROL ztt_sal_mat-peso_total FROM SCREEN '4013'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ICON_ELI_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM icon_eli_ent_pro .

*  MESSAGE 'Llega aqui' TYPE 'I'.


DATA: lt_ztt_ent_prod TYPE TABLE OF ztt_ent_pro,
      ls_selected_row TYPE ztt_ent_pro.

*     Realiza la selección de los registros de la tabla
    SELECT * FROM ztt_ent_pro INTO TABLE lt_ztt_ent_prod UP TO fol ROWS.


*     Verifica si hay al menos 5 registros en la tabla
IF lines( lt_ztt_ent_prod ) >= fol.

*     Obtén el quinto registro
      ls_selected_row = lt_ztt_ent_prod[ fol ].

*     Ahora ls_selected_row contiene el registro que estás buscando
    DATA lv_folio_ent_prod TYPE ztt_ent_pro-folio_ent_pro.
         lv_folio_ent_prod = ls_selected_row-folio_ent_pro.
    DATA lv_id_ent_prod TYPE ztt_ent_pro-id_producto.
         lv_id_ent_prod = ls_selected_row-id_producto.
    DATA lv_peso_ent_prod TYPE ztt_ent_pro-peso.
         lv_peso_ent_prod = ls_selected_row-peso.

    ztt_ent_pro-peso_total = ztt_ent_pro-peso_total - lv_peso_ent_prod.

ENDIF.

DELETE FROM ztt_ent_pro WHERE folio_ent_pro eq lv_folio_ent_prod AND id_producto eq lv_id_ent_prod.

  IF SY-SUBRC EQ 0.
*    MESSAGE 'Se elimino el registro' TYPE 'I'.
  ENDIF.

  CLEAR: FOL.
  PERFORM CONTAINERS_ENT_SAL USING 'EP'.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form ICON_ELI_DEV_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM icon_eli_dev_pro .

DATA: lt_ztt_dev_prod TYPE TABLE OF ztt_dev_producto,
      ls_selected_row TYPE ztt_dev_producto.

*     Realiza la selección de los registros de la tabla
    SELECT * FROM ztt_dev_producto INTO TABLE lt_ztt_dev_prod UP TO fol ROWS.


*     Verifica si hay al menos 5 registros en la tabla
IF lines( lt_ztt_dev_prod ) >= fol.

*     Obtén el quinto registro
      ls_selected_row = lt_ztt_dev_prod[ fol ].

*     Ahora ls_selected_row contiene el registro que estás buscando
    DATA lv_folio_ent_prod TYPE ztt_dev_producto-folio_ent_pro.
         lv_folio_ent_prod = ls_selected_row-folio_ent_pro.
    DATA lv_id_dev_prod TYPE ztt_dev_producto-id_material.
         lv_id_dev_prod = ls_selected_row-id_material.
    DATA lv_peso_dev_prod TYPE ztt_dev_producto-peso.
         lv_peso_dev_prod = ls_selected_row-peso.

*         MESSAGE s013(zgi_cv_ms) WITH lv_id_dev_prod DISPLAY LIKE 'E'.
    ztt_ent_pro-peso_total = ztt_ent_pro-peso_total - lv_peso_dev_prod.

ENDIF.

DELETE FROM ztt_dev_producto WHERE folio_ent_pro eq lv_folio_ent_prod AND id_material eq lv_id_dev_prod.

IF SY-SUBRC EQ 0.
*    MESSAGE 'Se elimino el registro' TYPE 'I'.
  ENDIF.

  CLEAR: FOL.
  PERFORM CONTAINERS_ENT_SAL2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ICON_ELI_SAL_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM icon_eli_sal_pro .

DATA: lt_ztt_sal_prod TYPE TABLE OF ztt_sal_pro,
      ls_selected_row TYPE ztt_sal_pro.

*     Realiza la selección de los registros de la tabla
    SELECT * FROM ztt_sal_pro INTO TABLE lt_ztt_sal_prod UP TO fol ROWS.


*     Verifica si hay al menos 5 registros en la tabla
IF lines( lt_ztt_sal_prod ) >= fol.

*     Obtén el quinto registro
      ls_selected_row = lt_ztt_sal_prod[ fol ].

*     Ahora ls_selected_row contiene el registro que estás buscando
    DATA lv_folio_sal_prod TYPE ztt_sal_pro-folio_sal_pro.
         lv_folio_sal_prod = ls_selected_row-folio_sal_pro.
    DATA lv_id_sal_prod TYPE ztt_sal_pro-id_producto.
         lv_id_sal_prod = ls_selected_row-id_producto.
*    DATA lv_peso_dev_prod TYPE ztt_dev_producto-peso.
*         lv_peso_dev_prod = ls_selected_row-peso.

*         MESSAGE s013(zgi_cv_ms) WITH lv_folio_sal_prod DISPLAY LIKE 'E'.
*    ztt_ent_pro-peso_total = ztt_ent_pro-peso_total - lv_peso_dev_prod.

ENDIF.

DELETE FROM ztt_sal_pro WHERE folio_sal_pro eq lv_folio_sal_prod AND id_producto eq lv_id_sal_prod.

IF SY-SUBRC EQ 0.
*    MESSAGE 'Se elimino el registro' TYPE 'I'.
  ENDIF.

  CLEAR: FOL.
  PERFORM CONTAINERS_ENT_SAL USING 'SP'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CARGAR_EXCEL_PROVEEDORES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cargar_excel_proveedores .

*  MESSAGE 'Llega aqui' TYPE 'I'.

DATA: CE TYPE I.

  masc = |xlsx (*.xlsx)\|*.xlsx|. "Variable para admitir solo archivos de excel

    TRY.
*-------------------Funcion encargada de abrir el explorador de archivos-----------------
  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
    EXPORTING
      static        = 'X'
      mask          = masc
    CHANGING
      file_name     = p_arch "Esta variable obtiene el directorio del archivo de manera interna
    EXCEPTIONS
      mask_too_long = 1
      OTHERS        = 2.

*--------Funcion encargada de leer el contenido del excel
  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      filename                = p_arch "Aqui admite el directorio del archivo
      i_begin_col             = 1 "En que columna del Excel comenzara el recorrido
      i_begin_row             = 1 "En que fila del Excel comenzara el recorrido
      i_end_col               = 17 "En que columna del Excel Finalizara el recorrido
      i_end_row               = 1000 "En que fila del Excel Finalizara el recorrido
    TABLES
      intern                  = gt_arch
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      others                  = 3.

*" Verificar las columnas en la estructura
LOOP AT gt_arch INTO DATA(lv_row).
  LOOP AT gt_arch INTO DATA(lv_column).
    IF lv_column-col eq 1 AND lv_row-row eq 1 AND lv_column-value EQ 'NOMBRE'.
*      l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 2 AND lv_row-row eq 1 AND lv_column-value EQ 'APELLIDO_PATERNO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 3 AND lv_row-row eq 1 AND lv_column-value EQ 'APELLIDO_MATERNO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 4 AND lv_row-row eq 1 AND lv_column-value EQ 'TIPO_PERSONA'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 5 AND lv_row-row eq 1 AND lv_column-value EQ 'RFC'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 6 AND lv_row-row eq 1 AND lv_column-value EQ 'RAZON_SOCIAL'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 7 AND lv_row-row eq 1 AND lv_column-value EQ 'REGIMEN_FISCAL'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 8 AND lv_row-row eq 1 AND lv_column-value EQ 'CALLE'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 9 AND lv_row-row eq 1 AND lv_column-value EQ 'COLONIA'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 10 AND lv_row-row eq 1 AND lv_column-value EQ 'MUNICIPIO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 11 AND lv_row-row eq 1 AND lv_column-value EQ 'ESTADO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 12 AND lv_row-row eq 1 AND lv_column-value EQ 'NO_EXTERIOR'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 13 AND lv_row-row eq 1 AND lv_column-value EQ 'NO_INTERIOR'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 14 AND lv_row-row eq 1 AND lv_column-value EQ 'CP'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 15 AND lv_row-row eq 1 AND lv_column-value EQ 'TELEFONO1'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 16 AND lv_row-row eq 1 AND lv_column-value EQ 'TELEFONO2'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 17 AND lv_row-row eq 1 AND lv_column-value EQ 'EMAIL'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.

  ENDLOOP.

    IF CE EQ 17.
          MESSAGE 'El archivo si tiene la misma estructura' TYPE 'I'.
          exit.
        ELSE.
          MESSAGE s016(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
          RETURN.
**          ROLLBACK WORK.
    ENDIF.

ENDLOOP.

DATA VALID_MULT_PROV TYPE I.

IF CE EQ 17.
*----------------------------------------------------------------------
*----------------------------------------------------------------------
*----------------------------------------------------------------------
  LOOP AT gt_arch INTO DATA(llv_row).
        LOOP AT gt_arch INTO DATA(llv_column).
*----------------------------------------------------------------------
          IF llv_column-col = 1 AND llv_column-value NE 'NOMBRE'.
              tc = 'NOMBRE'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 2 AND llv_column-value NE 'APELLIDO_PATERNO'.
              tc = 'APELLIDO_PATERNO'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 3 AND llv_column-value NE 'APELLIDO_MATERNO'.
              tc = 'APELLIDO_MATERNO'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 4 AND llv_column-value NE 'TIPO_PERSONA'.
              tc = 'TIPO_PERSONA'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 5 AND llv_column-value NE 'RFC'.
              tc = 'RFC'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_rfc_prov.
                  IF reg_prod eq abap_true.
                      PERFORM valid_palabras_ofensivas.
                      IF reg_prod eq abap_true.
                          er = er + 1.
                        ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                    ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 6 AND llv_column-value NE 'RAZON_SOCIAL'.
              tc = 'RAZON_SOCIAL'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 7 AND llv_column-value NE 'REGIMEN_FISCAL'.
              tc = 'REGIMEN_FISCAL'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_solo_nums.
                      IF  reg_prod eq abap_true.

                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                            RETURN.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 8 AND llv_column-value NE 'CALLE'.
              tc = 'CALLE'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_nums_lets.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 9 AND llv_column-value NE 'COLONIA'.
              tc = 'COLONIA'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 10 AND llv_column-value NE 'MUNICIPIO'.
              tc = 'MUNICIPIO'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 11 AND llv_column-value NE 'ESTADO'.
              tc = 'ESTADO'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                  PERFORM valid_espacios.
                  IF  reg_prod eq abap_true.
                      PERFORM valid_letras.
                      IF  reg_prod eq abap_true.
                            PERFORM valid_palabras_ofensivas.
                              IF  reg_prod eq abap_true.
*                                  er = er + 1.
                                ELSE.
                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
                                ENDIF.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                      ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
                  ENDIF.
                ELSE.
                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 12 AND llv_column-value NE 'NO_EXTERIOR'.
              tc = 'NO_EXTERIOR'.
              l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
              PERFORM valid_solo_nums.
              IF  reg_prod eq abap_true.

                  ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                    RETURN.
              ENDIF.
              ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                    RETURN.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 13 AND llv_column-value NE 'NO_INTERIOR'.
              tc = 'NO_INTERIOR'.
              l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
              PERFORM valid_solo_nums.
              IF  reg_prod eq abap_true.

                  ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                    RETURN.
              ENDIF.
              ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                    RETURN.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 14 AND llv_column-value NE 'CP'.
              tc = 'CP'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                PERFORM valid_solo_nums.
                IF  reg_prod eq abap_true.
                      PERFORM valid_cp.
                      IF  reg_prod eq abap_true.
*                            er = er + 1.
                          ELSE.
                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
                      ENDIF.
                    ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                      RETURN.
                ENDIF.
                ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                      RETURN.
                ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 15 AND llv_column-value NE 'TELEFONO1'.
              tc = 'TELEFONO1'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                    PERFORM valid_solo_nums.
                    IF  reg_prod eq abap_true.
                        PERFORM valid_telefono.
                          IF  reg_prod eq abap_true.
*                                er = er + 1.
                              ELSE.
                                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                VALID_MULT_PROV = VALID_MULT_PROV + 1.
                          ENDIF.
                    ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_PROV = VALID_MULT_PROV + 1.
                    ENDIF.
                ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                      RETURN.
                ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 16 AND llv_column-value NE 'TELEFONO2'.
              tc = 'TELEFONO2'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                    PERFORM valid_solo_nums.
                    IF  reg_prod eq abap_true.
                        PERFORM valid_telefono.
                          IF  reg_prod eq abap_true.
*                                er = er + 1.
                              ELSE.
                                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                VALID_MULT_PROV = VALID_MULT_PROV + 1.
                          ENDIF.
                    ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_PROV = VALID_MULT_PROV + 1.
                    ENDIF.
                ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                      RETURN.
                ENDIF.
          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 17 AND llv_column-value NE 'EMAIL'.
              tc = 'EMAIL'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                    PERFORM valid_email.
                    IF  reg_prod eq abap_true.
                      PERFORM valid_palabras_ofensivas.
                      IF  reg_prod eq abap_true.
                          er = er + 1.
                        ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_PROV = VALID_MULT_PROV + 1.
                       ENDIF.
                       ELSE.
                         MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                         VALID_MULT_PROV = VALID_MULT_PROV + 1.
                    ENDIF.
                ELSE.
                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                      RETURN.
                ENDIF.
          ENDIF.
*----------------------------------------------------------------------
         ENDLOOP.
      ENDLOOP.

*----------------------------------------------------------------------
*----------------------------------------------------------------------
*----------------------------------------------------------------------
ENDIF.

IF VALID_MULT_PROV > 0.

  ELSE.
    PERFORM insert_multi_datos_prov.
ENDIF.

CATCH cx_root INTO DATA(e_text).

      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form insert_multi_datos_prov
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_multi_datos_prov .

SELECT MAX( id_proveedor )
    FROM ztc_proveedores
    INTO ( gv_max ).
  MOVE gv_max TO res.

*-------------------------------------------------------------------------------------------------
*-------------------------------------------------------------------------------------------------
*-------------------------------------------------------------------------------------------------
*-------------------------------------------------------------------------------------------------
    TRY.

*--------Funcion encargada de leer el contenido del excel
  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      filename                = p_arch "Aqui admite el directorio del archivo
      i_begin_col             = 1 "En que columna del Excel comenzara el recorrido
      i_begin_row             = 2 "En que fila del Excel comenzara el recorrido
      i_end_col               = 17 "En que columna del Excel Finalizara el recorrido
      i_end_row               = 1000 "En que fila del Excel Finalizara el recorrido
    TABLES
      intern                  = gt_arch
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      others                  = 3.

*---------Aqui se hace un recorrido por cada una-----------
*--------de las celdas del excel-----------------
  IF NOT gt_arch[] IS INITIAL.
    LOOP AT  gt_arch INTO gwa_arch.
      CASE gwa_arch-col.
*          WHEN 1."Se considera cada celda como posiciones y se mueve tomando los movimientos como case
*            res = res + 1.
*            MOVE res TO gwa_mat-id_material."Le da el valor de la celda a la variable
          WHEN 1.
            res = res + 1.
            MOVE res TO gwa_prov-id_proveedor.
            MOVE gwa_arch-value TO gwa_prov-nombre.
          WHEN 2.
            MOVE gwa_arch-value TO gwa_prov-apellido_paterno.
          WHEN 3.
            MOVE gwa_arch-value TO gwa_prov-apellido_materno.
          WHEN 4.
            MOVE gwa_arch-value TO gwa_prov-tipo_persona.
          WHEN 5.
            MOVE gwa_arch-value TO gwa_prov-rfc.
          WHEN 6.
            MOVE gwa_arch-value TO gwa_prov-razon_social.
          WHEN 7.
            MOVE gwa_arch-value TO gwa_prov-regimen_fiscal.
          WHEN 8.
            MOVE gwa_arch-value TO gwa_prov-calle.
          WHEN 9.
            MOVE gwa_arch-value TO gwa_prov-colonia.
          WHEN 10.
            MOVE gwa_arch-value TO gwa_prov-municipio.
          WHEN 11.
            MOVE gwa_arch-value TO gwa_prov-estado.
          WHEN 12.
            MOVE gwa_arch-value TO gwa_prov-no_exterior.
          WHEN 13.
            MOVE gwa_arch-value TO gwa_prov-no_interior.
          WHEN 14.
            MOVE gwa_arch-value TO gwa_prov-cp.
          WHEN 15.
            MOVE gwa_arch-value TO gwa_prov-telefono1.
          WHEN 16.
            MOVE gwa_arch-value TO gwa_prov-telefono2.
          WHEN 17.
            MOVE gwa_arch-value TO gwa_prov-email.
      ENDCASE.

      AT END OF row."Durante el ciclo se lee el dato dentro de la tabla interna
        APPEND gwa_prov TO gt_prov.
        INSERT INTO zte_proveedores VALUES gwa_prov."Despues de leer el dato, se inserta la fila en la tabla interna.
        CLEAR gwa_prov."Se limpia la variable para que pueda tener la siguiente entrada
        ENDAT.

    ENDLOOP.

  ENDIF.

  CATCH cx_root INTO DATA(e_text).

      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.

*---------------------------------------------------------------------------------------------------------------
*---------------------------------------------------------------------------------------------------------------
*---------------------------------------------------------------------------------------------------------------
*---------------------------------------------------------------------------------------------------------------
DATA: lt_prov TYPE TABLE OF zte_proveedores,
      lv_count      TYPE i.

SELECT * FROM zte_proveedores INTO TABLE lt_prov.

LOOP AT lt_prov INTO DATA(ls_provs).
  IF ls_provs-id_proveedor     IS INITIAL OR ls_provs-id_proveedor     EQ '0' OR
     ls_provs-nombre           IS INITIAL OR ls_provs-nombre           EQ '0' OR
     ls_provs-apellido_paterno IS INITIAL OR ls_provs-apellido_paterno EQ '0' OR
     ls_provs-apellido_materno IS INITIAL OR ls_provs-apellido_materno EQ '0' OR
     ls_provs-tipo_persona     IS INITIAL OR ls_provs-tipo_persona     EQ '0' OR
     ls_provs-rfc              IS INITIAL OR ls_provs-rfc              EQ '0' OR
     ls_provs-razon_social     IS INITIAL OR ls_provs-razon_social     EQ '0' OR
*-----------------------------------------------------------------------------------------------------
     ls_provs-regimen_fiscal   IS INITIAL OR ls_provs-regimen_fiscal   EQ '0' OR
     ls_provs-calle            IS INITIAL OR ls_provs-calle            EQ '0' OR
     ls_provs-colonia          IS INITIAL OR ls_provs-colonia          EQ '0' OR
     ls_provs-municipio        IS INITIAL OR ls_provs-municipio        EQ '0' OR
     ls_provs-estado           IS INITIAL OR ls_provs-estado           EQ '0' OR
*-----------------------------------------------------------------------------------------------------
     ls_provs-no_exterior      IS INITIAL OR ls_provs-no_exterior      EQ '0' OR
     ls_provs-cp               IS INITIAL OR ls_provs-cp               EQ '0' OR
     ls_provs-telefono1        IS INITIAL OR ls_provs-telefono1        EQ '0' OR
     ls_provs-email            IS INITIAL OR ls_provs-email            EQ '0'.
    lv_count = lv_count + 1.
  ENDIF.
ENDLOOP.

IF lv_count > 0.
      DELETE FROM zte_proveedores.
      MESSAGE s017(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
    ELSE.
      MESSAGE 'Datos cargados' TYPE 'I'.
 ENDIF.

  PERFORM CONTAINERS_EXCEL USING 'PVEX'.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_EXCEL_PROVEEDORES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_excel_proveedores .

*DATA: T_EXC_PROVT TYPE TABLE OF zte_proveedores,
*      T_EXC_PROVC TYPE TABLE OF ztc_proveedores,
*      S_EXC_PROVT TYPE zte_proveedores,
*      S_EXC_PROVC TYPE ztc_proveedores.

  SELECT ID_PROVEEDOR
         NOMBRE
         APELLIDO_PATERNO
         APELLIDO_MATERNO
         TIPO_PERSONA
         RFC
         RAZON_SOCIAL
         REGIMEN_FISCAL
         CALLE
         COLONIA
         MUNICIPIO
         ESTADO
         NO_EXTERIOR
         NO_INTERIOR
         CP
         TELEFONO1
         TELEFONO2
         EMAIL
     INTO CORRESPONDING FIELDS OF TABLE t_exc_provt
      FROM zte_proveedores.

 IF t_exc_provt IS NOT INITIAL.

   LOOP AT t_exc_provt INTO s_exc_provt.
     CLEAR: s_exc_provc.                                          .
     s_exc_provc-ID_PROVEEDOR     = s_exc_provt-ID_PROVEEDOR      .
     s_exc_provc-NOMBRE           = s_exc_provt-NOMBRE            .
     s_exc_provc-APELLIDO_PATERNO = s_exc_provt-APELLIDO_PATERNO  .
     s_exc_provc-APELLIDO_MATERNO = s_exc_provt-APELLIDO_MATERNO  .
     s_exc_provc-TIPO_PERSONA     = s_exc_provt-TIPO_PERSONA      .
     s_exc_provc-RFC              = s_exc_provt-RFC               .
     s_exc_provc-RAZON_SOCIAL     = s_exc_provt-RAZON_SOCIAL      .
     s_exc_provc-REGIMEN_FISCAL   = s_exc_provt-REGIMEN_FISCAL    .
     s_exc_provc-CALLE            = s_exc_provt-CALLE             .
     s_exc_provc-COLONIA          = s_exc_provt-COLONIA           .
     s_exc_provc-MUNICIPIO        = s_exc_provt-MUNICIPIO         .
     s_exc_provc-ESTADO           = s_exc_provt-ESTADO            .
     s_exc_provc-NO_EXTERIOR      = s_exc_provt-NO_EXTERIOR       .
     s_exc_provc-NO_INTERIOR      = s_exc_provt-NO_INTERIOR       .
     s_exc_provc-CP               = s_exc_provt-CP                .
     s_exc_provc-TELEFONO1        = s_exc_provt-TELEFONO1         .
     s_exc_provc-TELEFONO2        = s_exc_provt-TELEFONO2         .
     s_exc_provc-EMAIL            = s_exc_provt-EMAIL             .
     APPEND s_exc_provc TO t_exc_provc.
   ENDLOOP.

   INSERT ztc_proveedores FROM TABLE t_exc_provc.

   PERFORM LIMPIAR_EXCEL USING 'PVEX'.
   LEAVE TO SCREEN 0.

   ELSE.
     MESSAGE 'No se encontraron datos' TYPE 'I'.
 ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_EXCEL_MAQUILEROS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_excel_maquileros .

SELECT ID_EMPLEADO
       NOMBRE
       APELLIDO_PATERNO
       APELLIDO_MATERNO
       GENERO
       FECHA_NACIMIENTO
       CURP
       RFC
       NO_SEGURO
       ESTADO_CIVIL
       CALLE
       COLONIA
       MUNICIPIO
       ESTADO
       NO_EXTERIOR
       NO_INTERIOR
       CP
       TELEFONO1
       TELEFONO2
       EMAIL
     INTO CORRESPONDING FIELDS OF TABLE t_exc_empt
      FROM zte_empleados.

  IF t_exc_empt IS NOT INITIAL.
    LOOP AT t_exc_empt INTO s_exc_empt.
      CLEAR: s_exc_empc.
      s_exc_empc-ID_EMPLEADO      = s_exc_empt-ID_EMPLEADO      .
      s_exc_empc-NOMBRE           = s_exc_empt-NOMBRE           .
      s_exc_empc-APELLIDO_PATERNO = s_exc_empt-APELLIDO_PATERNO .
      s_exc_empc-APELLIDO_MATERNO = s_exc_empt-APELLIDO_MATERNO .
      s_exc_empc-GENERO           = s_exc_empt-GENERO           .
*-----------------------------------------------------------------------------------
      s_exc_empc-FECHA_NACIMIENTO = s_exc_empt-FECHA_NACIMIENTO .
      s_exc_empc-CURP             = s_exc_empt-CURP             .
      s_exc_empc-RFC              = s_exc_empt-RFC              .
      s_exc_empc-NO_SEGURO        = s_exc_empt-NO_SEGURO        .
      s_exc_empc-ESTADO_CIVIL     = s_exc_empt-ESTADO_CIVIL     .
*-----------------------------------------------------------------------------------
      s_exc_empc-CALLE       = s_exc_empt-CALLE       .
      s_exc_empc-COLONIA     = s_exc_empt-COLONIA     .
      s_exc_empc-MUNICIPIO   = s_exc_empt-MUNICIPIO   .
      s_exc_empc-ESTADO      = s_exc_empt-ESTADO      .
      s_exc_empc-NO_EXTERIOR = s_exc_empt-NO_EXTERIOR .
*-----------------------------------------------------------------------------------
      s_exc_empc-NO_INTERIOR = s_exc_empt-NO_INTERIOR .
      s_exc_empc-CP          = s_exc_empt-CP          .
      s_exc_empc-TELEFONO1   = s_exc_empt-TELEFONO1   .
      s_exc_empc-TELEFONO2   = s_exc_empt-TELEFONO2   .
      s_exc_empc-EMAIL       = s_exc_empt-EMAIL       .
*-----------------------------------------------------------------------------------
      APPEND s_exc_empc TO t_exc_empc.
    ENDLOOP.

    INSERT ztc_empleados FROM TABLE t_exc_empc.
      PERFORM LIMPIAR_EXCEL USING 'EEX'.
      LEAVE TO SCREEN 0.
    ELSE.
     MESSAGE 'No se encontraron datos' TYPE 'I'.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_EXCEL_CLIENTES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_excel_clientes .

    SELECT ID_CLIENTE
           NOMBRE
           APELLIDO_PATERNO
           APELLIDO_MATERNO
           TIPO_PERSONA
           RFC
           RAZON_SOCIAL
           REGIMEN_FISCAL
           CALLE
           COLONIA
           MUNICIPIO
           ESTADO
           NO_EXTERIOR
           NO_INTERIOR
           CP
           TELEFONO1
           TELEFONO2
           EMAIL
        INTO CORRESPONDING FIELDS OF TABLE t_exc_clit
         FROM zte_clientes.

    IF t_exc_clit IS NOT INITIAL.

      LOOP AT t_exc_clit INTO s_exc_clit.
        CLEAR: s_exc_clic.

          s_exc_clic-id_cliente       = s_exc_clit-id_cliente        .
          s_exc_clic-NOMBRE           = s_exc_clit-NOMBRE            .
          s_exc_clic-APELLIDO_PATERNO = s_exc_clit-APELLIDO_PATERNO  .
          s_exc_clic-APELLIDO_MATERNO = s_exc_clit-APELLIDO_MATERNO  .
          s_exc_clic-TIPO_PERSONA     = s_exc_clit-TIPO_PERSONA      .
          s_exc_clic-RFC              = s_exc_clit-RFC               .
          s_exc_clic-RAZON_SOCIAL     = s_exc_clit-RAZON_SOCIAL      .
          s_exc_clic-REGIMEN_FISCAL   = s_exc_clit-REGIMEN_FISCAL    .
          s_exc_clic-CALLE            = s_exc_clit-CALLE             .
          s_exc_clic-COLONIA          = s_exc_clit-COLONIA           .
          s_exc_clic-MUNICIPIO        = s_exc_clit-MUNICIPIO         .
          s_exc_clic-ESTADO           = s_exc_clit-ESTADO            .
          s_exc_clic-NO_EXTERIOR      = s_exc_clit-NO_EXTERIOR       .
          s_exc_clic-NO_INTERIOR      = s_exc_clit-NO_INTERIOR       .
          s_exc_clic-CP               = s_exc_clit-CP                .
          s_exc_clic-TELEFONO1        = s_exc_clit-TELEFONO1         .
          s_exc_clic-TELEFONO2        = s_exc_clit-TELEFONO2         .
          s_exc_clic-EMAIL            = s_exc_clit-EMAIL             .

        APPEND s_exc_clic TO t_exc_clic.
      ENDLOOP.

      INSERT ztc_clientes FROM TABLE t_exc_clic.

      PERFORM LIMPIAR_EXCEL USING 'CEX'.
      LEAVE TO SCREEN 0.

      ELSE.
        MESSAGE 'No se encontraron datos' TYPE 'I'.

    ENDIF.

ENDFORM.
