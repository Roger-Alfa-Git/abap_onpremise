*&---------------------------------------------------------------------*
*& Include          ZGI_COVATEX_PBO
*&---------------------------------------------------------------------*

MODULE status_4000 OUTPUT.

  SET PF-STATUS 'STATUS_4000'.
  SET TITLEBAR 'TITLE_4000'.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4000 OUTPUT.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4001 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4001 OUTPUT.
  SET PF-STATUS 'STATUS_4001'.
  SET TITLEBAR 'TITLE_4001'.
ENDMODULE.

MODULE init_4001 OUTPUT.

  PERFORM init_4001.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4002 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4002 OUTPUT.
  SET PF-STATUS 'STATUS_4002'.
  SET TITLEBAR 'TITLE_4002'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4003 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4003 OUTPUT.
  SET PF-STATUS 'STATUS_4003'.
  SET TITLEBAR 'TITLE_4003'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4004 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4004 OUTPUT.
  SET PF-STATUS 'STATUS_4004'.
  SET TITLEBAR 'TITLE_4004'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4005 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4005 OUTPUT.
  SET PF-STATUS 'STATUS_4005'.
  SET TITLEBAR 'TITLE_4005'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4006 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4006 OUTPUT.
  SET PF-STATUS 'STATUS_4006'.
  SET TITLEBAR 'TITLE_4006'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4011 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4011 OUTPUT.
  SET PF-STATUS 'STATUS_4011'.
  SET TITLEBAR 'TITLE_4011'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4012 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4012 OUTPUT.
  SET PF-STATUS 'STATUS_4012'.
  SET TITLEBAR 'TITLE_4012'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4013 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4013 OUTPUT.
  SET PF-STATUS 'STATUS_4013'.
  SET TITLEBAR 'TITLE_4013'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4014 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4014 OUTPUT.
  SET PF-STATUS 'STATUS_4014'.
  SET TITLEBAR 'TITLE_4014'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4015 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4015 OUTPUT.
  SET PF-STATUS 'STATUS_4015'.
  SET TITLEBAR 'TITLE_4015'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4016 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4016 OUTPUT.
  SET PF-STATUS 'STATUS_4016'.
  SET TITLEBAR 'TITLE_4016'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4017 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4017 OUTPUT.
  SET PF-STATUS 'STATUS_4017'.
  SET TITLEBAR 'TITLE_4017'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4018 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4018 OUTPUT.
 SET PF-STATUS 'STATUS_4018'.
 SET TITLEBAR 'TITLE_4018'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module TC_MOVIMIENTOS_SET OUTPUT tabstrip
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE tc_movimientos_set OUTPUT.

  tc_movimientos-activetab = g_movimientos-pressed_tab.
  CASE g_movimientos-pressed_tab.
    WHEN c_movimientos-tab1.
      g_movimientos-subscreen = '4007'.
    WHEN c_movimientos-tab2.
      g_movimientos-subscreen = '4009'.
    WHEN c_movimientos-tab3.
      g_movimientos-subscreen = '4008'.
    WHEN c_movimientos-tab4.
      g_movimientos-subscreen = '4010'.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4019 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4019 OUTPUT.
  SET PF-STATUS 'STATUS_4019'.
  SET TITLEBAR 'TITLE_4019'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4020 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4020 OUTPUT.
  SET PF-STATUS 'STATUS_4020'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4021 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4021 OUTPUT.
  SET PF-STATUS 'STATUS_4021'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4022 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4022 OUTPUT.
  SET PF-STATUS 'STATUS_4022'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4023 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4023 OUTPUT.
  SET PF-STATUS 'STATUS_4023'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4024 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4024 OUTPUT.
  SET PF-STATUS 'STATUS_4024'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4025 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4025 OUTPUT.
  SET PF-STATUS 'STATUS_2025'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4026 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4026 OUTPUT.
  SET PF-STATUS 'STATUS_4026'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4027 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4027 OUTPUT.
  SET PF-STATUS 'STATUS_4027'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4028 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4028 OUTPUT.
  SET PF-STATUS 'STATUS_4028'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4029 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4029 OUTPUT.
  SET PF-STATUS 'STATUS_4029'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4030 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4030 OUTPUT.
 SET PF-STATUS 'STATUS_4030'.
 SET TITLEBAR 'TITLE_4030'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4031 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4031 OUTPUT.
 SET PF-STATUS 'STATUS_4031'.
 SET TITLEBAR 'TITLE_4031'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4032 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4032 OUTPUT.
 SET PF-STATUS 'STATUS_4032'.
 SET TITLEBAR 'TITLE_4032'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4033 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4033 OUTPUT.
 SET PF-STATUS 'STATUS_4033'.
 SET TITLEBAR 'TITL_4033'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_4034 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4034 OUTPUT.
 SET PF-STATUS 'STATUS_4034'.
 SET TITLEBAR 'TITLE_4034'.
ENDMODULE.


*-----Apartir de aqui declaramos modulos INIT--------
*-----para manejar los performs de la funcionalidad de----
*-----los catalogos---------------------------------------


*&---------------------------------------------------------------------*
*& Module INIT_4002 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4002 OUTPUT.

  PERFORM init_4002. "4002 corresponde a la tabla productos

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4004 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4004 OUTPUT.

  PERFORM init_4004.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4005 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4005 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4005.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4006 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4006 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4006.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module LOAD_PIC OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE load_pic OUTPUT.

  IF contenedor IS INITIAL.
    CREATE OBJECT contenedor
      EXPORTING
        container_name = 'CC_IMAGEN'.
    CREATE OBJECT picture_control
      EXPORTING
        parent = contenedor.
    CALL FUNCTION 'SAPSCRIPT_GET_GRAPHIC_BDS'
      EXPORTING
        i_object       = 'GRAPHICS'
        i_name         = 'IMAGEN2' " Nombre con la que ha guardado la imagen
        i_id           = 'BMAP'
        i_btype        = 'BCOL'
      IMPORTING
        e_bytecount    = l_bytecount
      TABLES
        content        = l_content
      EXCEPTIONS
        not_found      = 1
        bds_get_failed = 2
        bds_no_content = 3
        OTHERS         = 4.
    CALL FUNCTION 'SAPSCRIPT_CONVERT_BITMAP'
      EXPORTING
        old_format               = 'BDS'
        new_format               = 'BMP'
        bitmap_file_bytecount_in = l_bytecount
      TABLES
        bds_bitmap_file          = l_content
        bitmap_file              = graphic_table
      EXCEPTIONS
        OTHERS                   = 1.
    CALL FUNCTION 'DP_CREATE_URL'
      EXPORTING
        type    = 'IMAGE'
        subtype = 'BMP'
      TABLES
        data    = graphic_table
      CHANGING
        url     = url.
    CALL METHOD picture_control->load_picture_from_url
      EXPORTING
        url = url.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4007 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4007 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4007.

ENDMODULE.


*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*--------------Primer Insert de datos----------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module INIT_4019 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4019 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

   PERFORM init_4019.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4026 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4026 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  PERFORM init_4026.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4008 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4008 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4008.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4009 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4009 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4009.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4010 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4010 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4010.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4015 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4015 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4015.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4030 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4030 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4030.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4031 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4031 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4031.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4016 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4016 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4016.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4032 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4032 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4032.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4033 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4033 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4033.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4017 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4017 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM init_4017.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4018 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4018 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM init_4018.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4034 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4034 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4034.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4011 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4011 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4011.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4012 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4012 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4012.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CAMPOS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE campos OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  LOOP AT SCREEN INTO screen_wa.
    IF screen_wa-name = 'BTN_MOD'.
       screen_wa-invisible = 1.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_MATERIALES-DESCRIPCION'.
      screen_wa-input = 0.
      MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_MATERIALES-COLOR'.
      screen_wa-input = 0.
      MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_MATERIALES-ROLLOS'.
      screen_wa-input = 0.
      MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_MATERIALES-ROLLOS_INCOMPLETOS'.
      screen_wa-input = 0.
      MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_MATERIALES-PESO'.
      screen_wa-input = 0.
      MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.
  CHECK OK_CODE_4034 IS NOT INITIAL.

  CASE OK_CODE_4034.
    WHEN 'BTN_EDIT'.
      CLEAR: OK_CODE_4034.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_MATERIALES-DESCRIPCION'.
          screen_wa-required = 1.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-COLOR'.
          screen_wa-required = 1.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-ROLLOS'.
          screen_wa-required = 1.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-ROLLOS_INCOMPLETOS'.
          screen_wa-required = 1.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_MATERIALES-PESO'.
          screen_wa-required = 1.
          screen_wa-input = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_EDITAR'.
          screen_wa-invisible = 1.
          MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_MOD'.
          screen_wa-invisible = 0.
          MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.
    WHEN ''.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CAMPOS_PROV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE campos_prov OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  LOOP AT SCREEN INTO screen_wa.
    IF screen_wa-name = 'BTN_MOD'.
       screen_wa-invisible = 1.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-NOMBRE'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-APELLIDO_PATERNO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-APELLIDO_MATERNO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TIPO_PERSONA'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-RFC'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-RAZON_SOCIAL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-REGIMEN_FISCAL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-CALLE'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-COLONIA'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-MUNICIPIO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-ESTADO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-NO_EXTERIOR'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-NO_INTERIOR'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-CP'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TELEFONO1'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TELEFONO2'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-EMAIL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.
  CHECK OK_CODE_4030 IS NOT INITIAL.

  CASE OK_CODE_4030.
    WHEN 'BTN_EDIT'.
      CLEAR: OK_CODE_4030.
        LOOP AT SCREEN INTO screen_wa.
          IF screen_wa-name = 'ZTC_PROVEEDORES-NOMBRE'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-APELLIDO_PATERNO'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-APELLIDO_MATERNO'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TIPO_PERSONA'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-RFC'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-RAZON_SOCIAL'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-REGIMEN_FISCAL'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-CALLE'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-COLONIA'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-MUNICIPIO'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-ESTADO'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-NO_EXTERIOR'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-NO_INTERIOR'.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-CP'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TELEFONO1'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-TELEFONO2'.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'ZTC_PROVEEDORES-EMAIL'.
             screen_wa-required = 1.
             screen_wa-input = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'BTN_EDITAR'.
             screen_wa-invisible = 1.
             MODIFY SCREEN FROM screen_wa.
          ELSEIF screen_wa-name = 'BTN_MOD'.
             screen_wa-invisible = 0.
             MODIFY SCREEN FROM screen_wa.
          ENDIF.
        ENDLOOP.
    WHEN ''.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CAMPOS_PRO OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE campos_pro OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  LOOP AT SCREEN INTO screen_wa.
    IF screen_wa-name = 'BTN_MOD'.
       screen_wa-invisible = 1.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-DESCRIPCION'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-COLOR'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-TALLA'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-EXISTENCIA'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-PRECIO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.
  CHECK OK_CODE_4031 IS NOT INITIAL.
  CASE OK_CODE_4031.
    WHEN 'BTN_EDIT'.
      CLEAR: OK_CODE_4031.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_PRODUCTOS-DESCRIPCION'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-COLOR'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-TALLA'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-EXISTENCIA'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_PRODUCTOS-PRECIO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_EDITAR'.
           screen_wa-invisible = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_MOD'.
           screen_wa-invisible = 0.
           MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.
    WHEN ''.
    WHEN OTHERS.
  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CAMPOS_MAQUILERO OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE campos_maquilero OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  LOOP AT SCREEN INTO screen_wa.
    IF screen_wa-name = 'BTN_MOD'.
       screen_wa-invisible = 1.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NOMBRE'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-APELLIDO_PATERNO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-APELLIDO_MATERNO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-GENERO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-FECHA_NACIMIENTO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CURP'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-RFC'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_SEGURO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-ESTADO_CIVIL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CALLE'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-COLONIA'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-MUNICIPIO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-ESTADO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_EXTERIOR'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_INTERIOR'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CP'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-TELEFONO1'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-TELEFONO2'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-EMAIL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.

  CHECK OK_CODE_4032 IS NOT INITIAL.
  CASE OK_CODE_4032.
    WHEN 'BTN_EDIT'.
      CLEAR: OK_CODE_4032.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_EMPLEADOS-NOMBRE'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-APELLIDO_PATERNO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-APELLIDO_MATERNO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-GENERO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-FECHA_NACIMIENTO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CURP'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-RFC'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_SEGURO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-ESTADO_CIVIL'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CALLE'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-COLONIA'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-MUNICIPIO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-ESTADO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_EXTERIOR'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-NO_INTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-CP'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-TELEFONO1'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-TELEFONO2'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_EMPLEADOS-EMAIL'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_EDITAR'.
           screen_wa-invisible = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_MOD'.
           screen_wa-invisible = 0.
           MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.
    WHEN ''.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CAMPOS_CLIENTE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE campos_cliente OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  LOOP AT SCREEN INTO screen_wa.
    IF screen_wa-name = 'BTN_MOD'.
       screen_wa-invisible = 1.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-NOMBRE'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-APELLIDO_PATERNO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-APELLIDO_MATERNO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-TIPO_PERSONA'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-RFC'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-RAZON_SOCIAL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-REGIMEN_FISCAL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-CALLE'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-COLONIA'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-MUNICIPIO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-ESTADO'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-NO_EXTERIOR'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-NO_INTERIOR'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-CP'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-TELEFONO1'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-TELEFONO2'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'ZTC_CLIENTES-EMAIL'.
       screen_wa-input = 0.
       MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.
  CHECK OK_CODE_4033 IS NOT INITIAL.
  CASE OK_CODE_4033.
    WHEN 'BTN_EDIT'.
      CLEAR: OK_CODE_4033.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-name = 'ZTC_CLIENTES-NOMBRE'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-APELLIDO_PATERNO'.
           screen_wa-required = 1.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-APELLIDO_MATERNO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-TIPO_PERSONA'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-RFC'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-RAZON_SOCIAL'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-REGIMEN_FISCAL'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-CALLE'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-COLONIA'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-MUNICIPIO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-ESTADO'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-NO_EXTERIOR'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-NO_INTERIOR'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-CP'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-TELEFONO1'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-TELEFONO2'.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'ZTC_CLIENTES-EMAIL'.
           screen_wa-required = 1.
           screen_wa-input = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_EDITAR'.
           screen_wa-invisible = 1.
           MODIFY SCREEN FROM screen_wa.
        ELSEIF screen_wa-name = 'BTN_MOD'.
           screen_wa-invisible = 0.
           MODIFY SCREEN FROM screen_wa.
        ENDIF.
      ENDLOOP.
    ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4013 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4013 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4013.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4025 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4025 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4025.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4014 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4014 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4014.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4027 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4027 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4027.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4028 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4028 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4028.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4029 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4029 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4029.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_40122 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_40122 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_40122.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4020 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4020 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4020.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4021 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4021 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4021.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_40212 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_40212 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_40212.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4023 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4023 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_2023.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_4022 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_4022 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
  PERFORM INIT_4022.
ENDMODULE.
