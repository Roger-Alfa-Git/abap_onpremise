*&---------------------------------------------------------------------*
*& Include          ZGI_COVATEX_PAI
*&---------------------------------------------------------------------*
MODULE USER_COMMAND_4000 INPUT.

  OK_CODE_4000 = SY-UCOMM.

  CASE OK_CODE_4000.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN 'BTN_MAT'.
          PERFORM LIBERAR_CONT_PROMAT.
          CALL SCREEN 4001.
    WHEN 'BTN_PS'.
          PERFORM LIBERAR_CONT_PROMAT.
          CALL SCREEN 4002.
    WHEN 'BTN_MOV'.
          CALL SCREEN 4003.
    WHEN 'BTN_EM'.
          PERFORM LIBERAR_CONT_ENT_SAL.
          CALL SCREEN 4011.
    WHEN 'BTN_EP'.
          CALL SCREEN 4012.
    WHEN 'BTN_SM'.
          CALL SCREEN 4013.
    WHEN 'BTN_SP'.
          CALL SCREEN 4014.
    WHEN 'BTN_PROV'.
          PERFORM LIBERAR_CONT_PROMAT.
          CALL SCREEN 4004.
    WHEN 'BTN_MAQ'.
          PERFORM LIBERAR_CONT_PROMAT.
          CALL SCREEN 4005.
    WHEN 'BTN_CLI'.
          PERFORM LIBERAR_CONT_PROMAT.
          CALL SCREEN 4006.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4001  INPUT
*&---------------------------------------------------------------------*
*       text  EDITAR (BOTONES DE ACCION)
*---------------------------------------------------------- ------------*
MODULE user_command_4001 INPUT.

  ok_code_4001 = SY-UCOMM.

  CASE OK_CODE_4001.
    WHEN 'ADD'.
      "Perform para agregar un registro"
      CALL SCREEN 4018
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 72 18.
    WHEN 'MULTI'.
      "Perform para agregar multiples registros"
      CALL SCREEN 4025
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 92 18.
    WHEN 'RETURN'.
      LEAVE TO SCREEN 4000.
      "Perform para liberar el container"
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4002 INPUT.

  OK_CODE_4002 = SY-UCOMM.

  CASE OK_CODE_4002.
    WHEN 'ADD'.
      "Perform para agregar un registro"
      CALL SCREEN 4019
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 72 18.
    WHEN 'MULTI'.
      "Perform para agregar multiples registros"
      CALL SCREEN 4026
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 92 18.
    WHEN 'RETURN'.
      LEAVE TO SCREEN 4000.
      "Perform para liberar el container"
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4003  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4003 INPUT.

  OK_CODE_4003 = SY-UCOMM.

  CASE OK_CODE_4003.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4004  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4004 INPUT.

  OK_CODE_4004 = SY-UCOMM.
  CASE OK_CODE_4004.
    WHEN 'ADD'.
      "Perform para agregar un registro"
*      CLEAR: ZTC_PROVEEDORES-nombre,
*             ZTC_PROVEEDORES-APELLIDO_PATERNO,
*             ZTC_PROVEEDORES-APELLIDO_MATERNO,
*             ZTC_PROVEEDORES-TIPO_PERSONA,
*             ZTC_PROVEEDORES-RFC,
*             ZTC_PROVEEDORES-RAZON_SOCIAL,
*             ZTC_PROVEEDORES-REGIMEN_FISCAL,
*             ZTC_PROVEEDORES-CALLE,
*             ZTC_PROVEEDORES-COLONIA,
*             ZTC_PROVEEDORES-MUNICIPIO,
*             ZTC_PROVEEDORES-ESTADO,
*             ZTC_PROVEEDORES-NO_EXTERIOR,
*             ZTC_PROVEEDORES-NO_INTERIOR,
*             ZTC_PROVEEDORES-CP,
*             ZTC_PROVEEDORES-TELEFONO1,
*             ZTC_PROVEEDORES-TELEFONO2,
*             ZTC_PROVEEDORES-EMAIL.
      CLEAR: OK_CODE_4004.
      CALL SCREEN 4015
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 120 22.
    WHEN 'MULTI'.
      "Perform para agregar multiples registros"
      CALL SCREEN 4027
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 92 18.
    WHEN 'RETURN'.
      LEAVE TO SCREEN 4000.
      "Perform para liberar el container"
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4005  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4005 INPUT.

  OK_CODE_4005 = SY-UCOMM.

  CASE OK_CODE_4005.
    WHEN 'ADD'.
      "Perform para agregar un registro"
      CALL SCREEN 4016
      STARTING AT 08 03 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 120 23.
    WHEN 'MULTI'.
      "Perform para agregar multiples registros"
      CALL SCREEN 4028
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 92 18.
    WHEN 'RETURN'.
      LEAVE TO SCREEN 4000.
      "Perform para liberar el container"
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4006  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4006 INPUT.

  OK_CODE_4006 = SY-UCOMM.

  CASE OK_CODE_4006.
    WHEN 'ADD'.
      "Perform para agregar un registro"
      CALL SCREEN 4017
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 120 22.
    WHEN 'MULTI'.
      "Perform para agregar multiples registros"
      CALL SCREEN 4029
      STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 92 18.
    WHEN 'RETURN'.
      LEAVE TO SCREEN 4000.
      "Perform para liberar el container"
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4011  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4011 INPUT.

  OK_CODE_4011 = SY-UCOMM.

  CASE OK_CODE_4011.
    WHEN 'RETURN'.
      CLEAR: OK_CODE_4011.
      PERFORM DELET_ALV_ENT_MAT.
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      CLEAR: OK_CODE_4011.
      PERFORM DELET_ALV_ENT_MAT.
      LEAVE PROGRAM.
    WHEN 'BTN_CAN'.
      CLEAR: OK_CODE_4011.
      PERFORM DELET_ALV_ENT_MAT.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4012  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4012 INPUT.

  OK_CODE_4012 = SY-UCOMM.

  CASE OK_CODE_4012.
    WHEN 'RETURN'.
      CLEAR: OK_CODE_4012.
      PERFORM DELETE_ENT_PRO.
      CLEAR: ztt_ent_pro-folio_ent_pro,
             ztt_ent_pro-folio_sal_mat,
             ztt_ent_pro-id_empleado,
             ztt_ent_pro-ALMACENISTA,
             ztt_ent_pro-FECHA_ENTRADA,
             ztt_ent_pro-PESO_TOTAL,
             ztt_ent_pro-merma.
      CLEAR: ZTT_ENT_PRO-ID_PRODUCTO,
             ZTT_ENT_PRO-DESCRIPCION,
             ZTT_ENT_PRO-COLOR,
             ZTT_ENT_PRO-TALLA,
             LV_DESCRIPCION3,
             LV_COLOR3,
             LV_TALLA3.
      CLEAR: ZTT_ENT_PRO-ID_EMPLEADO,
             LV_ID_EMPLEADO,
             LV_NOMBRE2,
             LV_APELLIDO2,
             ZTC_EMPLEADOS-NOMBRE.
      CLEAR: LV_DESCRIPCION22,
             LV_COLOR22,
             ZTT_DEV_PRODUCTO-ID_MATERIAL,
             ZTT_DEV_PRODUCTO-DESCRIPCION,
             ZTT_DEV_PRODUCTO-COLOR.
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      CLEAR: OK_CODE_4012.
      PERFORM DELETE_ENT_PRO.
      CLEAR: ztt_ent_pro-folio_ent_pro,
             ztt_ent_pro-folio_sal_mat,
             ztt_ent_pro-id_empleado,
             ztt_ent_pro-ALMACENISTA,
             ztt_ent_pro-FECHA_ENTRADA,
             ztt_ent_pro-PESO_TOTAL,
             ztt_ent_pro-merma.
      CLEAR: ZTT_ENT_PRO-ID_PRODUCTO,
             ZTT_ENT_PRO-DESCRIPCION,
             ZTT_ENT_PRO-COLOR,
             ZTT_ENT_PRO-TALLA,
             LV_DESCRIPCION3,
             LV_COLOR3,
             LV_TALLA3.
      CLEAR: ZTT_ENT_PRO-ID_EMPLEADO,
             LV_ID_EMPLEADO,
             LV_NOMBRE2,
             LV_APELLIDO2,
             ZTC_EMPLEADOS-NOMBRE.
      CLEAR: LV_DESCRIPCION22,
             LV_COLOR22,
             ZTT_DEV_PRODUCTO-ID_MATERIAL,
             ZTT_DEV_PRODUCTO-DESCRIPCION,
             ZTT_DEV_PRODUCTO-COLOR.
      LEAVE PROGRAM.
    WHEN 'BTN_CAN'.
      CLEAR: OK_CODE_4012.
      PERFORM DELETE_ENT_PRO.
      CLEAR: ztt_ent_pro-folio_ent_pro,
             ztt_ent_pro-folio_sal_mat,
             ztt_ent_pro-id_empleado,
             ztt_ent_pro-ALMACENISTA,
             ztt_ent_pro-FECHA_ENTRADA,
             ztt_ent_pro-PESO_TOTAL,
             ztt_ent_pro-merma.
      CLEAR: ZTT_ENT_PRO-ID_PRODUCTO,
             ZTT_ENT_PRO-DESCRIPCION,
             ZTT_ENT_PRO-COLOR,
             ZTT_ENT_PRO-TALLA,
             LV_DESCRIPCION3,
             LV_COLOR3,
             LV_TALLA3.
      CLEAR: ZTT_ENT_PRO-ID_EMPLEADO,
             LV_ID_EMPLEADO,
             LV_NOMBRE2,
             LV_APELLIDO2,
             ZTC_EMPLEADOS-NOMBRE.
      CLEAR: LV_DESCRIPCION22,
             LV_COLOR22,
             ZTT_DEV_PRODUCTO-ID_MATERIAL,
             ZTT_DEV_PRODUCTO-DESCRIPCION,
             ZTT_DEV_PRODUCTO-COLOR.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4013  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4013 INPUT.

  OK_CODE_4013 = SY-UCOMM.

  CASE OK_CODE_4013.
    WHEN 'RETURN'.
      CLEAR: OK_CODE_4013.
      CLEAR: LV_DESCRIPCION2,
             LV_COLOR2,
             ZTT_SAL_MAT-ID_MATERIAL,
             ZTT_SAL_MAT-DESCRIPCION,
             ZTT_SAL_MAT-COLOR.
      CLEAR: ZTT_SAL_MAT-ID_EMPLEADO,
             ZTC_EMPLEADOS-NOMBRE,
             LV_NOMBRE3,
             LV_APE3.
      PERFORM DELETE_SAL_MAT.
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      CLEAR: OK_CODE_4013.
      CLEAR: LV_DESCRIPCION2,
             LV_COLOR2,
             ZTT_SAL_MAT-ID_MATERIAL,
             ZTT_SAL_MAT-DESCRIPCION,
             ZTT_SAL_MAT-COLOR.
      CLEAR: ZTT_SAL_MAT-ID_EMPLEADO,
             ZTC_EMPLEADOS-NOMBRE,
             LV_NOMBRE3,
             LV_APE3.
      PERFORM DELETE_SAL_MAT.
      LEAVE PROGRAM.
    WHEN 'BTN_CAN'.
      CLEAR: OK_CODE_4013.
      CLEAR: LV_DESCRIPCION2,
             LV_COLOR2,
             ZTT_SAL_MAT-ID_MATERIAL,
             ZTT_SAL_MAT-DESCRIPCION,
             ZTT_SAL_MAT-COLOR.
      CLEAR: ZTT_SAL_MAT-ID_EMPLEADO,
             ZTC_EMPLEADOS-NOMBRE,
             LV_NOMBRE3,
             LV_APE3.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4014  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4014 INPUT.

  OK_CODE_4014 = SY-UCOMM.

  CASE OK_CODE_4014.
    WHEN 'RETURN'.
      CLEAR: OK_CODE_4014.
      CLEAR: ZTT_SAL_PRO-DESCRIPCION,
             ZTT_SAL_PRO-COLOR,
             ZTT_SAL_PRO-TALLA,
             ZTT_SAL_PRO-PRECIO,
             ZTT_SAL_PRO-ID_PRODUCTO,
             LV_DESCRIPCION4,
             LV_COLOR4,
             LV_TALLA4,
             LV_PRECIO4.
      CLEAR: ZTC_CLIENTES-NOMBRE,
             ZTT_SAL_PRO-ID_CLIENTE,
             LV_NOMBRE4,
             LV_APE4.
      PERFORM DELET_SAL_PRO.
            CLEAR: ztt_sal_pro-folio_sal_pro,
                   ztt_sal_pro-id_cliente,
                   ztt_sal_pro-almacenista,
                   ztt_sal_pro-fecha_salida.
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      CLEAR: OK_CODE_4014.
      CLEAR: ZTT_SAL_PRO-DESCRIPCION,
             ZTT_SAL_PRO-COLOR,
             ZTT_SAL_PRO-TALLA,
             ZTT_SAL_PRO-PRECIO,
             ZTT_SAL_PRO-ID_PRODUCTO,
             LV_DESCRIPCION4,
             LV_COLOR4,
             LV_TALLA4,
             LV_PRECIO4.
      CLEAR: ZTC_CLIENTES-NOMBRE,
             ZTT_SAL_PRO-ID_CLIENTE,
             LV_NOMBRE4,
             LV_APE4.
      PERFORM DELET_SAL_PRO.
            CLEAR: ztt_sal_pro-folio_sal_pro,
                   ztt_sal_pro-id_cliente,
                   ztt_sal_pro-almacenista,
                   ztt_sal_pro-fecha_salida.
      LEAVE PROGRAM.
    WHEN 'BTN_CAN'.
      CLEAR: OK_CODE_4014.
      CLEAR: ZTT_SAL_PRO-DESCRIPCION,
             ZTT_SAL_PRO-COLOR,
             ZTT_SAL_PRO-TALLA,
             ZTT_SAL_PRO-PRECIO,
             ZTT_SAL_PRO-ID_PRODUCTO,
             LV_DESCRIPCION4,
             LV_COLOR4,
             LV_TALLA4,
             LV_PRECIO4.
      CLEAR: ZTC_CLIENTES-NOMBRE,
             ZTT_SAL_PRO-ID_CLIENTE,
             LV_NOMBRE4,
             LV_APE4.
      PERFORM DELET_SAL_PRO.
            CLEAR: ztt_sal_pro-folio_sal_pro,
                   ztt_sal_pro-id_cliente,
                   ztt_sal_pro-almacenista,
                   ztt_sal_pro-fecha_salida.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4015  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4015 INPUT.

  OK_CODE_4015 = SY-UCOMM.

  CASE OK_CODE_4015.
*    WHEN 'ENTER'.
*
*      LEAVE TO SCREEN 0.
*
*      CLEAR: OK_CODE_4015.

    WHEN 'CANCEL'.

      CLEAR: OK_CODE_4015.
      CLEAR: ZTC_PROVEEDORES-nombre,
             ZTC_PROVEEDORES-APELLIDO_PATERNO,
             ZTC_PROVEEDORES-APELLIDO_MATERNO,
             ZTC_PROVEEDORES-TIPO_PERSONA,
             ZTC_PROVEEDORES-RFC,
             ZTC_PROVEEDORES-RAZON_SOCIAL,
             ZTC_PROVEEDORES-REGIMEN_FISCAL,
             ZTC_PROVEEDORES-CALLE,
             ZTC_PROVEEDORES-COLONIA,
             ZTC_PROVEEDORES-MUNICIPIO,
             ZTC_PROVEEDORES-ESTADO,
             ZTC_PROVEEDORES-NO_EXTERIOR,
             ZTC_PROVEEDORES-NO_INTERIOR,
             ZTC_PROVEEDORES-CP,
             ZTC_PROVEEDORES-TELEFONO1,
             ZTC_PROVEEDORES-TELEFONO2,
             ZTC_PROVEEDORES-EMAIL.

      LEAVE TO SCREEN 0.

    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4030  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4030 INPUT.

  OK_CODE_4030 = SY-UCOMM.

  CASE OK_CODE_4030.
*    WHEN 'ENTER'.
*
*      CLEAR: OK_CODE_4030.
*
*      LEAVE TO SCREEN 0.
*
    WHEN 'CANCELAR'.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_PROVEEDORES-NOMBRE'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-APELLIDO_PATERNO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-APELLIDO_MATERNO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TIPO_PERSONA'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-RFC'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-RAZON_SOCIAL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-REGIMEN_FISCAL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-CALLE'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-COLONIA'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-MUNICIPIO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-ESTADO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-NO_EXTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-NO_INTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-CP'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TELEFONO1'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TELEFONO2'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-EMAIL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.

      CLEAR: ZTC_PROVEEDORES-nombre,
             ZTC_PROVEEDORES-APELLIDO_PATERNO,
             ZTC_PROVEEDORES-APELLIDO_MATERNO,
             ZTC_PROVEEDORES-TIPO_PERSONA,
             ZTC_PROVEEDORES-RFC,
             ZTC_PROVEEDORES-RAZON_SOCIAL,
             ZTC_PROVEEDORES-REGIMEN_FISCAL,
             ZTC_PROVEEDORES-CALLE,
             ZTC_PROVEEDORES-COLONIA,
             ZTC_PROVEEDORES-MUNICIPIO,
             ZTC_PROVEEDORES-ESTADO,
             ZTC_PROVEEDORES-NO_EXTERIOR,
             ZTC_PROVEEDORES-NO_INTERIOR,
             ZTC_PROVEEDORES-CP,
             ZTC_PROVEEDORES-TELEFONO1,
             ZTC_PROVEEDORES-TELEFONO2,
             ZTC_PROVEEDORES-EMAIL.

      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4031  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4031 INPUT.

  OK_CODE_4031 = SY-UCOMM.

  CASE OK_CODE_4031.
    WHEN 'CANCELAR'.
      LOOP AT SCREEN INTO screen_wa.
         IF screen_wa-name = 'ZTC_PRODUCTOS-DESCRIPCION'.
            screen_wa-input = 1.
            MODIFY SCREEN FROM screen_wa.
         ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-COLOR'.
            screen_wa-input = 1.
            MODIFY SCREEN FROM screen_wa.
         ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-TALLA'.
            screen_wa-input = 1.
            MODIFY SCREEN FROM screen_wa.
         ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-EXISTENCIA'.
            screen_wa-input = 1.
            MODIFY SCREEN FROM screen_wa.
         ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-PRECIO'.
            screen_wa-input = 1.
            MODIFY SCREEN FROM screen_wa.
         ENDIF.
       ENDLOOP.

      CLEAR: ZTC_PRODUCTOS-ID_PRODUCTO,
             ZTC_PRODUCTOS-DESCRIPCION,
             ZTC_PRODUCTOS-COLOR,
             ZTC_PRODUCTOS-TALLA,
             ZTC_PRODUCTOS-EXISTENCIA,
             ZTC_PRODUCTOS-PRECIO.
      CLEAR: OK_CODE_4031.

      LEAVE TO SCREEN 0.

    WHEN OTHERS.
  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4032  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4032 INPUT.

  OK_CODE_4032 = SY-UCOMM.

  CASE OK_CODE_4032.
    WHEN 'CANCELAR'.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_EMPLEADOS-NOMBRE'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-APELLIDO_PATERNO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-APELLIDO_MATERNO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-GENERO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-FECHA_NACIMIENTO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CURP'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-RFC'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_SEGURO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-ESTADO_CIVIL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CALLE'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-COLONIA'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-MUNICIPIO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-ESTADO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_EXTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_INTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CP'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-TELEFONO1'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-TELEFONO2'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-EMAIL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.

      CLEAR: ZTC_EMPLEADOS-id_empleado,
             ZTC_EMPLEADOS-nombre,
             ZTC_EMPLEADOS-apellido_paterno,
             ZTC_EMPLEADOS-apellido_materno,
             ZTC_EMPLEADOS-genero,
             ZTC_EMPLEADOS-fecha_nacimiento,
             ZTC_EMPLEADOS-curp,
             ZTC_EMPLEADOS-rfc,
             ZTC_EMPLEADOS-no_seguro,
             ZTC_EMPLEADOS-estado_civil,
             ZTC_EMPLEADOS-calle,
             ZTC_EMPLEADOS-colonia,
             ZTC_EMPLEADOS-municipio,
             ZTC_EMPLEADOS-estado,
             ZTC_EMPLEADOS-no_exterior,
             ZTC_EMPLEADOS-no_interior,
             ZTC_EMPLEADOS-cp,
             ZTC_EMPLEADOS-telefono1,
             ZTC_EMPLEADOS-telefono2,
             ZTC_EMPLEADOS-email.
      CLEAR: OK_CODE_4032.

      LEAVE TO SCREEN 0.

    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4033  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4033 INPUT.

  OK_CODE_4033 = SY-UCOMM.

  CASE OK_CODE_4033.
    WHEN 'CANCELAR'.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_CLIENTES-NOMBRE'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-APELLIDO_PATERNO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-APELLIDO_MATERNO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-TIPO_PERSONA'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-RFC'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-RAZON_SOCIAL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-REGIMEN_FISCAL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-CALLE'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-COLONIA'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-MUNICIPIO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-ESTADO'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-NO_EXTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-NO_INTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-CP'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-TELEFONO1'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-TELEFONO2'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-EMAIL'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.

      CLEAR: ZTC_CLIENTES-id_cliente,
               ZTC_CLIENTES-nombre,
               ZTC_CLIENTES-apellido_paterno,
               ZTC_CLIENTES-apellido_materno,
               ZTC_CLIENTES-tipo_persona,
               ZTC_CLIENTES-rfc,
               ZTC_CLIENTES-razon_social,
               ZTC_CLIENTES-regimen_fiscal,
               ZTC_CLIENTES-calle,
               ZTC_CLIENTES-colonia,
               ZTC_CLIENTES-municipio,
               ZTC_CLIENTES-estado,
               ZTC_CLIENTES-no_exterior,
               ZTC_CLIENTES-no_interior,
               ZTC_CLIENTES-cp,
               ZTC_CLIENTES-telefono1,
               ZTC_CLIENTES-telefono2,
               ZTC_CLIENTES-email.
      CLEAR: OK_CODE_4033.

      LEAVE TO SCREEN 0.

    WHEN ''.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4034  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4034 INPUT.

  OK_CODE_4034 = SY-UCOMM.

  CASE OK_CODE_4034.
    WHEN 'CANCELAR'.

      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_MATERIALES-DESCRIPCION'.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-COLOR'.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-ROLLOS'.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-ROLLOS_INCOMPLETOS'.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-PESO'.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.

      CLEAR: ZTC_MATERIALES-id_material,
             ZTC_MATERIALES-descripcion,
             ZTC_MATERIALES-color,
             ZTC_MATERIALES-rollos,
             ZTC_MATERIALES-rollos_incompletos,
             ZTC_MATERIALES-peso.
      CLEAR: OK_CODE_4034.

      LEAVE TO SCREEN 0.

    WHEN ''.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4016  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4016 INPUT.

  OK_CODE_4016 = SY-UCOMM.

  CASE OK_CODE_4016.
*    WHEN 'ENTER'.
*      LEAVE TO SCREEN 0.
*
*      CLEAR: OK_CODE_4016.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4016.
    WHEN OTHERS.
  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4016  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4017 INPUT.

  OK_CODE_4017 = SY-UCOMM.

  CASE OK_CODE_4017.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4017.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4017.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4016  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4018 INPUT.

  OK_CODE_4018 = SY-UCOMM.

  CASE OK_CODE_4018.
   WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4018.
    WHEN 'CANCEL'.
      CLEAR:ZTC_MATERIALES-ID_MATERIAL,
                ZTC_MATERIALES-DESCRIPCION,
                ZTC_MATERIALES-COLOR,
                ZTC_MATERIALES-ROLLOS,
                ZTC_MATERIALES-ROLLOS_INCOMPLETOS,
                ZTC_MATERIALES-PESO.
      CLEAR: OK_CODE_4018.

      LEAVE TO SCREEN 0.
  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4019  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4019 INPUT.

  OK_CODE_4019 = SY-UCOMM.

  CASE OK_CODE_4019.
*    WHEN 'ENTER'.
*      LEAVE TO SCREEN 0.
*
*      CLEAR: OK_CODE_4019.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4019.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4020  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4020 INPUT.

  OK_CODE_4020 = SY-UCOMM.

  CASE OK_CODE_4020.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4020.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4020.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4021  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4021 INPUT.

  OK_CODE_4021 = SY-UCOMM.

  CASE OK_CODE_4021.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4021.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4021.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4022  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4022 INPUT.

  OK_CODE_4022 = SY-UCOMM.

  CASE OK_CODE_4022.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4022.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4022.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4023  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4023 INPUT.

  OK_CODE_4023 = SY-UCOMM.

  CASE OK_CODE_4023.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4023.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4023.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4024  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4024 INPUT.

  OK_CODE_4024 = SY-UCOMM.

  CASE OK_CODE_4024.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4024.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4024.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4025  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4025 INPUT.

  OK_CODE_4025 = SY-UCOMM.

  CASE OK_CODE_4025.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4025.
    WHEN 'CANCEL'.
      PERFORM LIMPIAR_EXCEL USING 'MEX'.
      LEAVE TO SCREEN 0.
      CLEAR: OK_CODE_4025.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4026  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4026 INPUT.

  OK_CODE_4026 = SY-UCOMM.

  CASE OK_CODE_4026.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4026.
    WHEN 'CANCEL'.
      PERFORM LIMPIAR_EXCEL USING 'PEX'.
      LEAVE TO SCREEN 0.
      CLEAR: OK_CODE_4026.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4027  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4027 INPUT.

  OK_CODE_4027 = SY-UCOMM.

  CASE OK_CODE_4027.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4027.
    WHEN 'CANCEL'.
      PERFORM LIMPIAR_EXCEL USING 'PVEX'.
      LEAVE TO SCREEN 0.
      CLEAR: OK_CODE_4027.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4028  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4028 INPUT.

  OK_CODE_4028 = SY-UCOMM.

  CASE OK_CODE_4028.
    WHEN 'ENTER'.

      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4028.
    WHEN 'CANCEL'.
      PERFORM LIMPIAR_EXCEL USING 'EEX'.
      LEAVE TO SCREEN 0.
      CLEAR: OK_CODE_4028.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4029  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4029 INPUT.

  OK_CODE_4029 = SY-UCOMM.

  CASE OK_CODE_4029.
    WHEN 'ENTER'.
      LEAVE TO SCREEN 0.

      CLEAR: OK_CODE_4029.
    WHEN 'CANCEL'.
      PERFORM LIMPIAR_EXCEL USING 'CEX'.
      LEAVE TO SCREEN 0.
      CLEAR: OK_CODE_4029.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  TC_MOVIMIENTOS_GET  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE tc_movimientos_get INPUT.

  OK_CODE = SY-UCOMM.

  CASE OK_CODE.
    WHEN C_MOVIMIENTOS-TAB1.
      G_MOVIMIENTOS-PRESSED_TAB = C_MOVIMIENTOS-TAB1.
    WHEN C_MOVIMIENTOS-TAB2.
      G_MOVIMIENTOS-PRESSED_TAB = C_MOVIMIENTOS-TAB2.
    WHEN C_MOVIMIENTOS-TAB3.
      G_MOVIMIENTOS-PRESSED_TAB = C_MOVIMIENTOS-TAB3.
    WHEN C_MOVIMIENTOS-TAB4.
      G_MOVIMIENTOS-PRESSED_TAB = C_MOVIMIENTOS-TAB4.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4007  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4007 INPUT.

  OK_CODE_4007 = SY-UCOMM.

  CASE OK_CODE_4007.
    WHEN 'BTN_BEP'.
      PERFORM CONTAINERS_MOVIMIENTOS USING 'EP'.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4008  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4008 INPUT.

  OK_CODE_4008 = SY-UCOMM.

  CASE OK_CODE_4008.
    WHEN 'BTN_BEM'.
      PERFORM CONTAINERS_MOVIMIENTOS USING 'EM'.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4009  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4009 INPUT.

  OK_CODE_4009 = SY-UCOMM.

  CASE OK_CODE_4009.
    WHEN 'BTN_BSP'.
      PERFORM CONTAINERS_MOVIMIENTOS USING 'SP'.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4010  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4010 INPUT.

  OK_CODE_4010 = SY-UCOMM.

  CASE OK_CODE_4010.
    WHEN 'BTN_BSM'.
      PERFORM CONTAINERS_MOVIMIENTOS USING 'SM'.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_command INPUT.
  PERFORM borrar_campos.
  PERFORM LIMPIAR_MOVIMIENTOS.
  IF sy-ucomm = 'CANCEL' OR sy-ucomm = 'RETURN'.
     CLEAR dyn_mov.
     LEAVE TO SCREEN 0.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  OBTENER_DETALLES  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE obtener_detalles INPUT.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_ENT_MAT-ID_MATERIAL
   IMPORTING
     OUTPUT        = ZTT_ENT_MAT-ID_MATERIAL.

  SELECT SINGLE DESCRIPCION COLOR INTO (LV_DESCRIPCION, LV_COLOR)
    FROM ZTC_MATERIALES WHERE ID_MATERIAL = ZTT_ENT_MAT-ID_MATERIAL.

  ZTT_ENT_MAT-DESCRIPCION = LV_DESCRIPCION.
  ZTT_ENT_MAT-COLOR = LV_COLOR.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  OBTENER_DETALLES2  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE obtener_detalles2 INPUT.

*  CLEAR: ZTC_MATERIALES-DESCRIPCION,
*         ZTC_MATERIALES-COLOR,
*         LV_DESCRIPCION,
*         LV_COLOR.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_SAL_MAT-ID_MATERIAL
   IMPORTING
     OUTPUT        = ZTT_SAL_MAT-ID_MATERIAL.

  SELECT SINGLE DESCRIPCION COLOR INTO (LV_DESCRIPCION2, LV_COLOR2)
    FROM ZTC_MATERIALES WHERE ID_MATERIAL = ZTT_SAL_MAT-ID_MATERIAL.

  ZTT_SAL_MAT-DESCRIPCION = LV_DESCRIPCION2.
  ZTT_SAL_MAT-COLOR = LV_COLOR2.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  OBTENER_DETALLES3  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE obtener_detalles3 INPUT.

*  CLEAR: ZTC_MATERIALES-DESCRIPCION,
*         ZTC_MATERIALES-COLOR,
*         LV_DESCRIPCION,
*         LV_COLOR.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_ENT_PRO-ID_PRODUCTO
   IMPORTING
     OUTPUT        = ZTT_ENT_PRO-ID_PRODUCTO.

  SELECT SINGLE DESCRIPCION COLOR TALLA INTO (LV_DESCRIPCION3, LV_COLOR3, LV_TALLA3)
    FROM ZTC_PRODUCTOS WHERE ID_PRODUCTO = ZTT_ENT_PRO-ID_PRODUCTO.

  ZTT_ENT_PRO-DESCRIPCION = LV_DESCRIPCION3.
  ZTT_ENT_PRO-COLOR = LV_COLOR3.
  ZTT_ENT_PRO-TALLA = LV_TALLA3.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  OBTENER_DETALLES4  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE obtener_detalles4 INPUT.

*  CLEAR: ZTC_MATERIALES-DESCRIPCION,
*         ZTC_MATERIALES-COLOR,
*         LV_DESCRIPCION,
*         LV_COLOR.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_SAL_PRO-ID_PRODUCTO
   IMPORTING
     OUTPUT        = ZTT_SAL_PRO-ID_PRODUCTO.

  SELECT SINGLE DESCRIPCION COLOR TALLA PRECIO INTO (LV_DESCRIPCION4, LV_COLOR4, LV_TALLA4, LV_PRECIO4)
    FROM ZTC_PRODUCTOS WHERE ID_PRODUCTO = ZTT_SAL_PRO-ID_PRODUCTO.

  ZTT_SAL_PRO-DESCRIPCION = LV_DESCRIPCION4.
  ZTT_SAL_PRO-COLOR = LV_COLOR4.
  ZTT_SAL_PRO-TALLA = LV_TALLA4.
  ZTT_SAL_PRO-PRECIO = LV_PRECIO4.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  GETDETAILS  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE getdetails INPUT.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_DEV_PRODUCTO-ID_MATERIAL
   IMPORTING
     OUTPUT        = ZTT_DEV_PRODUCTO-ID_MATERIAL.

  SELECT SINGLE DESCRIPCION COLOR INTO (LV_DESCRIPCION22, LV_COLOR22)
    FROM ZTC_MATERIALES WHERE ID_MATERIAL = ZTT_DEV_PRODUCTO-ID_MATERIAL.

  ZTT_DEV_PRODUCTO-DESCRIPCION = LV_DESCRIPCION22.
  ZTT_DEV_PRODUCTO-COLOR = LV_COLOR22.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SHOWNAME  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE showname INPUT.
*  DATA: NOM TYPE STRING.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_ENT_MAT-ID_PROVEEDOR
   IMPORTING
     OUTPUT        = ZTT_ENT_MAT-ID_PROVEEDOR.

  SELECT SINGLE NOMBRE APELLIDO_PATERNO INTO (LV_NOMBRE, LV_APE)
    FROM ZTC_PROVEEDORES WHERE ID_PROVEEDOR = ZTT_ENT_MAT-ID_PROVEEDOR.

  CONCATENATE LV_NOMBRE LV_APE INTO ZTC_PROVEEDORES-NOMBRE SEPARATED BY SPACE.
  CONDENSE ZTC_PROVEEDORES-NOMBRE.
*  GV_SHOWNAME = NOM.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SHOWNAME2  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE showname2 INPUT.
*  DATA: NOM TYPE STRING.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_ENT_PRO-FOLIO_SAL_MAT
   IMPORTING
     OUTPUT        = ZTT_ENT_PRO-FOLIO_SAL_MAT.


  SELECT SINGLE ID_EMPLEADO INTO (LV_ID_EMPLEADO)
    FROM ZTC_SAL_MATERIAL WHERE FOLIO_SAL_MAT = ZTT_ENT_PRO-FOLIO_SAL_MAT.

    IF SY-SUBRC EQ 0.
      SELECT SINGLE NOMBRE APELLIDO_PATERNO
        INTO (LV_NOMBRE2,LV_APELLIDO2)
        FROM ZTC_EMPLEADOS
        WHERE ID_EMPLEADO EQ LV_ID_EMPLEADO.
    ENDIF.

  ZTT_ENT_PRO-ID_EMPLEADO = LV_ID_EMPLEADO.
  CONCATENATE LV_NOMBRE2 LV_APELLIDO2 INTO ZTC_EMPLEADOS-NOMBRE SEPARATED BY SPACE.
  CONDENSE ZTC_EMPLEADOS-NOMBRE.
*  GV_SHOWNAME = NOM.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SHOWNAME3  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE showname3 INPUT.
*  DATA: NOM TYPE STRING.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_SAL_MAT-ID_EMPLEADO
   IMPORTING
     OUTPUT        = ZTT_SAL_MAT-ID_EMPLEADO.

  SELECT SINGLE NOMBRE APELLIDO_PATERNO INTO (LV_NOMBRE3, LV_APE3)
    FROM ZTC_EMPLEADOS WHERE ID_EMPLEADO = ZTT_SAL_MAT-ID_EMPLEADO.

  CONCATENATE LV_NOMBRE3 LV_APE3 INTO ZTC_EMPLEADOS-NOMBRE SEPARATED BY SPACE.
  CONDENSE ZTC_EMPLEADOS-NOMBRE.
*  GV_SHOWNAME = NOM.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SHOWNAME4  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE showname4 INPUT.
*  DATA: NOM TYPE STRING.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = ZTT_SAL_PRO-ID_CLIENTE
   IMPORTING
     OUTPUT        = ZTT_SAL_PRO-ID_CLIENTE.

  SELECT SINGLE NOMBRE APELLIDO_PATERNO INTO (LV_NOMBRE4, LV_APE4)
    FROM ZTC_CLIENTES WHERE ID_CLIENTE = ZTT_SAL_PRO-ID_CLIENTE.

  CONCATENATE LV_NOMBRE4 LV_APE4 INTO ZTC_CLIENTES-NOMBRE SEPARATED BY SPACE.
  CONDENSE ZTC_CLIENTES-NOMBRE.

ENDMODULE.
