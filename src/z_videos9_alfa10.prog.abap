*&---------------------------------------------------------------------*
*& Report Z_VIDEOS9_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_videos9_alfa10.

INCLUDE z_videos9_alfa10_top.

INCLUDE z_videos9_alfa10_sel.

INCLUDE z_videos9_alfa10_f01.

INITIALIZATION.
  PERFORM inicializar_variables.

AT SELECTION-SCREEN ON p_ape1.

*  IF p_ape1 IS INITIAL.
*    MESSAGE e001(zalfa10).
*  ENDIF.

  IF p_ape1 CA '0123456789'.
    MESSAGE e000(zalfa10).
  ENDIF.

AT SELECTION-SCREEN ON p_ape2.

  IF p_ape2 CA '0123456789'.
    MESSAGE e000(zalfa10).
  ENDIF.

AT SELECTION-SCREEN ON p_nombre.

  IF p_nombre CA '0123456789'.
    MESSAGE e000(zalfa10).
  ENDIF.

START-OF-SELECTION.

*  WRITE 'EJECUCION DE UNA CADENA DE CARACTERES'.

  PERFORM obtener_datos TABLES gt_empleados.


  CASE abap_true.

    WHEN p_create.

      PERFORM crear_empleado USING gwa_empleado.

    WHEN p_read.

      PERFORM visualizar_empleados TABLES gt_empleados
                                   CHANGING pv_flag.



    WHEN p_update.

*      UPDATE zemp_alfa10 SET nombre = p_nombre
*        WHERE id EQ p_dni.
*
*      IF sy-subrc EQ 0.
*        MESSAGE i005(zalfa10).
*      ELSE.
*        MESSAGE i006(zalfa10).
*      ENDIF.

      IF sy-subrc EQ 0.

        gwa_empleado-nombre = p_nombre.
        gwa_empleado-fechaa = p_fechaa.

        IF sy-subrc EQ 0.
          MESSAGE i005(zalfa10).
        ELSE.
          MESSAGE i006(zalfa10).
        ENDIF.

      ELSE.
        MESSAGE i004(zalfa10).
      ENDIF.
    WHEN p_delete.
      IF sy-subrc EQ 0.

        DELETE zemp_alfa10 FROM gwa_empleado.

        IF sy-subrc EQ 0.

          MESSAGE i007(zalfa10).

        ELSE.
          MESSAGE i008(zalfa10).
        ENDIF.

      ELSE.
        MESSAGE i004(zalfa10).
      ENDIF.

    WHEN p_modify.


      gwa_empleado-id = p_dni.
      gwa_empleado-ape1 = p_ape1.
      gwa_empleado-ape2 = p_ape2.
      gwa_empleado-nombre = p_nombre.
      gwa_empleado-email = p_email.
      gwa_empleado-fechan = p_fechan.
      gwa_empleado-fechaa = p_fechaa.

      MODIFY zemp_alfa10 FROM gwa_empleado.

      IF sy-subrc EQ 0.

        MESSAGE i009(zalfa10).

      ENDIF.
    WHEN OTHERS.

  ENDCASE.
