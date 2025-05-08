*&---------------------------------------------------------------------*
*& Include          ZGI_COVATEX_CL
*&---------------------------------------------------------------------*
CLASS LCL_EVENT_RECEIVER DEFINITION.

  PUBLIC SECTION.
    "HOTSPORT_CLICK PARA PROVEEDORES"
    METHODS HANDLE_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK
                                 OF CL_GUI_ALV_GRID
                                 IMPORTING e_column_id
                                           e_row_id
                                           es_row_no.
ENDCLASS.

CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK.

    CASE e_column_id.
      WHEN 'ID_PROVEEDOR'.
        READ TABLE GT_PROV2 INTO GS_PROVEEDOR_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4030
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 120 22.
      WHEN ''.
      WHEN OTHERS.

    ENDCASE.
  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_PRODUCTO DEFINITION.

  PUBLIC SECTION.


    METHODS HANDLE_HOTSPOT_CLICK_PRODUCTO FOR EVENT HOTSPOT_CLICK
                                          OF CL_GUI_ALV_GRID
                                          IMPORTING e_column_id
                                                    e_row_id
                                                    es_row_no.

ENDCLASS.

CLASS LCL_EVENT_PRODUCTO IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_PRODUCTO.

    CASE e_column_id.
      WHEN 'ID_PRODUCTO'.
        READ TABLE GT_PRO INTO GS_PRODUCTO_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4031
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 67 19.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_MAQUILERO DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_MAQUILERO FOR EVENT HOTSPOT_CLICK
                                           OF CL_GUI_ALV_GRID
                                           IMPORTING e_column_id
                                                     e_row_id
                                                     es_row_no.

ENDCLASS.

CLASS LCL_EVENT_MAQUILERO IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_MAQUILERO.

    CASE e_column_id.
      WHEN 'ID_EMPLEADO'.
        READ TABLE GT_MAQ INTO GS_MAQUILERO_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4032
        STARTING AT 08 03 "MAKE DYNPRO LIKE WINDOW"
      ENDING AT 120 23.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_CLIENTE DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_CLIENTE   FOR EVENT HOTSPOT_CLICK
                                           OF CL_GUI_ALV_GRID
                                           IMPORTING e_column_id
                                                     e_row_id
                                                     es_row_no.

ENDCLASS.

CLASS LCL_EVENT_CLIENTE IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_CLIENTE.

    CASE e_column_id.
      WHEN 'ID_CLIENTE'.
        READ TABLE GT_CLI INTO GS_CLIENTE_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4033
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 120 22.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_MATERIAL DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_MATERIAL  FOR EVENT HOTSPOT_CLICK
                                           OF CL_GUI_ALV_GRID
                                           IMPORTING e_column_id
                                                     e_row_id
                                                     es_row_no.

ENDCLASS.

CLASS LCL_EVENT_MATERIAL IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_MATERIAL.

    CASE e_column_id.
      WHEN 'ID_MATERIAL'.
        READ TABLE GT_MAT2 INTO GS_MATERIAL_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4034
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 67 19.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
CLASS LCL_EVENT_VIEP DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_EP  FOR EVENT HOTSPOT_CLICK
                                           OF CL_GUI_ALV_GRID
                                           IMPORTING e_column_id
                                                     e_row_id
                                                     es_row_no.

ENDCLASS.
CLASS LCL_EVENT_VIEP IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_EP.

    CASE e_column_id.
      WHEN 'FOLIO_ENT_PRO'.
        READ TABLE GT_EP_MOVIMIENTOS INTO GS_EP_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4021
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 130 32.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_VIEM DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_EM  FOR EVENT HOTSPOT_CLICK
                                           OF CL_GUI_ALV_GRID
                                           IMPORTING e_column_id
                                                     e_row_id
                                                     es_row_no.

ENDCLASS.
CLASS LCL_EVENT_VIEM IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_EM.

    CASE e_column_id.
      WHEN 'FOLIO_ENT_MAT'.
        READ TABLE GT_EM_MOVIMIENTOS INTO GS_EM_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4020
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 130 32.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_VISP DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_SP  FOR EVENT HOTSPOT_CLICK
                                           OF CL_GUI_ALV_GRID
                                           IMPORTING e_column_id
                                                     e_row_id
                                                     es_row_no.

ENDCLASS.
CLASS LCL_EVENT_VISP IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_SP.

    CASE e_column_id.
      WHEN 'FOLIO_SAL_PRO'.
        READ TABLE GT_SP_MOVIMIENTOS INTO GS_SP_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4023
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 130 32.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_VISM DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_SM  FOR EVENT HOTSPOT_CLICK
                                           OF CL_GUI_ALV_GRID
                                           IMPORTING e_column_id
                                                     e_row_id
                                                     es_row_no.

ENDCLASS.
CLASS LCL_EVENT_VISM IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_SM.

    CASE e_column_id.
      WHEN 'FOLIO_SAL_MAT'.
        READ TABLE GT_SM_MOVIMIENTOS INTO GS_SM_SELECCIONADO INDEX e_row_id.
        CALL SCREEN 4022
        STARTING AT 08 05 "MAKE DYNPRO LIKE WINDOW"
        ENDING AT 140 26.
      WHEN ''.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS LCL_EVENT_ENT_MATERIAL DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_ENT_MAT  FOR EVENT HOTSPOT_CLICK
                                               OF CL_GUI_ALV_GRID
                                               IMPORTING e_column_id
                                                         e_row_id
                                                         es_row_no.

  ENDCLASS.

CLASS LCL_EVENT_ENT_MATERIAL IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_ENT_MAT.

    CASE e_column_id.
      WHEN 'ICON'.
        READ TABLE GT_ENT_MT INTO GS_ENT_MT_SELECCIONADO INDEX e_row_id-index.
        fol = e_row_id-index.
*        MESSAGE s011(zgi_cv_ms) WITH fol DISPLAY LIKE 'E'.
        PERFORM ICON_ELI_MAT_ENT.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  ENDCLASS.


  CLASS LCL_EVENT_SAL_MATERIAL DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_SAL_MAT  FOR EVENT HOTSPOT_CLICK
                                               OF CL_GUI_ALV_GRID
                                               IMPORTING e_column_id
                                                         e_row_id
                                                         es_row_no.

  ENDCLASS.

CLASS LCL_EVENT_SAL_MATERIAL IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_SAL_MAT.

    CASE e_column_id.
      WHEN 'ICON'.
*        MESSAGE 'Llego aqui' TYPE 'I'.
        READ TABLE GT_SAL_MT INTO GS_SAL_MT_SELECCIONADO INDEX e_row_id-index.
        fol = e_row_id-index.
*        MESSAGE s011(zgi_cv_ms) WITH fol DISPLAY LIKE 'E'.
        PERFORM ICON_ELI_SAL_ENT.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  ENDCLASS.

  CLASS LCL_EVENT_ENT_PRODUCTO DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_ENT_PROD  FOR EVENT HOTSPOT_CLICK
                                               OF CL_GUI_ALV_GRID
                                               IMPORTING e_column_id
                                                         e_row_id
                                                         es_row_no.

  ENDCLASS.

CLASS LCL_EVENT_ENT_PRODUCTO IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_ENT_PROD.

    CASE e_column_id.
      WHEN 'ICON'.
*        MESSAGE 'Llego aqui' TYPE 'I'.
        READ TABLE gt_ent_pr INTO GS_ENT_PR_SELECCIONADO INDEX e_row_id-index.
        fol = e_row_id-index.
*        MESSAGE s011(zgi_cv_ms) WITH fol DISPLAY LIKE 'E'.
        PERFORM ICON_ELI_ENT_PRO.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  ENDCLASS.


  CLASS LCL_EVENT_DEV_PRODUCTO DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_DEV_PROD  FOR EVENT HOTSPOT_CLICK
                                               OF CL_GUI_ALV_GRID
                                               IMPORTING e_column_id
                                                         e_row_id
                                                         es_row_no.

  ENDCLASS.

CLASS LCL_EVENT_DEV_PRODUCTO IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_DEV_PROD.

    CASE e_column_id.
      WHEN 'ICON'.
*        MESSAGE 'Llego aqui' TYPE 'I'.
        READ TABLE gt_dev_pr INTO gs_dev_pr_seleccionado INDEX e_row_id-index.
        fol = e_row_id-index.
*        MESSAGE s011(zgi_cv_ms) WITH fol DISPLAY LIKE 'E'.
        PERFORM ICON_ELI_DEV_PRO.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  ENDCLASS.

  CLASS LCL_EVENT_SAL_PRODUCTO DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_HOTSPOT_CLICK_SAL_PROD  FOR EVENT HOTSPOT_CLICK
                                               OF CL_GUI_ALV_GRID
                                               IMPORTING e_column_id
                                                         e_row_id
                                                         es_row_no.

  ENDCLASS.

CLASS LCL_EVENT_SAL_PRODUCTO IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK_SAL_PROD.

    CASE e_column_id.
      WHEN 'ICON'.
*        MESSAGE 'Llego aqui' TYPE 'I'.
        READ TABLE gt_sal_pr INTO gs_sal_pr_seleccionado INDEX e_row_id-index.
        fol = e_row_id-index.
**        MESSAGE s011(zgi_cv_ms) WITH fol DISPLAY LIKE 'E'.
        PERFORM ICON_ELI_SAL_PRO.
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  ENDCLASS.
