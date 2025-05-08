*&---------------------------------------------------------------------*
*& Include          ZGI_COVATEX_F01
*&---------------------------------------------------------------------*
**&---------------------------------------------------------------------*
**& Form BUSCAR_MATERIAL
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
*FORM buscar_material .
*
*  PERFORM LIBERAR_CONTENEDOR.
*
*IF c_container IS NOT BOUND.
*
*  PERFORM GET_BUS_MATERIALES.
*  PERFORM CREATE_CONTAINER.
*  PERFORM CATALOGO_CAMPOS.
*  PERFORM CREATE_LAYOUT.
*  PERFORM CREATE_ALV.
*  PERFORM DISPLAY_ALV.
*
*  ELSE.
*
*    PERFORM REFRESCAR_ALV.
*
*ENDIF.
*
*ENDFORM.
**&---------------------------------------------------------------------*
**& Form GET_BUS_MATERIALES
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
*FORM get_bus_materiales .
*
*  SELECT * FROM ZTC_MATERIALES
*        INTO CORRESPONDING FIELDS OF TABLE gt_materiales
*    WHERE id_material EQ ztc_materiales-id_material.
*
*ENDFORM.
**&---------------------------------------------------------------------*
**& Form CARGA_DATOS
**&---------------------------------------------------------------------*
**& Funcion que hace la carga de archivos de Excel.
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
*FORM carga_datos .
*
*    masc = |xlsx (*.xlsx)\|*.xlsx|. "Variable para admitir solo archivos de excel
*
*    TRY.
**-------------------Funcion encargada de abrir el explorador de archivos-----------------
*  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
*    EXPORTING
*      static        = 'X'
*      mask          = masc
*    CHANGING
*      file_name     = p_arch "Esta variable obtiene el directorio del archivo de manera interna
*    EXCEPTIONS
*      mask_too_long = 1
*      OTHERS        = 2.
*
**--------Funcion encargada de leer el contenido del excel
*  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
*    EXPORTING
*      filename                = p_arch "Aqui admite el directorio del archivo
*      i_begin_col             = 1 "En que columna del Excel comenzara el recorrido
*      i_begin_row             = 2 "En que fila del Excel comenzara el recorrido
*      i_end_col               = 6 "En que columna del Excel Finalizara el recorrido
*      i_end_row               = 1000 "En que fila del Excel Finalizara el recorrido
*    TABLES
*      intern                  = gt_arch
*    EXCEPTIONS
*      inconsistent_parameters = 1
*      upload_ole              = 2
*      others                  = 3.
*
**---------Aqui se hace un recorrido por cada una-----------
**--------de las celdas del excel-----------------
*  IF NOT gt_arch[] IS INITIAL.
*
*    LOOP AT  gt_arch INTO gwa_arch.
*
*      CASE gwa_arch-col.
*          WHEN 1."Se considera cada celda como posiciones y se mueve tomando los movimientos como case
*            MOVE gwa_arch-value TO gwa_mat-id_material."Le da el valor de la celda a la variable
*          WHEN 2.
*            MOVE gwa_arch-value TO gwa_mat-descripcion.
*          WHEN 3.
*            MOVE gwa_arch-value TO gwa_mat-color.
*          WHEN 4.
*            MOVE gwa_arch-value TO gwa_mat-rollos.
*          WHEN 5.
*            MOVE gwa_arch-value TO gwa_mat-rollos_incompletos.
*          WHEN 6.
*            MOVE gwa_arch-value TO gwa_mat-peso.
*      ENDCASE.
*
*      AT END OF row."Durante el ciclo se lee el dato dentro de la tabla interna
*        APPEND gwa_mat TO gt_mat.
*        INSERT INTO ZTC_MATERIALES VALUES GWA_MAT."Despues de leer el dato, se inserta la fila en la tabla interna.
*        CLEAR gwa_mat."Se limpia la variable para que pueda tener la siguiente entrada
*        ENDAT.
*
*    ENDLOOP.
*
*  ENDIF.
*
*  CATCH cx_root INTO DATA(e_text).
*
*      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
*
*  ENDTRY.
*
*  PERFORM actualizar. "Refresca el contenedor para visualizar los cambios
*
*ENDFORM.
**&---------------------------------------------------------------------*
**& Form VALIDACIONES
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
FORM load_pic_from_db  CHANGING url.

  DATA query_table    LIKE w3query OCCURS 1 WITH HEADER LINE.
  DATA html_table     LIKE w3html OCCURS 1.
  DATA return_code    LIKE w3param-ret_code.
  DATA content_type   LIKE w3param-cont_type.
  DATA content_length LIKE w3param-cont_len.
  DATA pic_data       LIKE w3mime OCCURS 0.
  DATA pic_size       TYPE i.

  REFRESH query_table.
  query_table-name  = '_OBJECT_ID'.
  query_table-value = 'Z_IMAGEN'.   "Nuestra imagen
  APPEND query_table.

  CALL FUNCTION 'WWW_GET_MIME_OBJECT'
    TABLES
      query_string        = query_table
      html                = html_table
      mime                = pic_data
    CHANGING
      return_code         = return_code
      content_type        = content_type
      content_length      = content_length
    EXCEPTIONS
      object_not_found    = 1
      parameter_not_found = 2
      OTHERS              = 3.
  IF sy-subrc = 0.
    pic_size = content_length.
  ENDIF.

  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type     = 'image'
      subtype  = cndp_sap_tab_unknown
      size     = pic_size
      lifetime = cndp_lifetime_transaction
    TABLES
      data     = pic_data
    CHANGING
      url      = url
    EXCEPTIONS
      OTHERS   = 1.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_ent_mat .

   gwa_ent_mat-mandt = SY-UNAME.
   gwa_ent_mat-folio_ent_mat = ZTT_ENT_MAT-FOLIO_ENT_MAT.
   gwa_ent_mat-id_proveedor = ZTT_ENT_MAT-ID_PROVEEDOR.
   gwa_ent_mat-almacenista = ZTT_ENT_MAT-ALMACENISTA.
   gwa_ent_mat-fecha_entrada = ZTT_ENT_MAT-FECHA_ENTRADA.
*-----------------------------------------------
   gwa_ent_mat-id_material = ZTT_ENT_MAT-ID_MATERIAL.
   gwa_ent_mat-descripcion = ZTT_ENT_MAT-DESCRIPCION.
   gwa_ent_mat-color = ZTT_ENT_MAT-COLOR.
   gwa_ent_mat-rollos = ZTT_ENT_MAT-ROLLOS.
   gwa_ent_mat-metros = ZTT_ENT_MAT-METROS.
   gwa_ent_mat-peso = ZTT_ENT_MAT-PESO.
   gwa_ent_mat-icon = '@02@'.

   INSERT INTO ZTT_ENT_MAT VALUES gwa_ent_mat.

   IF sy-subrc EQ 0.
          MESSAGE 'Registro insertado correctamente' TYPE 'I'.

          CLEAR:
*               ZTT_ENT_MAT-folio_ent_mat,
*                ZTT_ENT_MAT-ID_PROVEEDOR,
                ZTT_ENT_MAT-ALMACENISTA,
                ZTT_ENT_MAT-FECHA_ENTRADA,
*--------------------------------------------------------------
                ZTT_ENT_MAT-ID_MATERIAL,
                ZTT_ENT_MAT-DESCRIPCION,
                ZTT_ENT_MAT-COLOR,
                ZTT_ENT_MAT-ROLLOS,
                ZTT_ENT_MAT-METROS,
                ZTT_ENT_MAT-PESO.
          PERFORM CONTAINERS_ENT_SAL USING 'EM'.
          ZTT_ENT_MAT-fecha_entrada = SY-DATUM.
          ZTT_ENT_MAT-ALMACENISTA = SY-UNAME.
        ELSE.
          MESSAGE s014(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*          MESSAGE 'Entrada no agregada.' TYPE 'I'.
        ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form DELET_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delet_alv_ent_mat .

  CLEAR: ZTC_MATERIALES-DESCRIPCION,
             ZTC_MATERIALES-COLOR,
             LV_DESCRIPCION,
             LV_COLOR.
      CLEAR: LV_NOMBRE,
             LV_APE,
             ZTC_PROVEEDORES-NOMBRE,
             ZTT_ENT_MAT-ID_PROVEEDOR.

      DELETE FROM ztt_ent_mat WHERE folio_ent_mat gt 0.
      CLEAR:"ZTT_ENT_MAT-folio_ent_mat,
            "ZTT_ENT_MAT-ID_PROVEEDOR,
            "ZTT_ENT_MAT-ALMACENISTA,
            "ZTT_ENT_MAT-FECHA_ENTRADA,
*--------------------------------------------------------------
            ZTT_ENT_MAT-ID_MATERIAL,
            ZTT_ENT_MAT-DESCRIPCION,
            ZTT_ENT_MAT-COLOR,
            ZTT_ENT_MAT-ROLLOS,
            ZTT_ENT_MAT-METROS,
            ZTT_ENT_MAT-PESO.

      PERFORM CONTAINERS_ENT_SAL USING 'EM'.

ENDFORM.

************************************************************************
************************************************************************
************************************************************************
FORM SET_HANDLERS_ENT_MATERIAL.

    IF go_event_ent_material IS NOT BOUND.

      CREATE OBJECT go_event_ent_material.

      SET HANDLER: go_event_ent_material->handle_hotspot_click_ent_mat FOR GALV_GRID_ENT_SAL.

    ENDIF.

ENDFORM.

FORM SET_HANDLERS_SAL_MATERIAL.

    IF go_event_sal_material IS NOT BOUND.

      CREATE OBJECT go_event_sal_material.

      SET HANDLER: go_event_sal_material->handle_hotspot_click_sal_mat FOR GALV_GRID_ENT_SAL.

    ENDIF.

ENDFORM.

FORM SET_HANDLERS_ENT_PRODUCTOS.

    IF go_event_ent_prod IS NOT BOUND.

      CREATE OBJECT go_event_ent_prod.

      SET HANDLER: go_event_ent_prod->handle_hotspot_click_ent_prod FOR GALV_GRID_ENT_SAL.

    ENDIF.

ENDFORM.

FORM SET_HANDLERS_DEV_PRODUCTOS.

    IF go_event_dev_prod IS NOT BOUND.

      CREATE OBJECT go_event_dev_prod.

      SET HANDLER: go_event_dev_prod->handle_hotspot_click_dev_prod FOR GALV_GRID_ENT_SAL2.

    ENDIF.

ENDFORM.

FORM SET_HANDLERS_SAL_PRODUCTOS.

    IF go_event_sal_prod IS NOT BOUND.

      CREATE OBJECT go_event_sal_prod.

      SET HANDLER: go_event_sal_prod->handle_hotspot_click_sal_prod FOR GALV_GRID_ENT_SAL.

    ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form LIBERAR_CONT_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LIBERAR_CONT_ENT_SAL.

    IF C_CONTAINER_ENT_SAL IS BOUND.

      C_CONTAINER_ENT_SAL->free(
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          others            = 3
      ).
      IF SY-SUBRC <> 0.
       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      CLEAR C_CONTAINER_ENT_SAL.

      IF GALV_GRID_ENT_SAL IS BOUND.

        CLEAR GALV_GRID_ENT_SAL.

      ENDIF.

      IF go_event_ent_material IS BOUND.

        CLEAR go_event_ent_material.

      ENDIF.

      IF go_event_sal_material IS BOUND.

        CLEAR go_event_sal_material.

      ENDIF.

      IF go_event_ent_prod IS BOUND.

        CLEAR go_event_ent_prod.

      ENDIF.

      IF go_event_sal_prod IS BOUND.

        CLEAR go_event_sal_prod.

      ENDIF.


   ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESCAR_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESCAR_ALV_ENT_SAL .

    GALV_GRID_ENT_SAL->refresh_table_display(
*    EXPORTING
*      is_stable      =
*      i_soft_refresh =
    EXCEPTIONS
      finished       = 1
      others         = 2
  ).
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INST_CONT_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INST_CONT_ENT_SAL USING T1.

  IF T1 EQ 'EM'.

     CREATE OBJECT c_container_ent_sal
      EXPORTING
*        parent                      =
        container_name              = 'C_ENTRADA_MATERIAL'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF T1 EQ 'SM'.

    CREATE OBJECT c_container_ent_sal
      EXPORTING
*        parent                      =
        container_name              = 'C_SALIDA_MATERIAL'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF T1 EQ 'EP'.

    CREATE OBJECT c_container_ent_sal
      EXPORTING
*        parent                      =
        container_name              = 'C_ENTRADA_PRODUCTO'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF T1 EQ 'SP'.

    CREATE OBJECT c_container_ent_sal
      EXPORTING
*        parent                      =
        container_name              = 'C_SALIDA_PRODUCTO'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form BUILD_FIELDCAT_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM BUILD_FIELDCAT_ENT_SAL USING T2.

  IF T2 EQ 'EM'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
*        i_buffer_active        =
        i_structure_name       = 'ZTT_ENT_MAT'
*        i_client_never_display = 'X'
*        i_bypassing_buffer     =
*        i_internal_tabname     =
      CHANGING
        ct_fieldcat            = GT_FIELDCAT_ENT_MAT
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        others                 = 3
      .
    IF SY-SUBRC <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ELSE.
      LOOP AT GT_FIELDCAT_ENT_MAT ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname.
          WHEN 'ICON'.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'ID_MATERIAL' OR 'DESCRIPCION' OR 'COLOR' OR 'ROLLOS' OR 'METROS' OR 'PESO' OR 'ICON'.
          WHEN OTHERS.
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF T2 EQ 'SM'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTT_SAL_MAT'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_SAL_MAT
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_SAL_MAT ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname.
          WHEN 'ICON'.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'ESTATUS' OR 'FOLIO_SAL_MAT' OR 'ID_EMPLEADO' OR 'ALMACENISTA' OR 'FECHA_SALIDA' OR 'PESO_TOTAL' OR 'PESO_RESTANTE' .
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF T2 EQ 'EP'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTT_ENT_PRO'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_ENT_PRO
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_ENT_PRO ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname.
          WHEN 'ICON'.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'FOLIO_ENT_PRO' OR 'ID_EMPLEADO' OR 'FOLIO_REFERENCIA' OR 'FECHA_ENTRADA' OR 'ALMACENISTA' OR 'PESO_TOTAL' OR 'MERMA'.
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF T2 EQ 'SP'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTT_SAL_PRO'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_SAL_PRO
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_SAL_PRO ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname.
          WHEN 'ICON'.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'FOLIO_SAL_PRO' OR 'ID_EMPLEADO' OR 'FECHA_SALIDA' OR 'ALMACENISTA'.
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ENDIF.


ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_DATA_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA_ENT_SAL USING T3.

  IF T3 EQ 'EM'.

    SELECT * FROM ZTT_ENT_MAT
      INTO CORRESPONDING FIELDS OF TABLE GT_ENT_MAT.

  ELSEIF T3 EQ 'SM'.

    SELECT * FROM ZTT_SAL_MAT
      INTO CORRESPONDING FIELDS OF TABLE GT_SAL_MAT.

  ELSEIF T3 EQ 'EP'.

    SELECT * FROM ZTT_ENT_PRO
      INTO CORRESPONDING FIELDS OF TABLE GT_ENT_PRO.

  ELSEIF T3 EQ 'SP'.

    SELECT * FROM ZTT_SAL_PRO
      INTO CORRESPONDING FIELDS OF TABLE GT_SAL_PRO.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_EMA.

  CREATE OBJECT galv_grid_ent_sal
    EXPORTING
      i_parent                = C_CONTAINER_ENT_SAL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_SMA.

  CREATE OBJECT galv_grid_ent_sal
    EXPORTING
      i_parent                = C_CONTAINER_ENT_SAL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_EPR.

  CREATE OBJECT galv_grid_ent_sal
    EXPORTING
      i_parent                = C_CONTAINER_ENT_SAL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_SPR.

  CREATE OBJECT galv_grid_ent_sal
    EXPORTING
      i_parent                = C_CONTAINER_ENT_SAL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUILD_LAYOUT_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM BUILD_LAYOUT_ENT_SAL USING T4.

  IF T4 EQ 'EM'.

    GS_LAYOUT_ENT_SAL-zebra = ABAP_TRUE.
    GS_LAYOUT_ENT_SAL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_ENT_SAL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_ENT_MAT ASSIGNING <LS_FIELDCAT_ENT_SAL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_ENT_MAT ASSIGNING <LS_ENT_MAT>.

        LS_STYLE_ENT_SAL-fieldname = <LS_FIELDCAT_ENT_SAL>-fieldname.
        LS_STYLE_ENT_SAL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_ENT_SAL INTO TABLE <LS_ENT_MAT>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF T4 EQ 'SM'.

    GS_LAYOUT_ENT_SAL-zebra = ABAP_TRUE.
    GS_LAYOUT_ENT_SAL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_ENT_SAL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_SAL_MAT ASSIGNING <LS_FIELDCAT_ENT_SAL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_SAL_MAT ASSIGNING <LS_SAL_MAT>.

        LS_STYLE_ENT_SAL-fieldname = <LS_FIELDCAT_ENT_SAL>-fieldname.
        LS_STYLE_ENT_SAL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_ENT_SAL INTO TABLE <LS_SAL_MAT>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF T4 EQ 'EP'.

    GS_LAYOUT_ENT_SAL-zebra = ABAP_TRUE.
    GS_LAYOUT_ENT_SAL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_ENT_SAL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_SAL_MAT ASSIGNING <LS_FIELDCAT_ENT_SAL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_ENT_PRO ASSIGNING <LS_ENT_PRO>.

        LS_STYLE_ENT_SAL-fieldname = <LS_FIELDCAT_ENT_SAL>-fieldname.
        LS_STYLE_ENT_SAL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_ENT_SAL INTO TABLE <LS_ENT_PRO>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF T4 EQ 'SP'.

    GS_LAYOUT_ENT_SAL-zebra = ABAP_TRUE.
    GS_LAYOUT_ENT_SAL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_ENT_SAL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_SAL_MAT ASSIGNING <LS_FIELDCAT_ENT_SAL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_SAL_PRO ASSIGNING <LS_SAL_PRO>.

        LS_STYLE_ENT_SAL-fieldname = <LS_FIELDCAT_ENT_SAL>-fieldname.
        LS_STYLE_ENT_SAL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_ENT_SAL INTO TABLE <LS_SAL_PRO>-field_style.

      ENDLOOP.

    ENDLOOP.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY_ALV_ENT_SAL USING T5.

  IF T5 EQ 'EM'.

     galv_grid_ent_sal->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_ENT_SAL
      CHANGING
        it_outtab                     = GT_ENT_MAT
        it_fieldcatalog               = GT_FIELDCAT_ENT_MAT
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
      ).
      IF SY-SUBRC <> 0.
       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

  ELSEIF T5 EQ 'SM'.

    galv_grid_ent_sal->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_ENT_SAL
      CHANGING
        it_outtab                     = GT_SAL_MAT
        it_fieldcatalog               = GT_FIELDCAT_SAL_MAT
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF T5 EQ 'EP'.

    galv_grid_ent_sal->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_ENT_SAL
      CHANGING
        it_outtab                     = GT_ENT_PRO
        it_fieldcatalog               = GT_FIELDCAT_ENT_PRO
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF T5 EQ 'SP'.

    galv_grid_ent_sal->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_ENT_SAL
      CHANGING
        it_outtab                     = GT_SAL_PRO
        it_fieldcatalog               = GT_FIELDCAT_SAL_PRO
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form TABLA_TEMP_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CONTAINERS_ENT_SAL USING T6.

  PERFORM LIBERAR_CONT_ENT_SAL.

  IF T6 EQ 'EM'.

    IF NOT C_CONTAINER_ENT_SAL IS BOUND.

      PERFORM INST_CONT_ENT_SAL USING 'EM'.
      PERFORM BUILD_FIELDCAT_ENT_SAL USING 'EM'.
      PERFORM GET_DATA_ENT_SAL USING 'EM'.
      PERFORM INSTANCE_ALV_EMA.
      PERFORM BUILD_LAYOUT_ENT_SAL USING 'EM'.
      PERFORM SET_HANDLERS_ENT_MATERIAL.
      PERFORM DISPLAY_ALV_ENT_SAL USING 'EM'.

    ELSE.

      PERFORM REFRESCAR_ALV_ENT_SAL.

    ENDIF.

  ELSEIF T6 EQ 'SM'.

    IF NOT C_CONTAINER_ENT_SAL IS BOUND.

      PERFORM INST_CONT_ENT_SAL USING 'SM'.
      PERFORM BUILD_FIELDCAT_ENT_SAL USING 'SM'.
      PERFORM GET_DATA_ENT_SAL USING 'SM'.
      PERFORM INSTANCE_ALV_SMA.
      PERFORM BUILD_LAYOUT_ENT_SAL USING 'SM'.
      PERFORM SET_HANDLERS_SAL_MATERIAL.
      PERFORM DISPLAY_ALV_ENT_SAL USING 'SM'.

    ELSE.

      PERFORM REFRESCAR_ALV_ENT_SAL.

    ENDIF.

  ELSEIF T6 EQ 'EP'.

    IF NOT C_CONTAINER_ENT_SAL IS BOUND.

      PERFORM INST_CONT_ENT_SAL USING 'EP'.
      PERFORM BUILD_FIELDCAT_ENT_SAL USING 'EP'.
      PERFORM GET_DATA_ENT_SAL USING 'EP'.
      PERFORM INSTANCE_ALV_EPR.
      PERFORM BUILD_LAYOUT_ENT_SAL USING 'EP'.
      PERFORM set_handlers_ent_productos.
      PERFORM DISPLAY_ALV_ENT_SAL USING 'EP'.

    ELSE.

      PERFORM REFRESCAR_ALV_ENT_SAL.

    ENDIF.

  ELSEIF T6 EQ 'SP'.

    IF NOT C_CONTAINER_ENT_SAL IS BOUND.

      PERFORM INST_CONT_ENT_SAL USING 'SP'.
      PERFORM BUILD_FIELDCAT_ENT_SAL USING 'SP'.
      PERFORM GET_DATA_ENT_SAL USING 'SP'.
      PERFORM INSTANCE_ALV_SPR.
      PERFORM BUILD_LAYOUT_ENT_SAL USING 'SP'.
      PERFORM set_handlers_sal_productos.
      PERFORM DISPLAY_ALV_ENT_SAL USING 'SP'.

    ELSE.

      PERFORM REFRESCAR_ALV_ENT_SAL.

    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form LIBERAR_CONT_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LIBERAR_CONT_ENT_SAL2.

    IF C_CONTAINER_ENT_SAL2 IS BOUND.

      C_CONTAINER_ENT_SAL2->free(
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          others            = 3
      ).
      IF SY-SUBRC <> 0.
       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      CLEAR C_CONTAINER_ENT_SAL2.

      IF GALV_GRID_ENT_SAL2 IS BOUND.

        CLEAR GALV_GRID_ENT_SAL2.

      ENDIF.

      IF go_event_dev_prod IS BOUND.

        CLEAR go_event_dev_prod.

      ENDIF.

   ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESCAR_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESCAR_ALV_ENT_SAL2 .

    GALV_GRID_ENT_SAL2->refresh_table_display(
*    EXPORTING
*      is_stable      =
*      i_soft_refresh =
    EXCEPTIONS
      finished       = 1
      others         = 2
  ).
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INST_CONT_ENT_SAL2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM inst_cont_ent_sal2.

    CREATE OBJECT c_container_ent_sal2
      EXPORTING
*        parent                      =
        container_name              = 'C_DEV'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUILD_FIELDCAT_ENT_SAL2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM build_fieldcat_ent_sal2.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTT_DEV_PRODUCTO'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_DEV_PRO
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_DEV_PRO ASSIGNING <LS_FIELDCAT_ENT_SAL2>.
        CASE <LS_FIELDCAT_ENT_SAL2>-fieldname.
          WHEN 'ICON'.
            <LS_FIELDCAT_ENT_SAL2>-hotspot = ABAP_TRUE.
          WHEN 'FOLIO_ENT_PRO'.
            <LS_FIELDCAT_ENT_SAL2>-no_out = ABAP_TRUE.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA_ENT_SAL2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM get_data_ent_sal2.

    SELECT * FROM ZTT_DEV_PRODUCTO
      INTO CORRESPONDING FIELDS OF TABLE GT_DEV_PRO.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_DEV.

  CREATE OBJECT galv_grid_ent_sal2
    EXPORTING
      i_parent                = C_CONTAINER_ENT_SAL2
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUILD_LAYOUT_ENT_SAL2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM build_layout_ent_sal2.

    GS_LAYOUT_ENT_SAL2-zebra = ABAP_TRUE.
    GS_LAYOUT_ENT_SAL2-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_ENT_SAL2-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_DEV_PRO ASSIGNING <LS_FIELDCAT_ENT_SAL2> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_DEV_PRO ASSIGNING <LS_DEV_PRO>.

        LS_STYLE_ENT_SAL2-fieldname = <LS_FIELDCAT_ENT_SAL2>-fieldname.
        LS_STYLE_ENT_SAL2-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_ENT_SAL2 INTO TABLE <LS_DEV_PRO>-field_style.

      ENDLOOP.
    ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV_ENT_SAL2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM display_alv_ent_sal2.

    galv_grid_ent_sal2->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_ENT_SAL2
      CHANGING
        it_outtab                     = GT_DEV_PRO
        it_fieldcatalog               = GT_FIELDCAT_DEV_PRO
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CONTAINERS_ENT_SAL2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM containers_ent_sal2 .

  PERFORM LIBERAR_CONT_ENT_SAL2.

  IF NOT C_CONTAINER_ENT_SAL2 IS BOUND.

      PERFORM INST_CONT_ENT_SAL2.
      PERFORM BUILD_FIELDCAT_ENT_SAL2.
      PERFORM GET_DATA_ENT_SAL2.
      PERFORM INSTANCE_ALV_DEV.
      PERFORM BUILD_LAYOUT_ENT_SAL2.
      PERFORM set_handlers_dev_productos.
      PERFORM DISPLAY_ALV_ENT_SAL2.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4011
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4011 .

DYN_MOV = 'ENT_MAT'.

IF  ZTT_ENT_MAT-FOLIO_ENT_MAT IS INITIAL.

    SELECT MAX( FOLIO_ENT_MAT )
        FROM ZTC_ENT_MATERIAL
        INTO ( gv_max ).
    MOVE gv_max TO res.
    res = res + 1.
    MOVE res TO gv_max.
    ZTT_ENT_MAT-FOLIO_ENT_MAT = gv_max.
    ZTT_ENT_MAT-ALMACENISTA = SY-UNAME.
    ZTT_ENT_MAT-fecha_entrada = SY-DATUM.

ENDIF.

  PERFORM CONTAINERS_ENT_SAL USING 'EM'.

  CHECK ok_code_4011 IS NOT INITIAL.

  CASE ok_code_4011.
    WHEN 'BTN_ADD'.
      CLEAR ok_code_4011.
      PERFORM VALID_INSERTAR_ENT_MAT.
*      PERFORM INSERTAR_ENT_MAT.
    WHEN 'BTN_REM'.
      CLEAR ok_code_4011.
      CLEAR FGL.
      PERFORM VALID_INSERTAR_ALL_ENT_MAT.
*      PERFORM INSERTAR_ALL_ENT_MAT.
      IF FGL EQ abap_false.
        PERFORM delet_alv_ent_mat.
        CLEAR:ZTT_ENT_MAT-folio_ent_mat,
            ZTT_ENT_MAT-ID_PROVEEDOR,
            ztc_proveedores-NOMBRE,
            ZTT_ENT_MAT-ALMACENISTA,
            ZTT_ENT_MAT-FECHA_ENTRADA.
        LEAVE TO SCREEN 0.
      ENDIF.
    WHEN 'BTN_CAN'.
      CLEAR: OK_CODE_4011.
      PERFORM DELET_ALV_ENT_MAT.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_ALL_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_all_ent_mat .

  CLEAR: t_ent_matt,
         t_ent_matC,
         mlt_ent_mat,
         lt_ent_mat,
         lt_materiales,
         ls_ent_mat.

* Paso 1: Leer el primer registro de ZTT_ENT_MAT
SELECT folio_ent_mat id_proveedor fecha_entrada almacenista
  INTO CORRESPONDING FIELDS OF TABLE mlt_ent_mat
  FROM ztt_ent_mat.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

SELECT FOLIO_ENT_MAT
       ID_MATERIAL
       ROLLOS
       METROS
       PESO
  INTO CORRESPONDING FIELDS OF TABLE t_ent_matt
  FROM ztt_ent_mat.

    IF t_ent_matt IS NOT INITIAL.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
      mls_tc_ent_materiales-folio_ent_mat = ztt_ent_mat-folio_ent_mat.
      mls_tc_ent_materiales-id_proveedor  = ztt_ent_mat-id_proveedor.
      mls_tc_ent_materiales-fecha_entrada = ztt_ent_mat-fecha_entrada.
      mls_tc_ent_materiales-almacenista   = ztt_ent_mat-almacenista.
      INSERT ztc_ent_material FROM mls_tc_ent_materiales.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
      LOOP AT t_ent_matt INTO s_ent_matt.
        CLEAR: s_ent_matc.
        s_ent_matc-folio_ent_mat = s_ent_matt-folio_ent_mat.
        s_ent_matc-id_material    = s_ent_matt-id_material.
        s_ent_matc-rollos    = s_ent_matt-rollos.
        s_ent_matc-metros    = s_ent_matt-metros.
        s_ent_matc-peso    = s_ent_matt-peso.
        APPEND s_ent_matc TO t_ent_matc.
      ENDLOOP.

      INSERT ztc_ent_mat_deta FROM TABLE t_ent_matc.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_ent_mat INTO TABLE lt_ent_mat.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_materiales INTO TABLE lt_materiales.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_ent_mat INTO ls_ent_mat.
  CLEAR lv_suma.
  lv_id = ls_ent_mat-id_material.

  " Paso 4: Sumar los valores de CampoTabla1
  LOOP AT lt_ent_mat INTO ls_ent_mat WHERE id_material = lv_id.
    lv_suma = lv_suma + ls_ent_mat-rollos.
  ENDLOOP.

  " Paso 5: Agregar la suma a CampoTabla2 en Tabla2
  LOOP AT lt_materiales INTO ls_materiales WHERE id_material = lv_id.
    ls_materiales-rollos = ls_materiales-rollos + lv_suma.
    APPEND ls_materiales TO lt_result.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
LOOP AT lt_result INTO ls_materiales.
*  MOVE-CORRESPONDING ls_materiales TO ztc_materiales where id_material = ls_materiales-id_material.
  MODIFY ztc_materiales FROM ls_materiales.
ENDLOOP.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_ent_mat INTO TABLE lt_ent_mat.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_materiales INTO TABLE lt_materiales.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_ent_mat INTO ls_ent_mat.
  CLEAR lv_suma.
  lv_id = ls_ent_mat-id_material.

  " Paso 4: Sumar los valores de CampoTabla1
  LOOP AT lt_ent_mat INTO ls_ent_mat WHERE id_material = lv_id.
    lv_suma = lv_suma + ls_ent_mat-peso.
  ENDLOOP.

  " Paso 5: Agregar la suma a CampoTabla2 en Tabla2
  LOOP AT lt_materiales INTO ls_materiales WHERE id_material = lv_id.
    ls_materiales-peso = ls_materiales-peso + lv_suma.
    APPEND ls_materiales TO lt_result.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
LOOP AT lt_result INTO ls_materiales.
*  MOVE-CORRESPONDING ls_materiales TO ztc_materiales where id_material = ls_materiales-id_material.
  MODIFY ztc_materiales FROM ls_materiales.
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
*            MESSAGE 'No se encontraron registros.'TYPE 'I'.
            FGL = abap_true.
            EXIT.
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERTAR_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insertar_ent_mat .

IF ztt_ent_mat-id_proveedor = 0 OR ztt_ent_mat-id_proveedor IS INITIAL.
       tc = 'ID PROVEEDOR'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
ENDIF.

IF ztt_ent_mat-id_material = 0 OR ztt_ent_mat-id_material IS INITIAL.
       tc = 'ID MATERIAL'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
ENDIF.

IF ztt_ent_mat-FECHA_ENTRADA = 0 OR ztt_ent_mat-FECHA_ENTRADA IS INITIAL.
       tc = 'FECHA DE ENTRADA'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
ENDIF.

tc = 'ALMACENISTA'.
l_string = ztt_ent_mat-ALMACENISTA.
IF ztt_ent_mat-ALMACENISTA IS NOT INITIAL.
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

IF ztt_ent_mat-ROLLOS = 0 OR ztt_ent_mat-ROLLOS IS INITIAL.
       tc = 'ROLLOS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
ENDIF.

IF ztt_ent_mat-METROS = 0 OR ztt_ent_mat-METROS IS INITIAL.
       tc = 'METROS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
ENDIF.

IF ztt_ent_mat-PESO = 0 OR ztt_ent_mat-PESO IS INITIAL.
       tc = 'PESO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
ENDIF.

        PERFORM insertar_ent_mat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4025
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4025 .

   PERFORM CONTAINERS_EXCEL USING 'MEX'.

   CHECK ok_code_4025 IS NOT INITIAL.

    CASE ok_code_4025.
      WHEN 'BTN_SA'.
        CLEAR ok_code_4025.
        PERFORM CARGAR_EXCEL_MATERIALES.
      WHEN 'BTN_CARGAR'.
        CLEAR ok_code_4025.
        PERFORM INSERTAR_EXCEL_MATERIALES.
      WHEN 'BTN_BA'.
        CLEAR ok_code_4025.
        PERFORM LIMPIAR_EXCEL USING 'MEX'.

    ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CARGAR_EXCEL_MATERIALES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cargar_excel_materiales .

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
      i_end_col               = 5 "En que columna del Excel Finalizara el recorrido
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
    IF lv_column-col eq 1 AND lv_row-row eq 1 AND lv_column-value EQ 'DESCRIPCION'.
*      l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 2 AND lv_row-row eq 1 AND lv_column-value EQ 'COLOR'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 3 AND lv_row-row eq 1 AND lv_column-value EQ 'ROLLOS'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 4 AND lv_row-row eq 1 AND lv_column-value EQ 'ROLLOS_INCOMPLETOS'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 5 AND lv_row-row eq 1 AND lv_column-value EQ 'PESO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.

  ENDLOOP.

    IF CE EQ 5.
          MESSAGE 'El archivo si tiene la misma estructura' TYPE 'I'.
          exit.
        ELSE.
*          MESSAGE 'El archivo no tiene la misma estructura de la tabla' TYPE 'E'.
          MESSAGE s016(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
          RETURN.
**          ROLLBACK WORK.
    ENDIF.

ENDLOOP.

DATA VALID_MULT_MATS TYPE I.

IF CE eq 5.
*----------------------------------------------------------------------
*----------------------------------------------------------------------
*----------------------------------------------------------------------
      LOOP AT gt_arch INTO DATA(llv_row).
        LOOP AT gt_arch INTO DATA(llv_column).

          " Valor de la celda actual
          DATA(lv_column_value) = llv_column-value.
*----------------------------------------------------------------------
*----------------------------------------------------------------------
*-----------------------------Validacion-------------------------------
*-----------------------------MATERIALES-------------------------------
*----------------------------------------------------------------------
          IF llv_column-col = 1 AND llv_column-value NE 'DESCRIPCION'.
            tc = 'DESCRIPCION'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
                PERFORM valid_espacios.
                IF  reg_prod eq abap_true.
                    PERFORM valid_letras.
                    IF  reg_prod eq abap_true.
                          PERFORM valid_palabras_ofensivas.
                            IF  reg_prod eq abap_true.

                              ELSE.
                                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                                RETURN.
*                                ROLLBACK WORK.
*                                EXIT.
                              ENDIF.
                        ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                          RETURN.
                    ENDIF.
                    ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
                ENDIF.
              ELSE.
                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                RETURN.
            ENDIF.
            ENDIF.
*----------------------------------------------------------------------------
          IF llv_column-col = 2 AND llv_column-value NE 'COLOR'.
            tc = 'COLOR'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
                PERFORM valid_espacios.
                IF  reg_prod eq abap_true.
                    PERFORM valid_letras.
                    IF  reg_prod eq abap_true.
                          PERFORM valid_palabras_ofensivas.
                            IF  reg_prod eq abap_true.

                              ELSE.
                                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                                RETURN.
                              ENDIF.
                        ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                          RETURN.
                    ENDIF.
                    ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
                ENDIF.
              ELSE.
                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                RETURN.
            ENDIF.
            ENDIF.
*----------------------------------------------------------------------------
          IF llv_column-col = 3 AND llv_column-value NE 'ROLLOS'.
            tc = 'ROLLOS'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
              PERFORM valid_solo_nums.
              IF  reg_prod eq abap_true.

                  ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
              ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------------
          IF llv_column-col = 4 AND llv_column-value NE 'ROLLOS_INCOMPLETOS'.
            tc = 'ROLLOS_INCOMPLETOS'.
            l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
              PERFORM valid_solo_nums.
              IF  reg_prod eq abap_true.

                  ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
              ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------------
          IF llv_column-col = 5 AND llv_column-value NE 'PESO'.
            tc = 'PESO'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
              PERFORM valid_solo_nums.
              IF  reg_prod eq abap_true.

                  ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
              ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------
*----------------------------------------------------------------------
*----------------------------------------------------------------------
        ENDLOOP.
      ENDLOOP.
*----------------------------------------------------------------------
*----------------------------------------------------------------------
*----------------------------------------------------------------------
ENDIF.
*----------------------------------------------------------------------
*----------------------------------------------------------------------
*----------------------------------------------------------------------
IF VALID_MULT_MATS > 0.
*  MESSAGE 'El archivo contiene campos invalido'
  ELSE.
    PERFORM insert_multi_datos_materiales.
ENDIF.

  CATCH cx_root INTO DATA(e_text).

      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form insert_multi_datos_materiales
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_multi_datos_materiales .

SELECT MAX( id_material )
    FROM ztc_materiales
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
      i_end_col               = 6 "En que columna del Excel Finalizara el recorrido
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
          WHEN 1.
            res = res + 1.
            MOVE res TO gwa_mat-id_material.
            MOVE gwa_arch-value TO gwa_mat-descripcion.
          WHEN 2.
            MOVE gwa_arch-value TO gwa_mat-color.
          WHEN 3.
            MOVE gwa_arch-value TO gwa_mat-rollos.
          WHEN 4.
            MOVE gwa_arch-value TO gwa_mat-rollos_incompletos.
          WHEN 5.
            MOVE gwa_arch-value TO gwa_mat-peso.
      ENDCASE.

      AT END OF row."Durante el ciclo se lee el dato dentro de la tabla interna
        APPEND gwa_mat TO gt_mat.
        INSERT INTO ZTE_MATERIALES VALUES GWA_MAT."Despues de leer el dato, se inserta la fila en la tabla interna.
        CLEAR gwa_mat."Se limpia la variable para que pueda tener la siguiente entrada
        ENDAT.

    ENDLOOP.

  ENDIF.

  CATCH cx_root INTO DATA(e_text).

      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.

DATA: lt_materiales TYPE TABLE OF ZTE_MATERIALES,
      lv_count      TYPE i.

SELECT * FROM ZTE_MATERIALES INTO TABLE lt_materiales.

LOOP AT lt_materiales INTO DATA(ls_material).
  IF ls_material-id_material        IS INITIAL OR ls_material-id_material        EQ '0' OR
     ls_material-descripcion        IS INITIAL OR ls_material-descripcion        EQ '0' OR
     ls_material-color              IS INITIAL OR ls_material-color              EQ '0' OR
     ls_material-rollos             IS INITIAL OR ls_material-rollos             EQ '0' OR
     ls_material-rollos_incompletos IS INITIAL OR ls_material-rollos_incompletos EQ '0' OR
     ls_material-peso               IS INITIAL OR ls_material-peso               EQ '0'.
    lv_count = lv_count + 1.
  ENDIF.
ENDLOOP.

 IF lv_count > 0.
      DELETE FROM ZTE_MATERIALES.
      MESSAGE s017(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
*      MESSAGE 'El archivo contiene campos invalidos' TYPE 'I'.
    ELSE.
      MESSAGE 'Datos cargados' TYPE 'I'.
 ENDIF.

  PERFORM CONTAINERS_EXCEL USING 'MEX'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4012
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4012 .

  DYN_MOV = 'ENT_PROD'.
*  type_sum_ent_pro = abap_false.
*  type_sum_dev_pro = abap_false.

  IF ztt_ent_pro-folio_ent_pro IS INITIAL.

    SELECT MAX( FOLIO_ENT_PRO )
      FROM ztc_ent_producto
      INTO ( gv_max ).
    MOVE gv_max TO res.
    res = res + 1.
    MOVE res TO gv_max.
    ztt_ent_pro-folio_ent_pro = gv_max.
    ztt_ent_pro-ALMACENISTA = SY-UNAME.
    ztt_ent_pro-FECHA_ENTRADA = SY-DATUM.
    ztt_ent_pro-PESO_TOTAL = 0.
    ztt_ent_pro-merma = 0.
*    ztt_ent_pro-PESO_RESTANTE = 0.

  ENDIF.

  PERFORM CONTAINERS_ENT_SAL USING 'EP'.

  CHECK ok_code_4012 IS NOT INITIAL.

  CASE ok_code_4012.
    WHEN 'BTN_ADD'.
        CLEAR OK_CODE_4012.
*       sum_gen_ent_pro = ztt_ent_pro-merma + ztt_ent_pro-peso_total.
        PERFORM VALID_INSERT_ENT_PRO.
*       PERFORM INSERTAR_ENT_PRO.
    WHEN 'BTN_ADD2'.
       CLEAR OK_CODE_4012.
       PERFORM VALID_INSERT_DEV_ENT_PRO.
*       PERFORM INSERTAR_DEV_ENT_PRO.
    WHEN 'BTN_REM'.
       CLEAR OK_CODE_4012.
       CLEAR INITIALS_FOLIO.
*----------------------------------------------------------------------------------------------
       PERFORM VALID_INSERT_ALL_ENT_PRO.
       IF INITIALS_FOLIO eq  abap_true.
          PERFORM INSERT_ALL_ENT_PRO.
          IF FGL eq abap_false.
             PERFORM DELETE_ENT_PRO.
             CLEAR: ztt_ent_pro-folio_ent_pro,
                    ztt_ent_pro-folio_sal_mat,
                    ztt_ent_pro-id_empleado,
                    ztt_ent_pro-ALMACENISTA,
                    ztt_ent_pro-FECHA_ENTRADA,
                    ztt_ent_pro-PESO_TOTAL,
                    ztt_ent_pro-merma.
             LEAVE TO SCREEN 0.
          ENDIF.
*----------------------------------------------------------------------------------------------
         ELSE.
            tc = 'FOLIO SALIDA MATERIAL'.
            MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*          MESSAGE 'El campo FOLIO SALIDA MATERIAL esta vacio'  TYPE 'I'.
       ENDIF.
*       PERFORM INSERT_ALL_ENT_PRO.

    WHEN 'BTN_CAN'.
      CLEAR OK_CODE_4012.
      PERFORM DELETE_ENT_PRO.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4014
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4014 .

  IF ztt_sal_pro-folio_sal_pro IS INITIAL.

    SELECT MAX( FOLIO_SAL_PRO )
    FROM ztc_sal_producto
    INTO ( gv_max ).
    MOVE gv_max TO res.
    res = res + 1.
    MOVE res TO gv_max.
    ztt_sal_pro-folio_sal_pro = gv_max.
    ztt_sal_pro-ALMACENISTA = SY-UNAME.
    ztt_sal_pro-FECHA_SALIDA = SY-DATUM.

  ENDIF.

  PERFORM CONTAINERS_ENT_SAL USING 'SP'.
*BTN_ADD
*BTN_REM
*BTN_CAN
  CHECK OK_CODE_4014 IS NOT INITIAL.

  CASE OK_CODE_4014.
    WHEN 'BTN_ADD'.
          CLEAR OK_CODE_4014.
          PERFORM VALID_INSERT_SAL_PRO.
*          PERFORM INSERT_SAL_PRO.
    WHEN 'BTN_REM'.
          CLEAR OK_CODE_4014.
          PERFORM VALID_INSERT_ALL_SAL_PRO.
          IF FGL EQ abap_false.
            PERFORM DELET_SAL_PRO.
            CLEAR: ztt_sal_pro-folio_sal_pro,
                   ztt_sal_pro-id_cliente,
                   ztt_sal_pro-almacenista,
                   ztt_sal_pro-fecha_salida.
            LEAVE TO SCREEN 0.
          ENDIF.

*          PERFORM INSERT_ALL_SAL_PRO.
    WHEN 'BTN_CAN'.
          CLEAR OK_CODE_4014.
          PERFORM DELET_SAL_PRO.
    ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form LIBERAR_CONT_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LIBERAR_CONT_EXCEL.

  IF C_CONTAINER_EXCEL IS BOUND.

    C_CONTAINER_EXCEL->free(
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        others            = 3
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CLEAR C_CONTAINER_EXCEL.

    IF GALV_GRID_EXCEL IS BOUND.

      CLEAR GALV_GRID_EXCEL.

    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESCAR_ALV_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESCAR_ALV_EXCEL.

  GALV_GRID_EXCEL->refresh_table_display(
*    EXPORTING
*      is_stable      =
*      i_soft_refresh =
    EXCEPTIONS
      finished       = 1
      others         = 2
  ).
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INST_CONT_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INST_CONT_EXCEL USING A1.

  IF A1 EQ 'MEX'.

    CREATE OBJECT c_container_excel
      EXPORTING
*        parent                      =
        container_name              = 'C_MULTI_MAT'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A1 EQ 'PEX'.

    CREATE OBJECT c_container_excel
      EXPORTING
*        parent                      =
        container_name              = 'C_MULTI_PRO'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A1 EQ 'PVEX'.

    CREATE OBJECT c_container_excel
      EXPORTING
*        parent                      =
        container_name              = 'C_MULTI_PROV'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A1 EQ 'EEX'.

    CREATE OBJECT c_container_excel
      EXPORTING
*        parent                      =
        container_name              = 'C_MULTI_MAQ'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A1 EQ 'CEX'.

    CREATE OBJECT c_container_excel
      EXPORTING
*        parent                      =
        container_name              = 'C_MULTI_CLI'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        others                      = 6
      .
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUILD_FIELDCAT_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM BUILD_FIELDCAT_EXCEL USING A2.

  IF A2 EQ 'MEX'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTE_MATERIALES'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_MAT_EXC
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ELSEIF A2 EQ 'PEX'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTE_PRODUCTOS'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_PRO_EXC
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ELSEIF A2 EQ 'PVEX'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTE_PROVEEDORES'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_PROV_EXC
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ELSEIF A2 EQ 'EEX'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTE_EMPLEADOS'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_EMP_EXC
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ELSEIF A2 EQ 'CEX'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTE_CLIENTES'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_CLI_EXC
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA_EXCEL USING A3.

  IF A3 EQ 'MEX'.

    SELECT * FROM ZTE_MATERIALES
      INTO CORRESPONDING FIELDS OF TABLE GT_MAT_EXC.

  ELSEIF A3 EQ 'PEX'.

    SELECT * FROM ZTE_PRODUCTOS
      INTO CORRESPONDING FIELDS OF TABLE GT_PRO_EXC.

  ELSEIF A3 EQ 'PVEX'.

    SELECT * FROM ZTE_PROVEEDORES
      INTO CORRESPONDING FIELDS OF TABLE GT_PROV_EXC.

  ELSEIF A3 EQ 'EEX'.

    SELECT * FROM ZTE_EMPLEADOS
      INTO CORRESPONDING FIELDS OF TABLE GT_EMP_EXC.

  ELSEIF A3 EQ 'CEX'.

    SELECT * FROM ZTE_CLIENTES
      INTO CORRESPONDING FIELDS OF TABLE GT_CLI_EXC.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_MATEX
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_MATEX.

  CREATE OBJECT galv_grid_excel
    EXPORTING
      i_parent                = C_CONTAINER_EXCEL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_MATEX
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_PROEX.

  CREATE OBJECT galv_grid_excel
    EXPORTING
      i_parent                = C_CONTAINER_EXCEL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_MATEX
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_PVEX.

  CREATE OBJECT galv_grid_excel
    EXPORTING
      i_parent                = C_CONTAINER_EXCEL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_MATEX
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_EMPEX.

  CREATE OBJECT galv_grid_excel
    EXPORTING
      i_parent                = C_CONTAINER_EXCEL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_MATEX
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_CLIEX.

  CREATE OBJECT galv_grid_excel
    EXPORTING
      i_parent                = C_CONTAINER_EXCEL
    EXCEPTIONS
      error_cntl_create       = 1
      error_cntl_init         = 2
      error_cntl_link         = 3
      error_dp_create         = 4
      others                  = 5
    .
  IF SY-SUBRC <> 0.
   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form BUILD_LAYOUT_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM BUILD_LAYOUT_EXCEL USING A4.

  IF A4 EQ 'MEX'.

    GS_LAYOUT_EXCEL-zebra = ABAP_TRUE.
    GS_LAYOUT_EXCEL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_EXCEL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_MAT_EXC ASSIGNING <LS_FIELDCAT_EXCEL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_MAT_EXC ASSIGNING <LS_MAT_EXC>.

        LS_STYLE_EXCEL-fieldname = <LS_FIELDCAT_EXCEL>-fieldname.
        LS_STYLE_EXCEL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_EXCEL INTO TABLE <LS_MAT_EXC>-field_style.

      ENDLOOP.
    ENDLOOP.

  ELSEIF A4 EQ 'PEX'.

    GS_LAYOUT_EXCEL-zebra = ABAP_TRUE.
    GS_LAYOUT_EXCEL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_EXCEL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_MAT_EXC ASSIGNING <LS_FIELDCAT_EXCEL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_PRO_EXC ASSIGNING <LS_PRO_EXC>.

        LS_STYLE_EXCEL-fieldname = <LS_FIELDCAT_EXCEL>-fieldname.
        LS_STYLE_EXCEL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_EXCEL INTO TABLE <LS_PRO_EXC>-field_style.

      ENDLOOP.
    ENDLOOP.

  ELSEIF A4 EQ 'PVEX'.

    GS_LAYOUT_EXCEL-zebra = ABAP_TRUE.
    GS_LAYOUT_EXCEL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_EXCEL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_MAT_EXC ASSIGNING <LS_FIELDCAT_EXCEL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_PROV_EXC ASSIGNING <LS_PROV_EXC>.

        LS_STYLE_EXCEL-fieldname = <LS_FIELDCAT_EXCEL>-fieldname.
        LS_STYLE_EXCEL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_EXCEL INTO TABLE <LS_PROV_EXC>-field_style.

      ENDLOOP.
    ENDLOOP.

  ELSEIF A4 EQ 'EEX'.

    GS_LAYOUT_EXCEL-zebra = ABAP_TRUE.
    GS_LAYOUT_EXCEL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_EXCEL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_MAT_EXC ASSIGNING <LS_FIELDCAT_EXCEL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_EMP_EXC ASSIGNING <LS_EMP_EXC>.

        LS_STYLE_EXCEL-fieldname = <LS_FIELDCAT_EXCEL>-fieldname.
        LS_STYLE_EXCEL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_EXCEL INTO TABLE <LS_EMP_EXC>-field_style.

      ENDLOOP.
    ENDLOOP.

  ELSEIF A4 EQ 'CEX'.

    GS_LAYOUT_EXCEL-zebra = ABAP_TRUE.
    GS_LAYOUT_EXCEL-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_EXCEL-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_MAT_EXC ASSIGNING <LS_FIELDCAT_EXCEL> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_CLI_EXC ASSIGNING <LS_CLI_EXC>.

        LS_STYLE_EXCEL-fieldname = <LS_FIELDCAT_EXCEL>-fieldname.
        LS_STYLE_EXCEL-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_EXCEL INTO TABLE <LS_CLI_EXC>-field_style.

      ENDLOOP.
    ENDLOOP.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY_ALV_EXCEL USING A5.

  IF A5 EQ 'MEX'.

    galv_grid_excel->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_EXCEL
      CHANGING
        it_outtab                     = GT_MAT_EXC
        it_fieldcatalog               = GT_FIELDCAT_MAT_EXC
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A5 EQ 'PEX'.

    galv_grid_excel->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_EXCEL
      CHANGING
        it_outtab                     = GT_PRO_EXC
        it_fieldcatalog               = GT_FIELDCAT_PRO_EXC
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A5 EQ 'PVEX'.

    galv_grid_excel->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_EXCEL
      CHANGING
        it_outtab                     = GT_PROV_EXC
        it_fieldcatalog               = GT_FIELDCAT_PROV_EXC
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A5 EQ 'EEX'.

    galv_grid_excel->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_EXCEL
      CHANGING
        it_outtab                     = GT_EMP_EXC
        it_fieldcatalog               = GT_FIELDCAT_EMP_EXC
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSEIF A5 EQ 'CEX'.

    galv_grid_excel->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_EXCEL
      CHANGING
        it_outtab                     = GT_CLI_EXC
        it_fieldcatalog               = GT_FIELDCAT_CLI_EXC
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        others                        = 4
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CONTAINERS_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CONTAINERS_EXCEL USING T6 .

  PERFORM LIBERAR_CONT_EXCEL.

  IF T6 EQ 'MEX'.

    IF NOT C_CONTAINER_EXCEL IS BOUND.

      PERFORM INST_CONT_EXCEL USING 'MEX'.
      PERFORM BUILD_FIELDCAT_EXCEL USING 'MEX'.
      PERFORM GET_DATA_EXCEL USING 'MEX'.
      PERFORM INSTANCE_ALV_MATEX.
      PERFORM BUILD_LAYOUT_EXCEL USING 'MEX'.
      PERFORM DISPLAY_ALV_EXCEL USING 'MEX'.

    ELSE.

      PERFORM REFRESCAR_ALV_EXCEL.

    ENDIF.

  ELSEIF T6 EQ 'PEX'.

    IF NOT C_CONTAINER_EXCEL IS BOUND.

      PERFORM INST_CONT_EXCEL USING 'PEX'.
      PERFORM BUILD_FIELDCAT_EXCEL USING 'PEX'.
      PERFORM GET_DATA_EXCEL USING 'PEX'.
      PERFORM INSTANCE_ALV_PROEX.
      PERFORM BUILD_LAYOUT_EXCEL USING 'PEX'.
      PERFORM DISPLAY_ALV_EXCEL USING 'PEX'.

    ELSE.

      PERFORM REFRESCAR_ALV_EXCEL.

    ENDIF.

  ELSEIF T6 EQ 'PVEX'.

    IF NOT C_CONTAINER_EXCEL IS BOUND.

      PERFORM INST_CONT_EXCEL USING 'PVEX'.
      PERFORM BUILD_FIELDCAT_EXCEL USING 'PVEX'.
      PERFORM GET_DATA_EXCEL USING 'PVEX'.
      PERFORM INSTANCE_ALV_PVEX.
      PERFORM BUILD_LAYOUT_EXCEL USING 'PVEX'.
      PERFORM DISPLAY_ALV_EXCEL USING 'PVEX'.

    ELSE.

      PERFORM REFRESCAR_ALV_EXCEL.

    ENDIF.

  ELSEIF T6 EQ 'EEX'.

    IF NOT C_CONTAINER_EXCEL IS BOUND.

      PERFORM INST_CONT_EXCEL USING 'EEX'.
      PERFORM BUILD_FIELDCAT_EXCEL USING 'EEX'.
      PERFORM GET_DATA_EXCEL USING 'EEX'.
      PERFORM INSTANCE_ALV_EMPEX.
      PERFORM BUILD_LAYOUT_EXCEL USING 'EEX'.
      PERFORM DISPLAY_ALV_EXCEL USING 'EEX'.

    ELSE.

      PERFORM REFRESCAR_ALV_EXCEL.

    ENDIF.

  ELSEIF T6 EQ 'CEX'.

    IF NOT C_CONTAINER_EXCEL IS BOUND.

      PERFORM INST_CONT_EXCEL USING 'CEX'.
      PERFORM BUILD_FIELDCAT_EXCEL USING 'CEX'.
      PERFORM GET_DATA_EXCEL USING 'CEX'.
      PERFORM INSTANCE_ALV_CLIEX.
      PERFORM BUILD_LAYOUT_EXCEL USING 'CEX'.
      PERFORM DISPLAY_ALV_EXCEL USING 'CEX'.

    ELSE.

      PERFORM REFRESCAR_ALV_EXCEL.

    ENDIF.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form init_4026
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4026 .

  PERFORM CONTAINERS_EXCEL USING 'PEX'.

  CHECK OK_CODE_4026 IS NOT INITIAL.

  CASE ok_code_4026.
      WHEN 'BTN_SA'.
        CLEAR ok_code_4026.
        PERFORM CARGAR_EXCEL_PRODUCTOS.
      WHEN 'BTN_CARGAR'.
        CLEAR ok_code_4026.
        PERFORM INSERTAR_EXCEL_PRODUCTOS.
      WHEN 'BTN_BA'.
        CLEAR ok_code_4026.
        PERFORM LIMPIAR_EXCEL USING 'PEX'.
    ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4027
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4027 .

  PERFORM CONTAINERS_EXCEL USING 'PVEX'.

    CHECK OK_CODE_4027 IS NOT INITIAL.

  CASE ok_code_4027.
      WHEN 'BTN_SA'.
        CLEAR ok_code_4027.
        PERFORM CARGAR_EXCEL_PROVEEDORES.
      WHEN 'BTN_CARGAR'.
        CLEAR ok_code_4027.
        PERFORM INSERTAR_EXCEL_PROVEEDORES.
      WHEN 'BTN_BA'.
        CLEAR ok_code_4027.
        PERFORM LIMPIAR_EXCEL USING 'PVEX'.
    ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4028
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4028 .

  PERFORM CONTAINERS_EXCEL USING 'EEX'.

  CHECK ok_code_4028 IS NOT INITIAL.

    CASE ok_code_4028.
      WHEN 'BTN_SA'.
        CLEAR ok_code_4028.
        PERFORM cargar_excel_maquileros.
      WHEN 'BTN_CARGAR'.
        CLEAR ok_code_4028.
        PERFORM INSERTAR_EXCEL_MAQUILEROS.
      WHEN 'BTN_BA'.
        CLEAR ok_code_4028.
        PERFORM LIMPIAR_EXCEL USING 'EEX'.
    ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4029
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4029 .

  PERFORM CONTAINERS_EXCEL USING 'CEX'.

  CHECK ok_code_4029 IS NOT INITIAL.

    CASE ok_code_4029.
      WHEN 'BTN_SA'.
        CLEAR ok_code_4029.
        PERFORM CARGAR_EXCEL_CLIENTES.
      WHEN 'BTN_CARGAR'.
        CLEAR ok_code_4029.
        PERFORM INSERTAR_EXCEL_CLIENTES.
      WHEN 'BTN_BA'.
        CLEAR ok_code_4029.
        PERFORM LIMPIAR_EXCEL USING 'CEX'.
    ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_40122
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_40122 .

  PERFORM CONTAINERS_ENT_SAL2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_ent_pro .

*  FOLIO_ENT_PRO-
*  ID_EMPLEADO-
*  FOLIO_SAL_MAT-
*  ALMACENISTA-
*  FECHA_ENTRADA-
*  PESO_TOTAL-
*  MERMA-
*  DESCRIPCION-
*  TALLA-
*  COLOR-
*  ID_PRODUCTO-
*  PIEZAS-
*  PESO-


  DATA: LV_PESO TYPE I,
        LV_PESO_TOTAL TYPE I.

  SELECT SINGLE PESO_TOTAL
    INTO LV_PESO
    FROM ZTC_SAL_MATERIAL
    WHERE FOLIO_SAL_MAT = ztt_ent_pro-folio_sal_mat.

   SELECT SINGLE PESO_TOTAL
    INTO LV_PESO_TOTAL
    FROM ZTC_SAL_MATERIAL
    WHERE FOLIO_SAL_MAT = ztt_ent_pro-folio_sal_mat.

    IF lv_peso < ztt_ent_pro-peso.
      MESSAGE s023(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No puedes entregar mas material del que recibiste' TYPE 'I'.
        EXIT.
       ELSE.

     ENDIF.

    IF lv_peso_total < ztt_ent_pro-peso_total.
      MESSAGE s023(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No puedes entregar mas material del que recibiste' TYPE 'I'.
        ROLLBACK WORK.
        EXIT.
       ELSE.

     ENDIF.


    GWA_ENT_PRO-mandt = SY-uname.
    GWA_ENT_PRO-folio_ent_pro = ztt_ent_pro-folio_ent_pro.
    GWA_ENT_PRO-folio_sal_mat = ztt_ent_pro-folio_sal_mat.
    GWA_ENT_PRO-id_empleado = ztt_ent_pro-id_empleado.
    GWA_ENT_PRO-id_producto = ztt_ent_pro-id_producto.
    GWA_ENT_PRO-almacenista = ztt_ent_pro-almacenista.
    GWA_ENT_PRO-fecha_entrada = ztt_ent_pro-fecha_entrada.
    GWA_ENT_PRO-peso_total = ztt_ent_pro-peso_total.
    GWA_ENT_PRO-merma = ztt_ent_pro-merma.
    GWA_ENT_PRO-piezas = ztt_ent_pro-piezas.
    GWA_ENT_PRO-descripcion = ztt_ent_pro-descripcion.
    GWA_ENT_PRO-peso = ztt_ent_pro-peso.
    GWA_ENT_PRO-talla = ztt_ent_pro-talla.
    GWA_ENT_PRO-color = ztt_ent_pro-color.
    GWA_ENT_PRO-icon = '@02@'.

    INSERT INTO ztt_ent_pro VALUES GWA_ENT_PRO.

    IF sy-subrc  eq 0.
        ztt_ent_pro-peso_total = ztt_ent_pro-peso_total + ztt_ent_pro-peso.
        MESSAGE 'Entrada de producto realizada' TYPE 'I'.
         CLEAR: "ztt_ent_pro-peso_total,
                "ztt_ent_pro-merma,
                ztt_ent_pro-id_producto,
                ztt_ent_pro-piezas,
                ztt_ent_pro-peso,
                ztt_ent_pro-descripcion,
                ztt_ent_pro-talla,
                ztt_ent_pro-color.
        PERFORM CONTAINERS_ENT_SAL USING 'EP'.
      ELSE.
        MESSAGE s015(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.

    ENDIF.




ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_DEV_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insertar_dev_ent_pro .

*  FOLIO_DEV_MAT
*  ID_MATERIAL
*  DESCRIPCION
*  COLOR
*  ROLLOS
*  TIPO_ROLLO
*  METROS
*  PESO

  DATA: FOL_DEV TYPE NUMC10.

  FOL_DEV = ztt_ent_pro-folio_ent_pro.

  GWA_DEV_ENT_PRO-mandt         = sy-uname .
  GWA_DEV_ENT_PRO-folio_ent_pro = FOL_DEV .
  GWA_DEV_ENT_PRO-id_material   = ztt_dev_producto-id_material   .
  GWA_DEV_ENT_PRO-descripcion   = ztt_dev_producto-descripcion   .
  GWA_DEV_ENT_PRO-color         = ztt_dev_producto-color         .
  GWA_DEV_ENT_PRO-rollos        = ztt_dev_producto-rollos        .
  GWA_DEV_ENT_PRO-tipo_rollo    = ztt_dev_producto-tipo_rollo    .
  GWA_DEV_ENT_PRO-metros        = ztt_dev_producto-metros        .
  GWA_DEV_ENT_PRO-peso          = ztt_dev_producto-peso          .
  GWA_DEV_ENT_PRO-icon          = '@02@'                         .

  INSERT INTO ztt_dev_producto VALUES gwa_dev_ent_pro.

  IF sy-subrc  eq 0.
*        sum_dev_pro = sum_dev_pro + ztt_dev_producto-peso.
        ztt_ent_pro-peso_total = ztt_ent_pro-peso_total + ztt_dev_producto-peso.
        MESSAGE 'Devolucion de producto realizada' TYPE 'I'.
         CLEAR: ztt_dev_producto-id_material,
                ztt_dev_producto-descripcion,
                ztt_dev_producto-color,
                ztt_dev_producto-rollos,
                ztt_dev_producto-tipo_rollo,
                ztt_dev_producto-metros,
                ztt_dev_producto-peso.
        PERFORM CONTAINERS_ENT_SAL2.
      ELSE.
        MESSAGE s014(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.

    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERT_ALL_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_all_ent_pro .

  CLEAR: mlt_ent_pro,
         t_ent_prot,
         mls_tc_ent_productos,
         t_ent_proc,
         s_ent_proc.

  CLEAR: t_dev_prot,
         t_dev_proc.

     FGL = abap_false.

     SELECT FOLIO_ENT_PRO
            ID_PRODUCTO
            PIEZAS
            PESO
      INTO CORRESPONDING FIELDS OF TABLE t_ent_prot
      FROM ztt_ent_pro.

     SELECT FOLIO_ENT_PRO
            ID_MATERIAL
            ROLLOS
            TIPO_ROLLO
            METROS
            PESO
       INTO CORRESPONDING FIELDS OF TABLE t_dev_prot
       FROM ztt_dev_producto.


       IF t_ent_prot IS NOT INITIAL.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

*          mls_tc_ent_productos-mandt = SY-uname.
*          mls_tc_ent_productos-folio_ent_pro = ztt_ent_pro-folio_ent_pro.
*          mls_tc_ent_productos-id_empleado = ztt_ent_pro-id_empleado.
*          mls_tc_ent_productos-folio_sal_mat = ztt_ent_pro-folio_sal_mat.
*          mls_tc_ent_productos-fecha_entrada = ztt_ent_pro-fecha_entrada.
*          mls_tc_ent_productos-almacenista = ztt_ent_pro-almacenista.
*          mls_tc_ent_productos-peso_total = ztt_ent_pro-peso_total.
*          mls_tc_ent_productos-merma = ztt_ent_pro-merma.
*
*          INSERT INTO ZTC_ENT_PRODUCTO VALUES mls_tc_ent_productos.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
          LOOP AT t_ent_prot INTO s_ent_prot.
            CLEAR: s_ent_proc.
            s_ent_proc-folio_ent_pro = s_ent_prot-folio_ent_pro.
            s_ent_proc-id_producto   = s_ent_prot-id_producto  .
            s_ent_proc-piezas        = s_ent_prot-piezas       .
            s_ent_proc-peso          = s_ent_prot-peso         .
            APPEND s_ent_proc TO t_ent_proc.
          ENDLOOP.

          INSERT ztc_ent_pro_deta FROM TABLE t_ent_proc.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_ent_pro INTO TABLE lt_ent_pro.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_productos INTO TABLE lt_ent_productos.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_ent_pro INTO ls_ent_pro.
  CLEAR lv_ent_pro_suma.
  lv_ent_pro_id = ls_ent_pro-id_producto.

  " Paso 4: Hace la operacion en los valores de CampoTabla1
  LOOP AT lt_ent_pro INTO ls_ent_pro WHERE id_producto = lv_ent_pro_id.
    lv_ent_pro_suma = lv_ent_pro_suma + ls_ent_pro-piezas.
  ENDLOOP.

  " Paso 5: Agregar la operacion a CampoTabla2 en Tabla2
  LOOP AT lt_ent_productos INTO ls_ent_productos WHERE id_producto = lv_ent_pro_id.
    ls_ent_productos-existencia = ls_ent_productos-existencia + lv_ent_pro_suma.
          APPEND ls_ent_productos TO lt_ent_pro_result.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
      LOOP AT lt_ent_pro_result INTO ls_ent_productos.
           MODIFY ztc_productos FROM ls_ent_productos.
      ENDLOOP.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
          type_sum_ent_pro = abap_true.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

         ELSE.
*          MESSAGE 'No se encontraron registros en la tabla de entrada productos.'TYPE 'I'.
*          FGL = abap_true.
*          EXIT.
       ENDIF.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
       IF t_dev_prot IS NOT INITIAL.

*          mls_tc_ent_productos-mandt         = SY-uname.
*          mls_tc_ent_productos-folio_ent_pro = ztt_ent_pro-folio_ent_pro.
*          mls_tc_ent_productos-id_empleado   = ztt_ent_pro-id_empleado.
*          mls_tc_ent_productos-folio_sal_mat = ztt_ent_pro-folio_sal_mat.
*          mls_tc_ent_productos-fecha_entrada = ztt_ent_pro-fecha_entrada.
*          mls_tc_ent_productos-almacenista   = ztt_ent_pro-almacenista.
*          mls_tc_ent_productos-peso_total    = ztt_ent_pro-peso_total.
*          mls_tc_ent_productos-merma         = ztt_ent_pro-merma.
*
*          INSERT INTO ZTC_ENT_PRODUCTO VALUES mls_tc_ent_productos.

          LOOP AT t_dev_prot INTO s_dev_prot.
            CLEAR: s_dev_proc.
            s_dev_proc-folio_ent_pro = s_dev_prot-folio_ent_pro.
            s_dev_proc-id_material   = s_dev_prot-id_material  .
            s_dev_proc-rollos        = s_dev_prot-rollos       .
            s_dev_proc-tipo_rollo    = s_dev_prot-tipo_rollo   .
            s_dev_proc-metros        = s_dev_prot-metros       .
            s_dev_proc-peso          = s_dev_prot-peso         .
            APPEND s_dev_proc TO t_dev_proc.
          ENDLOOP.

          INSERT ztc_dev_producto FROM TABLE t_dev_proc.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**---------------------DEVOLUCION DE MATERIAL A TABLA MATERIALES----------------------------------------

* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_dev_producto INTO TABLE lt_ent_pro_mat.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_materiales INTO TABLE lt_ent_productos_mat.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_ent_pro_mat INTO ls_ent_pro_mat.
  CLEAR lv_ent_pro_suma_mat.
  lv_ent_pro_id_mat = ls_ent_pro_mat-id_material.

  " Paso 4: Hace la operación en los valores de CampoTabla1
  LOOP AT lt_ent_pro_mat INTO ls_ent_pro_mat WHERE id_material = lv_ent_pro_id_mat.
    lv_ent_pro_suma_mat = lv_ent_pro_suma_mat + ls_ent_pro_mat-rollos.
  ENDLOOP.

  " Paso 5: Agregar la operación a CampoTabla2 en Tabla2
  LOOP AT lt_ent_productos_mat INTO ls_ent_productos_mat WHERE id_material = lv_ent_pro_id_mat.
    " Verificar el tipo de rollo
    IF ls_ent_pro_mat-tipo_rollo = 'COMPLETO'.
      " Si es completo, modificar la suma en ROLLO
      ls_ent_productos_mat-rollos = ls_ent_productos_mat-rollos + lv_ent_pro_suma_mat.
    ELSEIF ls_ent_pro_mat-tipo_rollo = 'INCOMPLETO'.
      " Si es incompleto, modificar la suma en ROLLO_INCOMPLETOS
      ls_ent_productos_mat-rollos_incompletos = ls_ent_productos_mat-rollos_incompletos + lv_ent_pro_suma_mat.
    ENDIF.
    APPEND ls_ent_productos_mat TO lt_ent_pro_result_mat.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
LOOP AT lt_ent_pro_result_mat INTO ls_ent_productos_mat.
  MODIFY ztc_materiales FROM ls_ent_productos_mat.
ENDLOOP.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_dev_producto INTO TABLE lt_ent_pro_mat.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_materiales INTO TABLE lt_ent_productos_mat.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_ent_pro_mat INTO ls_ent_pro_mat.
  CLEAR lv_ent_pro_suma_mat.
  lv_ent_pro_id_mat = ls_ent_pro_mat-id_material.

  " Paso 4: Hace la operacion en los valores de CampoTabla1
  LOOP AT lt_ent_pro_mat INTO ls_ent_pro_mat WHERE id_material = lv_ent_pro_id_mat.
    lv_ent_pro_suma_mat = lv_ent_pro_suma_mat + ls_ent_pro_mat-peso.
  ENDLOOP.

  " Paso 5: Agregar la operacion a CampoTabla2 en Tabla2
  LOOP AT lt_ent_productos_mat INTO ls_ent_productos_mat WHERE id_material = lv_ent_pro_id_mat.
    ls_ent_productos_mat-peso = ls_ent_productos_mat-peso + lv_ent_pro_suma_mat.
          APPEND ls_ent_productos_mat TO lt_ent_pro_result_mat.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
      LOOP AT lt_ent_pro_result_mat INTO ls_ent_productos_mat.
           MODIFY ztc_materiales FROM ls_ent_productos_mat.
      ENDLOOP.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
          type_sum_dev_pro = abap_true.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
         ELSE.
*          MESSAGE 'No se encontraron registros en la tabla de devolucion de productos.'TYPE 'I'.
*          FGL = abap_true.
*          EXIT.
       ENDIF.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

IF type_sum_dev_pro EQ abap_true AND type_sum_ent_pro EQ abap_true.
       sum_gen_ent_pro = sum_dev_pro + ztt_ent_pro-merma + ztt_ent_pro-peso_total.
*          mls_tc_ent_productos-mandt         = SY-uname.
*          mls_tc_ent_productos-folio_ent_pro = ztt_ent_pro-folio_ent_pro.
*          mls_tc_ent_productos-id_empleado   = ztt_ent_pro-id_empleado.
*          mls_tc_ent_productos-folio_sal_mat = ztt_ent_pro-folio_sal_mat.
*          mls_tc_ent_productos-fecha_entrada = ztt_ent_pro-fecha_entrada.
*          mls_tc_ent_productos-almacenista   = ztt_ent_pro-almacenista.
*          mls_tc_ent_productos-peso_total    = ztt_ent_pro-peso_total.
*          mls_tc_ent_productos-merma         = ztt_ent_pro-merma.
*
*          INSERT INTO ZTC_ENT_PRODUCTO VALUES mls_tc_ent_productos.
       ELSE.
         IF type_sum_ent_pro EQ abap_true.
            sum_gen_ent_pro = ztt_ent_pro-merma + ztt_ent_pro-peso_total.
*            mls_tc_ent_productos-mandt         = SY-uname.
*            mls_tc_ent_productos-folio_ent_pro = ztt_ent_pro-folio_ent_pro.
*            mls_tc_ent_productos-id_empleado   = ztt_ent_pro-id_empleado.
*            mls_tc_ent_productos-folio_sal_mat = ztt_ent_pro-folio_sal_mat.
*            mls_tc_ent_productos-fecha_entrada = ztt_ent_pro-fecha_entrada.
*            mls_tc_ent_productos-almacenista   = ztt_ent_pro-almacenista.
*            mls_tc_ent_productos-peso_total    = ztt_ent_pro-peso_total.
*            mls_tc_ent_productos-merma         = ztt_ent_pro-merma.
*
*            INSERT INTO ZTC_ENT_PRODUCTO VALUES mls_tc_ent_productos.
            ELSE.
              IF type_sum_dev_pro EQ abap_true.
*                  sum_gen_ent_pro = sum_dev_pro.
*                  sum_dev_pro
                  sum_gen_ent_pro = ztt_ent_pro-merma + ztt_ent_pro-peso_total.

*                  mls_tc_ent_productos-mandt         = SY-uname.
*                  mls_tc_ent_productos-folio_ent_pro = ztt_ent_pro-folio_ent_pro.
*                  mls_tc_ent_productos-id_empleado   = ztt_ent_pro-id_empleado.
*                  mls_tc_ent_productos-folio_sal_mat = ztt_ent_pro-folio_sal_mat.
*                  mls_tc_ent_productos-fecha_entrada = ztt_ent_pro-fecha_entrada.
*                  mls_tc_ent_productos-almacenista   = ztt_ent_pro-almacenista.
*                  mls_tc_ent_productos-peso_total    = ztt_ent_pro-peso_total.
*                  mls_tc_ent_productos-merma         = ztt_ent_pro-merma.
*
*                  INSERT INTO ZTC_ENT_PRODUCTO VALUES mls_tc_ent_productos.

                  ELSE.
                    MESSAGE s019(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*                    MESSAGE 'No se ha registrado ningun registro de entrada/devolucion de productos' TYPE 'I'.
                    FGL = abap_true.
                    ROLLBACK WORk.
                    EXIT.
              ENDIF.
         ENDIF.
ENDIF.



  DATA: LV_TOTAL_REST TYPE I.

      SELECT SINGLE PESO_RESTANTE
        INTO LV_TOTAL_REST
        FROM ZTC_SAL_MATERIAL
        WHERE FOLIO_SAL_MAT = ztt_ent_pro-folio_sal_mat.

      IF LV_TOTAL_REST < sum_gen_ent_pro .

            MESSAGE s019(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*            MESSAGE 'Estas entregando mas material del que salio de almacen' TYPE 'I'.
            FGL = abap_true.
            ROLLBACK WORK.
            EXIT.
          ELSE.
*-------------------------------------------------------------------------------------------------------
*-------------------------------------------------------------------------------------------------------
*---------------------ACTUALIZAR ZTC_SAL_MATERIALES-ZTC_MATERIALES--------------------------------------
*-------------------------------------------------------------------------------------------------------
*-------------------------------------------------------------------------------------------------------
DATA: lv_folio_sal_mat TYPE ZTC_SAL_MATERIAL-FOLIO_SAL_MAT,
      lt_ztc_sal_materiales TYPE TABLE OF ZTC_SAL_MATERIAL.

        " Asigna el valor de FOLIO_SAL_MAT
        lv_folio_sal_mat = ztt_ent_pro-folio_sal_mat.

        " Realiza la actualización
        UPDATE ZTC_SAL_MATERIAL SET PESO_RESTANTE = PESO_RESTANTE - sum_gen_ent_pro
               WHERE FOLIO_SAL_MAT = lv_folio_sal_mat.

        SELECT SINGLE PESO_RESTANTE
        INTO LV_TOTAL_REST
        FROM ZTC_SAL_MATERIAL
        WHERE FOLIO_SAL_MAT = ztt_ent_pro-folio_sal_mat.

       IF LV_TOTAL_REST EQ 0.
           UPDATE ZTC_SAL_MATERIAL SET estatus = 'COMPLETADO'
               WHERE FOLIO_SAL_MAT = lv_folio_sal_mat.
         ELSE.
           UPDATE ZTC_SAL_MATERIAL SET estatus = 'INCOMPLETO'
               WHERE FOLIO_SAL_MAT = lv_folio_sal_mat.
       ENDIF.

      ENDIF.

     mls_tc_ent_productos-mandt         = SY-uname.
     mls_tc_ent_productos-folio_ent_pro = ztt_ent_pro-folio_ent_pro.
     mls_tc_ent_productos-id_empleado   = ztt_ent_pro-id_empleado.
     mls_tc_ent_productos-folio_sal_mat = ztt_ent_pro-folio_sal_mat.
     mls_tc_ent_productos-fecha_entrada = ztt_ent_pro-fecha_entrada.
     mls_tc_ent_productos-almacenista   = ztt_ent_pro-almacenista.
     mls_tc_ent_productos-peso_total    = ztt_ent_pro-peso_total.
     mls_tc_ent_productos-merma         = ztt_ent_pro-merma.

     INSERT INTO ZTC_ENT_PRODUCTO VALUES mls_tc_ent_productos.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_ALL_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_all_ent_pro .


*DATA: INITIALS_FOLIO TYPE ABAP_BOOL,
*      INITIALS_ENT_PRO TYPE ABAP_BOOL,
*      INITIALS_DEV_PRO TYPE ABAP_BOOL.

IF ztt_ent_pro-folio_sal_mat EQ 0 OR ztt_ent_pro-folio_sal_mat IS INITIAL.
        MESSAGE s021(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'Se necesita un folio de material para continuar' TYPE 'I'.
        INITIALS_FOLIO = abap_false.
        EXIT.
        ELSE.
        INITIALS_FOLIO = abap_true.
        EXIT.
     ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DELETE_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_ent_pro .


  DELETE FROM ztt_ent_pro WHERE folio_ent_pro GT 0.

  DELETE FROM ztt_dev_producto WHERE folio_ent_pro GT 0.

  CLEAR: ztt_ent_pro-peso_total,
         ztt_ent_pro-merma,
         ztt_ent_pro-id_producto,
         ztt_ent_pro-piezas,
         ztt_ent_pro-peso,
         ztt_ent_pro-descripcion,
         ztt_ent_pro-talla,
         ztt_ent_pro-color.

  CLEAR: ztt_dev_producto-id_material,
         ztt_dev_producto-descripcion,
         ztt_dev_producto-color,
         ztt_dev_producto-rollos,
         ztt_dev_producto-tipo_rollo,
         ztt_dev_producto-metros,
         ztt_dev_producto-peso.

  PERFORM CONTAINERS_ENT_SAL USING 'EP'.
  PERFORM CONTAINERS_ENT_SAL2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_ent_pro .

*  IF ZTC_EMPLEADOS-NOMBRE IS INITIAL.
*        MESSAGE 'No existe este maquilero' TYPE 'I'.
*        EXIT.
*     ENDIF.

  IF ztt_ent_pro-folio_sal_mat = 0 OR ztt_ent_pro-folio_sal_mat IS INITIAL.
       tc = 'Folio Salida de Material'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  IF ztt_ent_pro-id_empleado = 0 OR ztt_ent_pro-id_empleado IS INITIAL.
       tc = 'ID EMPLEADO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

      tc = 'ALMACENISTA'.
      l_string = ztt_ent_pro-ALMACENISTA.
      IF ztt_ent_pro-ALMACENISTA IS NOT INITIAL.
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

   IF ztt_ent_pro-fecha_entrada IS INITIAL.
       tc = 'FECHA DE ENTRADA'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

   IF ztt_ent_pro-id_producto = 0 OR ztt_ent_pro-id_producto IS INITIAL.
       tc = 'ID PRODUCTO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

   IF ztt_ent_pro-piezas = 0 OR ztt_ent_pro-piezas IS INITIAL.
       tc = ' PIEZAS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

   IF ztt_ent_pro-peso = 0 OR ztt_ent_pro-peso IS INITIAL.
       tc = 'PESO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

       PERFORM INSERTAR_ENT_PRO.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_DEV_ENT_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_dev_ent_pro .

    IF ztt_dev_producto-id_material = 0 OR ztt_dev_producto-id_material IS INITIAL.
       tc = 'ID MATERIAL'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_dev_producto-rollos = 0 OR ztt_dev_producto-rollos IS INITIAL.
       tc = 'ROLLOS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_dev_producto-tipo_rollo IS INITIAL.
       tc = 'TIPO DE ROLLO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_dev_producto-metros = 0 OR ztt_dev_producto-metros IS INITIAL.
       tc = 'METROS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

     IF ztt_dev_producto-peso = 0 OR ztt_dev_producto-peso IS INITIAL.
       tc = 'PESO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  PERFORM INSERTAR_DEV_ENT_PRO.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERT_SAL_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_sal_pro .

  DATA: lv_piezas TYPE I.

   SELECT SINGLE EXISTENCIA
    INTO lv_piezas
    FROM ztc_productos
    WHERE id_producto = ztt_sal_pro-id_producto.

     IF lv_piezas < ztt_sal_pro-piezas.
       tc = 'Producto'.
       MESSAGE s018(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No puedes pedir mas productos del que hay en el almacen' TYPE 'I'.
        EXIT.
       ELSE.

     ENDIF.

  gwa_sal_pro-mandt         = sy-uname .
  gwa_sal_pro-folio_sal_pro = ztt_sal_pro-folio_sal_pro .
  gwa_sal_pro-id_cliente    = ztt_sal_pro-id_cliente    .
  gwa_sal_pro-almacenista   = ztt_sal_pro-almacenista   .
  gwa_sal_pro-fecha_salida  = ztt_sal_pro-fecha_salida  .
  gwa_sal_pro-id_producto   = ztt_sal_pro-id_producto   .
  gwa_sal_pro-descripcion   = ztt_sal_pro-descripcion   .
  gwa_sal_pro-talla         = ztt_sal_pro-talla         .
  gwa_sal_pro-color         = ztt_sal_pro-color         .
  gwa_sal_pro-piezas        = ztt_sal_pro-piezas        .
  gwa_sal_pro-peso          = ztt_sal_pro-peso          .
  gwa_sal_pro-precio        = ztt_sal_pro-precio        .
  gwa_sal_pro-icon          = '@02@'.

  INSERT INTO ztt_sal_pro VALUES gwa_sal_pro.

          IF sy-subrc EQ 0.
              MESSAGE 'Producto disponible.' TYPE 'I'.
              CLEAR: "ztt_sal_pro-folio_sal_pro
                     "ztt_sal_pro-id_cliente
                     "ztt_sal_pro-almacenista
                     "ztt_sal_pro-fecha_salida
                      ztt_sal_pro-id_producto,
                      ztt_sal_pro-descripcion,
                      ztt_sal_pro-talla,
                      ztt_sal_pro-color,
                      ztt_sal_pro-piezas,
                      ztt_sal_pro-peso,
                      ztt_sal_pro-precio.


              PERFORM CONTAINERS_ENT_SAL USING 'SP'.
            ELSE.
              MESSAGE s015(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
          ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERT_ALL_SAL_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_all_sal_pro .

  CLEAR: mlt_sal_pro,
         t_sal_prot,
         mls_tc_sal_productos,
         t_sal_proc,
         s_sal_proc.

  FGL = abap_false.

  SELECT FOLIO_SAL_PRO
         ID_PRODUCTO
         PIEZAS
         PESO
         PRECIO
     INTO CORRESPONDING FIELDS OF TABLE t_sal_prot
      FROM ztt_sal_pro.

    IF t_sal_prot IS NOT INITIAL.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

*      mls_tc_sal_productos-mandt         = sy-uname .
      mls_tc_sal_productos-folio_sal_pro = ztt_sal_pro-folio_sal_pro .
      mls_tc_sal_productos-id_cliente    = ztt_sal_pro-id_cliente .
      mls_tc_sal_productos-fecha_salida  = ztt_sal_pro-fecha_salida .
      mls_tc_sal_productos-almacenista   = ztt_sal_pro-almacenista .
      INSERT INTO ztc_sal_producto VALUES mls_tc_sal_productos.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
      LOOP AT t_sal_prot INTO s_sal_prot.
        CLEAR: s_sal_proc.
        s_sal_proc-folio_sal_pro = s_sal_prot-folio_sal_pro .
        s_sal_proc-id_producto   = s_sal_prot-id_producto .
        s_sal_proc-piezas        = s_sal_prot-piezas .
        s_sal_proc-peso          = s_sal_prot-peso .
        s_sal_proc-precio        = s_sal_prot-precio .
        APPEND s_sal_proc TO t_sal_proc.
      ENDLOOP.
      INSERT ztc_sal_pro_deta FROM TABLE t_sal_proc.
**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------
* Paso 1: Leer datos de Tabla1
SELECT * FROM ztt_sal_pro INTO TABLE lt_sal_pro.

* Paso 2: Leer datos de Tabla2
SELECT * FROM ztc_productos INTO TABLE lt_sal_productos.

* Paso 3: Procesar todas las entradas de Tabla1
LOOP AT lt_sal_pro INTO ls_sal_pro.
  CLEAR lv_sal_pro_resta.
  lv_sal_pro_id = ls_sal_pro-id_producto.

  " Paso 4: Hace la operacion en los valores de CampoTabla1
  LOOP AT lt_sal_pro INTO ls_sal_pro WHERE id_producto = lv_sal_pro_id.
    lv_sal_pro_resta = lv_sal_pro_resta - ls_sal_pro-piezas.
  ENDLOOP.

  " Paso 5: Agregar la operacion a CampoTabla2 en Tabla2
  LOOP AT lt_sal_productos INTO ls_sal_productos WHERE id_producto = lv_sal_pro_id.
    ls_sal_productos-existencia = ls_sal_productos-existencia + lv_sal_pro_resta.
          APPEND ls_sal_productos TO lt_sal_pro_result.
  ENDLOOP.
ENDLOOP.

" Paso 6: Actualizar Tabla2 con los resultados
      LOOP AT lt_sal_pro_result INTO ls_sal_productos.
           MODIFY ztc_productos FROM ls_sal_productos.
      ENDLOOP.

**------------------------------------------------------------------------------------------------------
**------------------------------------------------------------------------------------------------------

      ELSE.
        MESSAGE s022(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
*        MESSAGE 'No se encontraron registros.'TYPE 'I'.
        FGL = abap_true.
        EXIT.
    ENDIF.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_SAL_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_sal_pro .

  IF ztt_sal_pro-id_cliente = 0 OR ztt_sal_pro-id_cliente IS INITIAL.
       tc = 'ID CLIENTE'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  tc = 'ALMACENISTA'.
  l_string = ztt_sal_pro-ALMACENISTA.
  IF ztt_sal_pro-ALMACENISTA IS NOT INITIAL.
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

  IF ztt_sal_pro-fecha_salida IS INITIAL.
       tc = 'FECHA SALIDA'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  IF ztt_sal_pro-id_producto = 0 OR ztt_sal_pro-id_producto IS INITIAL.
       tc = 'ID PRODUCTO'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  IF ztt_sal_pro-piezas = 0 OR ztt_sal_pro-piezas IS INITIAL.
       tc = 'PIEZAS'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  PERFORM INSERT_SAL_PRO.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_ALL_SAL_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_all_sal_pro .

  IF ztt_sal_pro-id_cliente = 0 OR ztt_sal_pro-id_cliente IS INITIAL.
       tc = 'ID CLIENTE'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  tc = 'ALMACENISTA'.
  l_string = ztt_sal_pro-ALMACENISTA.
  IF ztt_sal_pro-ALMACENISTA IS NOT INITIAL.
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

  IF ztt_sal_pro-fecha_salida IS INITIAL.
       tc = 'FECHA SALIDA'.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  PERFORM INSERT_ALL_SAL_PRO.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DELET_SAL_PRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delet_sal_pro .

      DELETE FROM ztt_sal_pro WHERE folio_sal_pro GT 0.

      CLEAR: "ztt_sal_pro-folio_sal_pro,
             "ztt_sal_pro-id_cliente,
             "ztt_sal_pro-almacenista,
             "ztt_sal_pro-fecha_salida.
              ztt_sal_pro-id_producto,
              ztt_sal_pro-descripcion,
              ztt_sal_pro-talla,
              ztt_sal_pro-color,
              ztt_sal_pro-piezas,
              ztt_sal_pro-peso,
              ztt_sal_pro-precio.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERTAR_ALL_ENT_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insertar_all_ent_mat .

  IF ztt_ent_mat-id_proveedor = 0 OR ztt_ent_mat-id_proveedor IS INITIAL.
       tc = 'ID PROVEEDOR'.
       FGL = abap_true.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  IF ztt_ent_mat-fecha_entrada IS INITIAL.
       tc = 'FECHA DE ENTRADA'.
       FGL = abap_true.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  tc = 'ALMACENISTA'.
  l_string = ztt_ent_mat-ALMACENISTA.
  IF ztt_ent_mat-ALMACENISTA IS NOT INITIAL.
      PERFORM valid_espacios.
      IF  reg_prod eq abap_true.
          PERFORM valid_nums_lets.
          IF  reg_prod eq abap_true.
                PERFORM valid_palabras_ofensivas.
                  IF  reg_prod eq abap_true.

                    ELSE.
                      FGL = abap_true.
                      MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                      EXIT.
                    ENDIF.
              ELSE.
                FGL = abap_true.
                MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                EXIT.
          ENDIF.
          ELSE.
          FGL = abap_true.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
          EXIT.
      ENDIF.
    ELSE.
      FGL = abap_true.
      MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      EXIT.
  ENDIF.

  PERFORM INSERTAR_ALL_ENT_MAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form VALID_INSERT_ALL_SAL_MAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM valid_insert_all_sal_mat .

  IF ztt_sal_mat-id_empleado = 0 OR ztt_sal_mat-id_empleado IS INITIAL.
       tc = 'ID EMPLEADO'.
       FGL = abap_true.
       MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
       EXIT.
     ENDIF.

  IF ztt_sal_mat-fecha_salida IS INITIAL.
       tc = 'FECHA SALIDA'.
       FGL = abap_true.
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
                      FGL = abap_true.
                      MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                      EXIT.
                    ENDIF.
              ELSE.
                FGL = abap_true.
                MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
                EXIT.
          ENDIF.
          ELSE.
          FGL = abap_true.
          MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
          EXIT.
      ENDIF.
    ELSE.
      FGL = abap_true.
      MESSAGE s011(zgi_cv_ms) WITH  tc DISPLAY LIKE 'E'.
      EXIT.
  ENDIF.

  PERFORM INSERT_ALL_SAL_MAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CARGAR_EXCEL_PRODUCTOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cargar_excel_productos .

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
      i_end_col               = 5 "En que columna del Excel Finalizara el recorrido
      i_end_row               = 1000 "En que fila del Excel Finalizara el recorrido
    TABLES
      intern                  = gt_arch
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      others                  = 3.
*----------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------
LOOP AT gt_arch INTO DATA(lv_row).
  LOOP AT gt_arch INTO DATA(lv_column).
    IF lv_column-col eq 1 AND lv_row-row eq 1 AND lv_column-value EQ 'DESCRIPCION'.
*      l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 2 AND lv_row-row eq 1 AND lv_column-value EQ 'COLOR'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 3 AND lv_row-row eq 1 AND lv_column-value EQ 'TALLA'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 4 AND lv_row-row eq 1 AND lv_column-value EQ 'EXISTENCIA'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 5 AND lv_row-row eq 1 AND lv_column-value EQ 'PRECIO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.

  ENDLOOP.

    IF CE EQ 5.
          MESSAGE 'El archivo si tiene la misma estructura' TYPE 'I'.
          exit.
        ELSE.
          MESSAGE s016(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
          RETURN.
**          ROLLBACK WORK.
    ENDIF.
ENDLOOP.
*----------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------
*----------------------------------------------------------------------------------------------
DATA VALID_MULT_MATS TYPE I.

IF CE eq 5.

    LOOP AT gt_arch INTO DATA(llv_row).
        LOOP AT gt_arch INTO DATA(llv_column).
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
          IF llv_column-col = 1 AND llv_column-value NE 'DESCRIPCION'.
            tc = 'DESCRIPCION'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
                PERFORM valid_espacios.
                IF  reg_prod eq abap_true.
                    PERFORM valid_letras.
                    IF  reg_prod eq abap_true.
                          PERFORM valid_palabras_ofensivas.
                            IF  reg_prod eq abap_true.

                              ELSE.
                                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                VALID_MULT_MATS = VALID_MULT_MATS + 1.
                              ENDIF.
                        ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_MATS = VALID_MULT_MATS + 1.
                    ENDIF.
                    ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
                ENDIF.
              ELSE.
                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                VALID_MULT_MATS = VALID_MULT_MATS + 1.
            ENDIF.
            ENDIF.
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
          IF llv_column-col = 2 AND llv_column-value NE 'COLOR'.
            tc = 'COLOR'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
                PERFORM valid_espacios.
                IF  reg_prod eq abap_true.
                    PERFORM valid_letras.
                    IF  reg_prod eq abap_true.
                          PERFORM valid_palabras_ofensivas.
                            IF  reg_prod eq abap_true.

                              ELSE.
                                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                                RETURN.
                              ENDIF.
                        ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                          RETURN.
                    ENDIF.
                    ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
                ENDIF.
              ELSE.
                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                RETURN.
            ENDIF.
            ENDIF.
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
          IF llv_column-col = 3 AND llv_column-value NE 'TALLA'.
            tc = 'TALLA'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
                PERFORM valid_espacios.
                IF  reg_prod eq abap_true.
                    PERFORM valid_letras.
                    IF  reg_prod eq abap_true.
                          PERFORM valid_palabras_ofensivas.
                            IF  reg_prod eq abap_true.

                              ELSE.
                                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                                RETURN.
                              ENDIF.
                        ELSE.
                          MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                          VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                          RETURN.
                    ENDIF.
                    ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
                ENDIF.
              ELSE.
                MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                RETURN.
            ENDIF.
            ENDIF.
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
IF llv_column-col = 4 AND llv_column-value NE 'EXISTENCIA'.
            tc = 'EXISTENCIA'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
              PERFORM valid_solo_nums.
              IF  reg_prod eq abap_true.

                  ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
              ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
IF llv_column-col = 5 AND llv_column-value NE 'PRECIO'.
            tc = 'PRECIO'.
            l_string = llv_column-value.
            IF llv_column-value IS NOT INITIAL.
              PERFORM valid_solo_nums.
              IF  reg_prod eq abap_true.

                  ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
              ELSE.
                    MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
                    VALID_MULT_MATS = VALID_MULT_MATS + 1.
*                    RETURN.
              ENDIF.
          ENDIF.
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
*----------------------------------------------------------------------------
        ENDLOOP.
    ENDLOOP.
  ENDIF.

IF VALID_MULT_MATS > 0.
*  MESSAGE 'El archivo contiene campos invalido'
  ELSE.
    PERFORM insert_multi_datos_productos.
ENDIF.

CATCH cx_root INTO DATA(e_text).

      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form insert_multi_datos_productos
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_multi_datos_productos .

  SELECT MAX( id_producto )
    FROM ztc_productos
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
      i_end_col               = 6 "En que columna del Excel Finalizara el recorrido
      i_end_row               = 1000 "En que fila del Excel Finalizara el recorrido
    TABLES
      intern                  = gt_arch
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      others                  = 3.
*---------------------------------------------------------------------------------------------------------------
*---------------------------------------------------------------------------------------------------------------
*---------------------------------------------------------------------------------------------------------------
*---------------------------------------------------------------------------------------------------------------

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
            MOVE res TO gwa_prod-id_producto.
            MOVE gwa_arch-value TO gwa_prod-descripcion.
          WHEN 2.
            MOVE gwa_arch-value TO gwa_prod-color.
          WHEN 3.
            MOVE gwa_arch-value TO gwa_prod-talla.
          WHEN 4.
            MOVE gwa_arch-value TO gwa_prod-existencia.
          WHEN 5.
            MOVE gwa_arch-value TO gwa_prod-precio.
      ENDCASE.

      AT END OF row."Durante el ciclo se lee el dato dentro de la tabla interna
        APPEND gwa_prod TO gt_prod.
        INSERT INTO zte_productos VALUES gwa_prod."Despues de leer el dato, se inserta la fila en la tabla interna.
        CLEAR gwa_prod."Se limpia la variable para que pueda tener la siguiente entrada
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
DATA: lt_products TYPE TABLE OF zte_productos,
      lv_count      TYPE i.

SELECT * FROM zte_productos INTO TABLE lt_products.

LOOP AT lt_products INTO DATA(ls_prods).
  IF ls_prods-id_producto IS INITIAL OR ls_prods-id_producto  EQ '0' OR
     ls_prods-descripcion IS INITIAL OR ls_prods-descripcion  EQ '0' OR
     ls_prods-color       IS INITIAL OR ls_prods-color        EQ '0' OR
     ls_prods-talla       IS INITIAL OR ls_prods-talla        EQ '0' OR
     ls_prods-existencia  IS INITIAL OR ls_prods-existencia   EQ '0' OR
     ls_prods-precio      IS INITIAL OR ls_prods-precio       EQ '0'.
    lv_count = lv_count + 1.
  ENDIF.
ENDLOOP.

 IF lv_count > 0.
      DELETE FROM zte_productos.
      MESSAGE s017(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
    ELSE.
      MESSAGE 'Datos cargados' TYPE 'I'.
 ENDIF.

  PERFORM CONTAINERS_EXCEL USING 'PEX'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form LIMPIAR_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LIMPIAR_EXCEL USING LE.

  IF LE EQ 'MEX'.
    DELETE FROM ZTE_MATERIALES.
    PERFORM CONTAINERS_EXCEL USING 'MEX'.
  ELSEIF LE EQ 'PEX'.
    DELETE FROM ZTE_PRODUCTOS.
    PERFORM CONTAINERS_EXCEL USING 'PEX'.
  ELSEIF LE EQ 'PVEX'.
    DELETE FROM ZTE_PROVEEDORES.
    PERFORM CONTAINERS_EXCEL USING 'PVEX'.
  ELSEIF LE EQ 'EEX'.
    DELETE FROM ZTE_EMPLEADOS.
    PERFORM CONTAINERS_EXCEL USING 'EEX'.
  ELSEIF LE EQ 'CEX'.
    DELETE FROM ZTE_CLIENTES.
    PERFORM CONTAINERS_EXCEL USING 'CEX'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form cargar_excel_maquileros
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cargar_excel_maquileros .

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
      i_end_col               = 19 "En que columna del Excel Finalizara el recorrido
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
    IF lv_column-col eq 4 AND lv_row-row eq 1 AND lv_column-value EQ 'GENERO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 5 AND lv_row-row eq 1 AND lv_column-value EQ 'FECHA_NACIMIENTO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 6 AND lv_row-row eq 1 AND lv_column-value EQ 'CURP'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 7 AND lv_row-row eq 1 AND lv_column-value EQ 'RFC'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 8 AND lv_row-row eq 1 AND lv_column-value EQ 'NO_SEGURO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 9 AND lv_row-row eq 1 AND lv_column-value EQ 'ESTADO_CIVIL'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 10 AND lv_row-row eq 1 AND lv_column-value EQ 'CALLE'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 11 AND lv_row-row eq 1 AND lv_column-value EQ 'COLONIA'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 12 AND lv_row-row eq 1 AND lv_column-value EQ 'MUNICIPIO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 13 AND lv_row-row eq 1 AND lv_column-value EQ 'ESTADO'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 14 AND lv_row-row eq 1 AND lv_column-value EQ 'NO_EXTERIOR'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 15 AND lv_row-row eq 1 AND lv_column-value EQ 'NO_INTERIOR'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 16 AND lv_row-row eq 1 AND lv_column-value EQ 'CP'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 17 AND lv_row-row eq 1 AND lv_column-value EQ 'TELEFONO1'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 18 AND lv_row-row eq 1 AND lv_column-value EQ 'TELEFONO2'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.
    IF lv_column-col eq 19 AND lv_row-row eq 1 AND lv_column-value EQ 'EMAIL'.
*        l_string = lv_column-value.
        CE = CE + 1.
    ENDIF.

    ENDLOOP.

    IF CE EQ 19.
          MESSAGE 'El archivo si tiene la misma estructura' TYPE 'I'.
          exit.
        ELSE.
          MESSAGE s016(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
          RETURN.
**          ROLLBACK WORK.
    ENDIF.

ENDLOOP.

DATA VALID_MULT_PROV TYPE I.

IF CE EQ 19.
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
          IF llv_column-col = 4 AND llv_column-value NE 'GENERO'.
              tc = 'GENERO'.
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
*          IF llv_column-col = 5 AND llv_column-value NE 'FECHA_NACIMIENTO'.
*              tc = 'FECHA_NACIMIENTO'.
*              l_string = llv_column-value.
*              IF llv_column-value IS NOT INITIAL.
*                  PERFORM valid_espacios.
*                  IF  reg_prod eq abap_true.
*                      PERFORM valid_letras.
*                      IF  reg_prod eq abap_true.
*                            PERFORM valid_palabras_ofensivas.
*                              IF  reg_prod eq abap_true.
**                                  er = er + 1.
*                                ELSE.
*                                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
*                                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                                ENDIF.
*                          ELSE.
*                            MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
*                            VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                      ENDIF.
*                      ELSE.
*                      MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
*                      VALID_MULT_PROV = VALID_MULT_PROV + 1.
*                  ENDIF.
*                ELSE.
*                  MESSAGE s013(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
*                  VALID_MULT_PROV = VALID_MULT_PROV + 1.
*              ENDIF.
*          ENDIF.
*----------------------------------------------------------------------
          IF llv_column-col = 6 AND llv_column-value NE 'CURP'.
              tc = 'CURP'.
              l_string = llv_column-value.
              IF llv_column-value IS NOT INITIAL.
                    PERFORM valid_curp.
                    IF reg_prod eq abap_true.
                        PERFORM valid_palabras_ofensivas.
                        IF reg_prod eq abap_true.
*                            er = er + 1.
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
          IF llv_column-col = 7 AND llv_column-value NE 'RFC'.
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
          IF llv_column-col = 8 AND llv_column-value NE 'NO_SEGURO'.
              tc = 'NO_SEGURO'.
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
          IF llv_column-col = 9 AND llv_column-value NE 'ESTADO_CIVIL'.
              tc = 'ESTADO_CIVIL'.
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
*----------------------------------------------------------------------
          IF llv_column-col = 10 AND llv_column-value NE 'CALLE'.
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
          IF llv_column-col = 11 AND llv_column-value NE 'COLONIA'.
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
          IF llv_column-col = 12 AND llv_column-value NE 'MUNICIPIO'.
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
          IF llv_column-col = 13 AND llv_column-value NE 'ESTADO'.
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
          IF llv_column-col = 14 AND llv_column-value NE 'NO_EXTERIOR'.
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
          IF llv_column-col = 15 AND llv_column-value NE 'NO_INTERIOR'.
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
          IF llv_column-col = 16 AND llv_column-value NE 'CP'.
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
          IF llv_column-col = 17 AND llv_column-value NE 'TELEFONO1'.
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
          IF llv_column-col = 18 AND llv_column-value NE 'TELEFONO2'.
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
          IF llv_column-col = 19 AND llv_column-value NE 'EMAIL'.
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

ENDIF.

IF VALID_MULT_PROV > 0.
    MESSAGE 'El archivo contiene campos invalidos' TYPE 'I'.
  ELSE.
*    MESSAGE 'Todo bien mi pa' TYPE 'I'.
    PERFORM insert_multi_datos_emp.
ENDIF.

CATCH cx_root INTO DATA(e_text).

      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.
*  PERFORM CONTAINERS_EXCEL USING 'EEX'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form insert_multi_datos_emp
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_multi_datos_emp .

  SELECT MAX( id_empleado )
    FROM ztc_empleados
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
      i_end_col               = 19 "En que columna del Excel Finalizara el recorrido
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
            MOVE res TO gwa_emps-id_empleado.
            MOVE gwa_arch-value TO gwa_emps-nombre.
          WHEN 2.
            MOVE gwa_arch-value TO gwa_emps-apellido_paterno.
          WHEN 3.
            MOVE gwa_arch-value TO gwa_emps-apellido_materno.
          WHEN 4.
            MOVE gwa_arch-value TO gwa_emps-genero.
          WHEN 5.
            MOVE gwa_arch-value TO gwa_emps-fecha_nacimiento.
          WHEN 6.
            MOVE gwa_arch-value TO gwa_emps-curp.
          WHEN 7.
            MOVE gwa_arch-value TO gwa_emps-rfc.
          WHEN 8.
            MOVE gwa_arch-value TO gwa_emps-no_seguro.
          WHEN 9.
            MOVE gwa_arch-value TO gwa_emps-estado_civil.
          WHEN 10.
            MOVE gwa_arch-value TO gwa_emps-calle.
          WHEN 11.
            MOVE gwa_arch-value TO gwa_emps-colonia.
          WHEN 12.
            MOVE gwa_arch-value TO gwa_emps-municipio.
          WHEN 13.
            MOVE gwa_arch-value TO gwa_emps-estado.
          WHEN 14.
            MOVE gwa_arch-value TO gwa_emps-no_exterior.
          WHEN 15.
            MOVE gwa_arch-value TO gwa_emps-no_interior.
          WHEN 16.
            MOVE gwa_arch-value TO gwa_emps-cp.
          WHEN 17.
            MOVE gwa_arch-value TO gwa_emps-telefono1.
          WHEN 18.
            MOVE gwa_arch-value TO gwa_emps-telefono2.
          WHEN 19.
            MOVE gwa_arch-value TO gwa_emps-email.
      ENDCASE.

      AT END OF row."Durante el ciclo se lee el dato dentro de la tabla interna
        APPEND gwa_emps TO gt_emp.
        INSERT INTO zte_empleados VALUES gwa_emps."Despues de leer el dato, se inserta la fila en la tabla interna.
        CLEAR gwa_emps."Se limpia la variable para que pueda tener la siguiente entrada
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
DATA: lt_emps TYPE TABLE OF zte_empleados,
      lv_count      TYPE i.

SELECT * FROM zte_empleados INTO TABLE lt_emps.

LOOP AT lt_emps INTO DATA(ls_emps).
  IF ls_emps-id_empleado      IS INITIAL OR ls_emps-id_empleado      EQ '0' OR
     ls_emps-nombre           IS INITIAL OR ls_emps-nombre           EQ '0' OR
     ls_emps-apellido_paterno IS INITIAL OR ls_emps-apellido_paterno EQ '0' OR
     ls_emps-apellido_materno IS INITIAL OR ls_emps-apellido_materno EQ '0' OR
     ls_emps-genero           IS INITIAL OR ls_emps-genero           EQ '0' OR
     ls_emps-fecha_nacimiento IS INITIAL OR ls_emps-fecha_nacimiento EQ '0' OR
     ls_emps-curp             IS INITIAL OR ls_emps-curp             EQ '0' OR
     ls_emps-rfc              IS INITIAL OR ls_emps-rfc              EQ '0' OR
     ls_emps-no_seguro        IS INITIAL OR ls_emps-no_seguro        EQ '0' OR
     ls_emps-estado_civil     IS INITIAL OR ls_emps-estado_civil     EQ '0' OR
*-----------------------------------------------------------------------------------------------------
     ls_emps-calle            IS INITIAL OR ls_emps-calle            EQ '0' OR
     ls_emps-colonia          IS INITIAL OR ls_emps-colonia          EQ '0' OR
     ls_emps-municipio        IS INITIAL OR ls_emps-municipio        EQ '0' OR
     ls_emps-estado           IS INITIAL OR ls_emps-estado           EQ '0' OR
*-----------------------------------------------------------------------------------------------------
     ls_emps-no_exterior      IS INITIAL OR ls_emps-no_exterior      EQ '0' OR
     ls_emps-cp               IS INITIAL OR ls_emps-cp               EQ '0' OR
     ls_emps-telefono1        IS INITIAL OR ls_emps-telefono1        EQ '0' OR
     ls_emps-email            IS INITIAL OR ls_emps-email            EQ '0'.
    lv_count = lv_count + 1.

  ENDIF.
ENDLOOP.

IF lv_count > 0.
      DELETE FROM zte_empleados.
      MESSAGE s017(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
    ELSE.
      MESSAGE 'Datos cargados' TYPE 'I'.
 ENDIF.

  PERFORM CONTAINERS_EXCEL USING 'EEX'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CARGAR_EXCEL_CLIENTES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cargar_excel_clientes .

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
    PERFORM insert_multi_datos_clie.
ENDIF.

CATCH cx_root INTO DATA(e_text).

      MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form insert_multi_datos_clie
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM insert_multi_datos_clie .

  SELECT MAX( id_cliente )
    FROM ztc_clientes
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
            MOVE res TO gwa_clients-id_cliente.
            MOVE gwa_arch-value TO gwa_clients-nombre.
          WHEN 2.
            MOVE gwa_arch-value TO gwa_clients-apellido_paterno.
          WHEN 3.
            MOVE gwa_arch-value TO gwa_clients-apellido_materno.
          WHEN 4.
            MOVE gwa_arch-value TO gwa_clients-tipo_persona.
          WHEN 5.
            MOVE gwa_arch-value TO gwa_clients-rfc.
          WHEN 6.
            MOVE gwa_arch-value TO gwa_clients-razon_social.
          WHEN 7.
            MOVE gwa_arch-value TO gwa_clients-regimen_fiscal.
          WHEN 8.
            MOVE gwa_arch-value TO gwa_clients-calle.
          WHEN 9.
            MOVE gwa_arch-value TO gwa_clients-colonia.
          WHEN 10.
            MOVE gwa_arch-value TO gwa_clients-municipio.
          WHEN 11.
            MOVE gwa_arch-value TO gwa_clients-estado.
          WHEN 12.
            MOVE gwa_arch-value TO gwa_clients-no_exterior.
          WHEN 13.
            MOVE gwa_arch-value TO gwa_clients-no_interior.
          WHEN 14.
            MOVE gwa_arch-value TO gwa_clients-cp.
          WHEN 15.
            MOVE gwa_arch-value TO gwa_clients-telefono1.
          WHEN 16.
            MOVE gwa_arch-value TO gwa_clients-telefono2.
          WHEN 17.
            MOVE gwa_arch-value TO gwa_clients-email.
      ENDCASE.

      AT END OF row."Durante el ciclo se lee el dato dentro de la tabla interna
        APPEND gwa_clients TO gt_client.
        INSERT INTO zte_clientes VALUES gwa_clients."Despues de leer el dato, se inserta la fila en la tabla interna.
        CLEAR gwa_clients."Se limpia la variable para que pueda tener la siguiente entrada
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
DATA: lt_clients TYPE TABLE OF zte_clientes,
      lv_count      TYPE i.

SELECT * FROM zte_clientes INTO TABLE lt_clients.

LOOP AT lt_clients INTO DATA(ls_clients).
  IF ls_clients-id_cliente       IS INITIAL OR ls_clients-id_cliente       EQ '0' OR
     ls_clients-nombre           IS INITIAL OR ls_clients-nombre           EQ '0' OR
     ls_clients-apellido_paterno IS INITIAL OR ls_clients-apellido_paterno EQ '0' OR
     ls_clients-apellido_materno IS INITIAL OR ls_clients-apellido_materno EQ '0' OR
     ls_clients-tipo_persona     IS INITIAL OR ls_clients-tipo_persona     EQ '0' OR
     ls_clients-rfc              IS INITIAL OR ls_clients-rfc              EQ '0' OR
     ls_clients-razon_social     IS INITIAL OR ls_clients-razon_social     EQ '0' OR
*-------------------------------------------------------------------------------------------------------
     ls_clients-regimen_fiscal   IS INITIAL OR ls_clients-regimen_fiscal   EQ '0' OR
     ls_clients-calle            IS INITIAL OR ls_clients-calle            EQ '0' OR
     ls_clients-colonia          IS INITIAL OR ls_clients-colonia          EQ '0' OR
     ls_clients-municipio        IS INITIAL OR ls_clients-municipio        EQ '0' OR
     ls_clients-estado           IS INITIAL OR ls_clients-estado           EQ '0' OR
*-------------------------------------------------------------------------------------------------------
     ls_clients-no_exterior      IS INITIAL OR ls_clients-no_exterior      EQ '0' OR
     ls_clients-cp               IS INITIAL OR ls_clients-cp               EQ '0' OR
     ls_clients-telefono1        IS INITIAL OR ls_clients-telefono1        EQ '0' OR
     ls_clients-email            IS INITIAL OR ls_clients-email            EQ '0'.
    lv_count = lv_count + 1.
  ENDIF.
ENDLOOP.

IF lv_count > 0.
      DELETE FROM zte_clientes.
      MESSAGE s017(zgi_cv_ms) WITH tc DISPLAY LIKE 'E'.
    ELSE.
      MESSAGE 'Datos cargados' TYPE 'I'.
 ENDIF.

PERFORM CONTAINERS_EXCEL USING 'CEX'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_EXCEL_MATERIALES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSERTAR_EXCEL_MATERIALES .

  SELECT ID_MATERIAL
         DESCRIPCION
         COLOR
         ROLLOS
         ROLLOS_INCOMPLETOS
         PESO
   INTO CORRESPONDING FIELDS OF TABLE T_EXC_MATT
    FROM ZTE_MATERIALES.


    IF T_EXC_MATT IS NOT INITIAL.


      LOOP AT T_EXC_MATT INTO S_EXC_MATT.
        CLEAR: S_EXC_MATC. " S_EXC_MATT
        S_EXC_MATC-ID_MATERIAL = S_EXC_MATT-ID_MATERIAL.
        S_EXC_MATC-DESCRIPCION = S_EXC_MATT-DESCRIPCION.
        S_EXC_MATC-COLOR = S_EXC_MATT-COLOR.
        S_EXC_MATC-ROLLOS = S_EXC_MATT-ROLLOS.
        S_EXC_MATC-ROLLOS_INCOMPLETOS = S_EXC_MATT-ROLLOS_INCOMPLETOS.
        S_EXC_MATC-PESO = S_EXC_MATT-PESO.
        APPEND S_EXC_MATC TO T_EXC_MATC.
      ENDLOOP.

      INSERT ZTC_MATERIALES FROM TABLE T_EXC_MATC.
      PERFORM LIMPIAR_EXCEL USING 'MEX'.
      LEAVE TO SCREEN 0.

    ELSE.
        MESSAGE 'No se encontraron registros.'TYPE 'I'..
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSERTAR_EXCEL_PRODUCTOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSERTAR_EXCEL_PRODUCTOS .

  SELECT ID_PRODUCTO
         DESCRIPCION
         COLOR
         TALLA
         EXISTENCIA
         PRECIO
   INTO CORRESPONDING FIELDS OF TABLE T_EXC_PROT
    FROM ZTE_PRODUCTOS.


    IF T_EXC_PROT IS NOT INITIAL.


      LOOP AT T_EXC_PROT INTO S_EXC_PROT.
        CLEAR: S_EXC_PROC. " S_EXC_PROT
        S_EXC_PROC-ID_PRODUCTO = S_EXC_PROT-ID_PRODUCTO.
        S_EXC_PROC-DESCRIPCION = S_EXC_PROT-DESCRIPCION.
        S_EXC_PROC-COLOR = S_EXC_PROT-COLOR.
        S_EXC_PROC-TALLA = S_EXC_PROT-TALLA.
        S_EXC_PROC-EXISTENCIA = S_EXC_PROT-EXISTENCIA.
        S_EXC_PROC-PRECIO = S_EXC_PROT-PRECIO.
        APPEND S_EXC_PROC TO T_EXC_PROC.
      ENDLOOP.

      INSERT ZTC_PRODUCTOS FROM TABLE T_EXC_PROC.
      PERFORM LIMPIAR_EXCEL USING 'PEX'.
      LEAVE TO SCREEN 0.

    ELSE.
        MESSAGE 'No se encontraron registros.'TYPE 'I'..
    ENDIF.

ENDFORM.
