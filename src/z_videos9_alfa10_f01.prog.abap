*----------------------------------------------------------------------*
***INCLUDE Z_VIDEOS9_ALFA10_F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form inicializar_variables
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM inicializar_variables .
  c_tik_r = TEXT-c01. "'Ticket restaurant'.
  c_seg_m = TEXT-c02. "'Seguro medico'.
  c_frm_p = TEXT-c03. "'Formacion profecional'.

  p_fechaa = sy-datum.

ENDFORM.

FORM obtener_datos TABLES gt_empleados STRUCTURE zemp_alfa10.

  IF p_read EQ abap_true OR
      p_update EQ abap_true OR
      p_delete EQ abap_true.

    SELECT SINGLE * FROM zemp_alfa10
            INTO gwa_empleado
            WHERE id EQ p_dni.
  ENDIF.

  SELECT * FROM zemp_alfa10
     INTO TABLE gt_empleados
    WHERE id NE space.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form crear_empleado
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GWA_EMPLEADO
*&---------------------------------------------------------------------*
FORM crear_empleado  USING VALUE(p_empleado) TYPE zemp_alfa10.

  p_empleado-id = p_dni.
  p_empleado-ape1 = p_ape1.
  p_empleado-ape2 = p_ape2.
  p_empleado-nombre = p_nombre.
  p_empleado-email = p_email.
  p_empleado-fechan = p_fechan.
  p_empleado-fechaa = p_fechaa.

  INSERT zemp_alfa10 FROM p_empleado.

  IF sy-subrc EQ 0.

    MESSAGE i002(zalfa10).

  ELSE.
    MESSAGE i003(zalfa10).

  ENDIF.
ENDFORM.      " Crear empleado
*&---------------------------------------------------------------------*
*& Form visualizar_empleados
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_EMPLEADOS
*&---------------------------------------------------------------------*
FORM visualizar_empleados  TABLES  pt_empleados STRUCTURE zemp_alfa10
                           CHANGING pv_flag   TYPE c.

  DATA lwa_empleado TYPE zemp_alfa10.
  IF sy-subrc EQ 0.
    LOOP AT pt_empleados INTO lwa_empleado.
      WRITE: / 'No. ID = ', lwa_empleado-id,
             / 'Email = ', lwa_empleado-email,
             / 'Primer Apellido = ', lwa_empleado-ape1,
             / 'Segundo Apellido = ', lwa_empleado-ape2,
             / 'Nombre = ', lwa_empleado-nombre,
             / 'Fecha nacimiento = ', lwa_empleado-fechan,
             / 'Fecha alta = ', lwa_empleado-fechaa.
             skip.
    ENDLOOP.
  ELSE.
    MESSAGE i004(zalfa10).
  ENDIF.

ENDFORM.      " Visualizar Empleado
