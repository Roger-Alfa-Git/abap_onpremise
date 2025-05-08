*----------------------------------------------------------------------*
***INCLUDE Z_EJERCICIOS9_ALFA10_F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form do_init
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM do_init .
  c_test = TEXT-c01. "'Test'.

  c_notif = TEXT-c02. "'Notificr Manager'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form check_values
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM check_values .
  IF p_perio LT 1 OR p_perio GT 12.
    MESSAGE e001(z_mensajes_alfa10).
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form execute_task
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM execute_task TABLES gt_ib STRUCTURE zib_alfa10.

  SELECT SINGLE * FROM zib_alfa10
    INTO gwa_ib
    WHERE sociedad EQ p_soc AND ejercicio EQ p_ejer AND per_cont EQ p_perio.


  SELECT * FROM zib_alfa10
    INTO TABLE gt_ib
    WHERE sociedad NE p_soc OR ejercicio NE p_ejer OR per_cont NE p_perio.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form update_record
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM update_record TABLES gt_ib STRUCTURE zib_alfa10.

  IF sy-subrc EQ 0.

    IF abap_true EQ p_acre.
      gwa_ib-tipo_ejec = 'A'.
    ELSEIF abap_true EQ p_deud.
      gwa_ib-tipo_ejec = 'D'.
    ENDIF.

    UPDATE zib_alfa10 FROM gwa_ib.

    IF sy-subrc EQ 0.
      MESSAGE i012(zalfa10).
    ELSE.
      MESSAGE i013(zalfa10).
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form delete_record
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_record TABLES gt_ib STRUCTURE zib_alfa10.

  IF sy-subrc EQ 0.
    DELETE zib_alfa10 FROM gwa_ib.

    IF sy-subrc EQ 0.
      MESSAGE i014(zalfa10).
    ELSE.
      MESSAGE i015(zalfa10).
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_record
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_record USING gwa_inform_banco TYPE zib_alfa10.

  gwa_inform_banco-ejercicio = p_ejer.
  gwa_inform_banco-sociedad  = p_soc.
  gwa_inform_banco-per_cont  = p_perio.

  IF abap_true EQ p_acre.
    gwa_inform_banco-tipo_ejec = 'A'.
  ELSEIF abap_true EQ p_deud.
    gwa_inform_banco-tipo_ejec = 'D'.
  ENDIF.

  gwa_inform_banco-usuario_res = p_usario.
  gwa_inform_banco-fecha_eje  = sy-datum.

  INSERT zib_alfa10 FROM gwa_inform_banco.

  IF sy-subrc EQ 0.
    MESSAGE i010(zalfa10).

  ELSE.
    MESSAGE i011(zalfa10).

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form read_record
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM read_record USING gwa_inform_banco TYPE zib_alfa10.
  IF sy-subrc EQ 0.

    WRITE: / 'Sociedad: ', gwa_ib-sociedad,
           / 'Ejercicio: ', gwa_ib-ejercicio,
           / 'Periodo Contable:', gwa_ib-per_cont,
           / 'Usuario: ', gwa_ib-usuario_res,
           / 'Fecha de Registro: ', gwa_ib-fecha_eje.

    IF gwa_ib-tipo_ejec EQ 'A'.
      WRITE: / 'Tipo de Ejecutivo: Acreedores'.
    ELSEIF gwa_ib-tipo_ejec EQ 'D'.
      WRITE: / 'Tipo de Ejecutivo: Deudor'.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form modify_record
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modify_record USING gwa_inform_banco TYPE zib_alfa10.

  gwa_ib-ejercicio = p_ejer.
  gwa_ib-sociedad  = p_soc.
  gwa_ib-per_cont  = p_perio.

  IF abap_true EQ p_acre.
    gwa_ib-tipo_ejec = 'A'.
  ELSEIF abap_true EQ p_deud.
    gwa_ib-tipo_ejec = 'D'.
  ENDIF.

  gwa_ib-usuario_res = p_usario.
  gwa_ib-fecha_eje  = sy-datum.

  MODIFY zib_alfa10 FROM gwa_ib.

  IF sy-subrc EQ 0.
    MESSAGE i016(zalfa10).
  ELSE.
    MESSAGE i017(zalfa10).
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form list_all_records
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> DATE_FROM
*&      --> DATE_TO
*&---------------------------------------------------------------------*
FORM list_all_records USING p_date_from TYPE sydatum p_date_to TYPE sydatum  gt_ib TYPE table.

  DATA lwa_ib TYPE zib_alfa10.

  IF sy-subrc EQ 0.
    LOOP AT gt_ib INTO lwa_ib.

      IF p_date_from GT lwa_ib-fecha_eje OR p_date_to LE lwa_ib-fecha_eje.
        WRITE: / 'Sociedad: ', lwa_ib-sociedad,
               / 'Ejercicio: ', lwa_ib-ejercicio,
               / 'Periodo Contable:', lwa_ib-per_cont,
               / 'Usuario: ', lwa_ib-usuario_res,
               / 'Fecha de Registro: ', lwa_ib-fecha_eje.

        IF lwa_ib-tipo_ejec EQ 'A'.
          WRITE: / 'Tipo de Ejecutivo: Acreedores'.
        ELSEIF lwa_ib-tipo_ejec EQ 'D'.
          WRITE: / 'Tipo de Ejecutivo: Deudor'.
        ENDIF.
        SKIP.
      ENDIF.

    ENDLOOP.
  ENDIF.


ENDFORM.
