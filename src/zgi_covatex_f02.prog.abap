*&---------------------------------------------------------------------*
*& Include          ZGI_COVATEX_F02
*&---------------------------------------------------------------------*
*------En este INCLUDE iran todo para msotrar tablas-------------
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
**&---------------------------------------------------------------------*
**************************************************************************************
*                                   SET_HANDLERS                                     *
**************************************************************************************

FORM SET_HANDLERS.

    IF GO_EVENT_RECEIVER IS NOT BOUND.

      CREATE OBJECT go_event_receiver.

      SET HANDLER: go_event_receiver->handle_hotspot_click FOR GALV_GRID_PROMAT.

    ENDIF.

ENDFORM.

FORM SET_HANDLERS_PRODUCTO.

  IF GO_EVENT_PRODUCTO IS NOT BOUND.

      CREATE OBJECT go_event_producto.

      SET HANDLER: go_event_producto->handle_hotspot_click_producto FOR GALV_GRID_PROMAT.

  ENDIF.

ENDFORM.

FORM SET_HANDLERS_MAQUILERO.

  IF GO_EVENT_MAQUILERO IS NOT BOUND.

      CREATE OBJECT go_event_maquilero.

      SET HANDLER: go_event_maquilero->handle_hotspot_click_maquilero FOR GALV_GRID_PROMAT.

  ENDIF.

ENDFORM.

FORM SET_HANDLERS_CLIENTE.

  IF GO_EVENT_CLIENTE IS NOT BOUND.

      CREATE OBJECT go_event_cliente.

      SET HANDLER: go_event_cliente->handle_hotspot_click_cliente FOR GALV_GRID_PROMAT.

  ENDIF.

ENDFORM.
FORM SET_HANDLERS_MATERIAL.

  IF GO_EVENT_MATERIAL IS NOT BOUND.

      CREATE OBJECT go_event_material.

      SET HANDLER: go_event_material->handle_hotspot_click_material FOR GALV_GRID_PROMAT.

  ENDIF.

ENDFORM.



**************************************************************************************
*                      SUBRUTINAS PARA CATALOGOS "PRINCIPALES"                       *
**************************************************************************************

"FORM PARA LIMPIAR LOS CONTENEDORES DE LAS DYNPROS"
FORM LIBERAR_CONT_PROMAT.

  IF C_CONTAINER_PROMAT IS BOUND.

      C_CONTAINER_PROMAT->free(
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          others            = 3
      ).
      IF SY-SUBRC <> 0.
       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      CLEAR C_CONTAINER_PROMAT.

      IF GALV_GRID_PROMAT IS BOUND.

        CLEAR GALV_GRID_PROMAT.

      ENDIF.

      IF GO_EVENT_RECEIVER IS BOUND.

        CLEAR GO_EVENT_RECEIVER.

      ENDIF.

      IF GO_EVENT_PRODUCTO IS BOUND.

        CLEAR GO_EVENT_PRODUCTO.

      ENDIF.

      IF GO_EVENT_MAQUILERO IS BOUND.

        CLEAR GO_EVENT_MAQUILERO.

      ENDIF.

      IF GO_EVENT_CLIENTE IS BOUND.

        CLEAR GO_EVENT_CLIENTE.

      ENDIF.

      IF GO_EVENT_MATERIAL IS BOUND.

        CLEAR GO_EVENT_MATERIAL.

      ENDIF.

     ENDIF.

ENDFORM.

"FORM PARA RECARGAR LAS TABLAS QUE SE MUESTRAN EN CADA DYNPRO"
FORM REFRESCAR_ALV_PROMAT.

  GALV_GRID_PROMAT->refresh_table_display(
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

"FORM PARA INSTANCIAR CONTENEDORES DE LAS DIFERENTES DYNPROS"
FORM INST_CONT_PROMAT USING TD.

  IF TD EQ 'PRO'.
    CREATE OBJECT c_container_promat
      EXPORTING
*        parent                      =
        container_name              = 'CG_PRODUCTOS'
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

  ELSEIF TD EQ 'MAT'.
    CREATE OBJECT c_container_promat
      EXPORTING
*        parent                      =
        container_name              = 'ALV_MAT'
*        style                       =
*        lifetime                    = lifetime_default
*        repid                       =
*        dynnr                       =
*        no_autodef_progid_dynnr     =
*      EXCEPTIONS
*        cntl_error                  = 1
*        cntl_system_error           = 2
*        create_error                = 3
*        lifetime_error              = 4
*        lifetime_dynpro_dynpro_link = 5
*        others                      = 6
      .
    IF SY-SUBRC <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    ELSEIF TD EQ 'PROV'.
    CREATE OBJECT c_container_promat
      EXPORTING
*        parent                      =
        container_name              = 'CG_PROVEEDORES'
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

    ELSEIF TD EQ 'MAQ'.
    CREATE OBJECT c_container_promat
      EXPORTING
*        parent                      =
        container_name              = 'C_MAQUILEROS'
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

    ELSEIF TD EQ 'CLI'.
    CREATE OBJECT c_container_promat
      EXPORTING
*        parent                      =
        container_name              = 'CG_CLIENTES'
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

"FORM PARA MOSTRAR ALV DE LAS DIFERENTES DYNPROS"
FORM BUILD_FIELDCAT_PROMAT USING TD.

  IF TD EQ 'PRO'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_PRODUCTOS'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_PRO
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_PRO ASSIGNING <LS_FIELDCAT_PROMAT>.
        CASE <LS_FIELDCAT_PROMAT>-fieldname .
          WHEN 'ID_PRODUCTO'.
            <LS_FIELDCAT_PROMAT>-hotspot = ABAP_TRUE.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF TD EQ 'MAT'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_MATERIALES'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_MAT2
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_MAT2 ASSIGNING <LS_FIELDCAT_PROMAT>.
        CASE <LS_FIELDCAT_PROMAT>-fieldname .
          WHEN 'ID_MATERIAL'.
            <LS_FIELDCAT_PROMAT>-hotspot = ABAP_TRUE.
          WHEN OTHERS.
        ENDCASE.

      ENDLOOP.
    ENDIF.

  ELSEIF TD EQ 'PROV'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_PROVEEDORES'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_PROV
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_PROV ASSIGNING <LS_FIELDCAT_PROMAT>.
        CASE <LS_FIELDCAT_PROMAT>-fieldname .
          WHEN 'ID_PROVEEDOR'.
            <LS_FIELDCAT_PROMAT>-hotspot = ABAP_TRUE.
          WHEN 'ID_PROVEEDOR' OR 'NOMBRE' OR 'APELLIDO_PATERNO' OR 'APELLIDO_MATERNO' OR 'TELEFONO1' OR 'EMAIL'.
          WHEN OTHERS.
            <LS_FIELDCAT_PROMAT>-no_out = ABAP_TRUE.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF TD EQ 'MAQ'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_EMPLEADOS'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_MAQ
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_MAQ ASSIGNING <LS_FIELDCAT_PROMAT>.
        CASE <LS_FIELDCAT_PROMAT>-fieldname .
          WHEN 'ID_EMPLEADO'.
            <LS_FIELDCAT_PROMAT>-hotspot = ABAP_TRUE.
          WHEN 'ID_EMPLEADO' OR 'NOMBRE' OR 'APELLIDO_PATERNO' OR 'APELLIDO_MATERNO' OR 'TELEFONO1' OR 'EMAIL'.
          WHEN OTHERS.
            <LS_FIELDCAT_PROMAT>-no_out = ABAP_TRUE.
        ENDCASE.

      ENDLOOP.
    ENDIF.

  ELSEIF TD EQ 'CLI'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_CLIENTES'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_CLI
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
" Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_CLI ASSIGNING <LS_FIELDCAT_PROMAT>.
        CASE <LS_FIELDCAT_PROMAT>-fieldname .
          WHEN 'ID_CLIENTE'.
            <LS_FIELDCAT_PROMAT>-hotspot = ABAP_TRUE.
          WHEN 'ID_PROVEEDOR' OR 'NOMBRE' OR 'APELLIDO_PATERNO' OR 'APELLIDO_MATERNO' OR 'TELEFONO1' OR 'EMAIL'.
          WHEN OTHERS.
            <LS_FIELDCAT_PROMAT>-no_out = ABAP_TRUE.
        ENDCASE.

      ENDLOOP.
    ENDIF.

  ENDIF.

ENDFORM.

"FORM PARA OBTENER LOS DATOS EN DYNPROS"
FORM GET_DATA_PROMAT USING TD.

  IF TD EQ 'PRO'.
    SELECT * FROM ZTC_PRODUCTOS
      INTO CORRESPONDING FIELDS OF TABLE GT_PRO.

  ELSEIF TD EQ 'MAT'.
    SELECT * FROM ZTC_MATERIALES
      INTO CORRESPONDING FIELDS OF TABLE GT_MAT2.

  ELSEIF TD EQ 'PROV'.
      SELECT * FROM ZTC_PROVEEDORES
      INTO CORRESPONDING FIELDS OF TABLE GT_PROV2.

  ELSEIF TD EQ 'MAQ'.
    SELECT * FROM ZTC_EMPLEADOS
      INTO CORRESPONDING FIELDS OF TABLE GT_MAQ.

  ELSEIF TD EQ 'CLI'.
    SELECT * FROM ZTC_CLIENTES
      INTO CORRESPONDING FIELDS OF TABLE GT_CLI.

  ENDIF.

ENDFORM.

"FORM PARA INSTANCIAR EL ALV DE PRODUCTOS"
FORM INSTANCE_ALV_PRO.

  CREATE OBJECT galv_grid_promat
    EXPORTING
      i_parent                = C_CONTAINER_PROMAT
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

"FORM PARA INSTANCIAR EL ALV DE MATERIALES"
FORM INSTANCE_ALV_MAT.

  CREATE OBJECT galv_grid_promat
    EXPORTING
      i_parent                = C_CONTAINER_PROMAT
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

"FORM PARA INSTANCIAR EL ALV DE PROVEEDORES"
FORM INSTANCE_ALV_PROV2.

  CREATE OBJECT galv_grid_promat
    EXPORTING
      i_parent                = C_CONTAINER_PROMAT
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

"FORM PARA INSTANCIAR EL ALV DE MAQUILEROS"
FORM INSTANCE_ALV_MAQ.

  CREATE OBJECT galv_grid_promat
    EXPORTING
      i_parent                = C_CONTAINER_PROMAT
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

"FORM PARA INSTANCIAR EL ALV DE CLIENTES"
FORM INSTANCE_ALV_CLI.

  CREATE OBJECT galv_grid_promat
    EXPORTING
      i_parent                = C_CONTAINER_PROMAT
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

"FORM PARA CONSTRUIR EL LAYOUT DE LAS DYNPROS"
FORM BUILD_LAYOUT_PROMAT USING TD.

  IF TD EQ 'PRO'.

    GS_LAYOUT_PROMAT-zebra = ABAP_TRUE.
    GS_LAYOUT_PROMAT-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_PROMAT-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_PRO ASSIGNING <LS_FIELDCAT_PROMAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_PRO ASSIGNING <LS_PRO>.

        LS_STYLE_PROMAT-fieldname = <LS_FIELDCAT_PROMAT>-fieldname.
        LS_STYLE_PROMAT-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_PROMAT INTO TABLE <LS_PRO>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF TD EQ 'MAT'.

    GS_LAYOUT_PROMAT-zebra = ABAP_TRUE.
    GS_LAYOUT_PROMAT-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_PROMAT-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_MAT2 ASSIGNING <LS_FIELDCAT_PROMAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_MAT2 ASSIGNING <LS_MAT>.

        LS_STYLE_PROMAT-fieldname = <LS_FIELDCAT_PROMAT>-fieldname.
        LS_STYLE_PROMAT-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_PROMAT INTO TABLE <LS_MAT>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF TD EQ 'PROV'.

    GS_LAYOUT_PROMAT-zebra = ABAP_TRUE.
    GS_LAYOUT_PROMAT-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_PROMAT-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_PROV ASSIGNING <LS_FIELDCAT_PROMAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_PROV2 ASSIGNING <LS_PROV>.

        LS_STYLE_PROMAT-fieldname = <LS_FIELDCAT_PROMAT>-fieldname.
        LS_STYLE_PROMAT-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_PROMAT INTO TABLE <LS_PROV>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF TD EQ 'MAQ'.

    GS_LAYOUT_PROMAT-zebra = ABAP_TRUE.
    GS_LAYOUT_PROMAT-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_PROMAT-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_MAQ ASSIGNING <LS_FIELDCAT_PROMAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_MAQ ASSIGNING <LS_MAQ>.

        LS_STYLE_PROMAT-fieldname = <LS_FIELDCAT_PROMAT>-fieldname.
        LS_STYLE_PROMAT-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_PROMAT INTO TABLE <LS_MAQ>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF TD EQ 'CLI'.

    GS_LAYOUT_PROMAT-zebra = ABAP_TRUE.
    GS_LAYOUT_PROMAT-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_PROMAT-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_CLI ASSIGNING <LS_FIELDCAT_PROMAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_CLI ASSIGNING <LS_CLI>.

        LS_STYLE_PROMAT-fieldname = <LS_FIELDCAT_PROMAT>-fieldname.
        LS_STYLE_PROMAT-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_PROMAT INTO TABLE <LS_CLI>-field_style.

      ENDLOOP.

    ENDLOOP.

  ENDIF.

ENDFORM.

"FORM PARA MOSTRAR EL ALV EN LAS DYNPROS"
FORM DISPLAY_ALV_PROMAT USING TD.

  DATA: LT_S2 TYPE LVC_T_SORT,
        LS_S2 TYPE LVC_S_SORT.

  IF TD EQ 'PRO'.
    LS_S2-fieldname = 'ID_PRODUCTO'.
    LS_S2-up = ABAP_TRUE.

    APPEND LS_S2 TO LT_S2.


    galv_grid_promat->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_PROMAT
      CHANGING
        it_outtab                     = GT_PRO
        it_fieldcatalog               = GT_FIELDCAT_PRO
        it_sort                       = LT_S2
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

  ELSEIF TD EQ 'MAT'.
    LS_S2-fieldname = 'ID_MATERIAL'.
    LS_S2-up = ABAP_TRUE.

    APPEND LS_S2 TO LT_S2.


    galv_grid_promat->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_PROMAT
      CHANGING
        it_outtab                     = GT_MAT2
        it_fieldcatalog               = GT_FIELDCAT_MAT2
        it_sort                       = LT_S2
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

  ELSEIF TD EQ 'PROV'.
    LS_S2-fieldname = 'ID_PROVEEDOR'.
    LS_S2-up = ABAP_TRUE.

    APPEND LS_S2 TO LT_S2.


    galv_grid_promat->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_PROMAT
      CHANGING
        it_outtab                     = GT_PROV2
        it_fieldcatalog               = GT_FIELDCAT_PROV
        it_sort                       = LT_S2
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

  ELSEIF TD EQ 'MAQ'.
    LS_S2-fieldname = 'ID_EMPLEADO'.
    LS_S2-up = ABAP_TRUE.

    APPEND LS_S2 TO LT_S2.


    galv_grid_promat->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_PROMAT
      CHANGING
        it_outtab                     = GT_MAQ
        it_fieldcatalog               = GT_FIELDCAT_MAQ
        it_sort                       = LT_S2
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

  ELSEIF TD EQ 'CLI'.
    LS_S2-fieldname = 'ID_CLIENTE'.
    LS_S2-up = ABAP_TRUE.

    APPEND LS_S2 TO LT_S2.


    galv_grid_promat->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_PROMAT
      CHANGING
        it_outtab                     = GT_CLI
        it_fieldcatalog               = GT_FIELDCAT_CLI
        it_sort                       = LT_S2
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

FORM CONTAINERS_PROMAT USING TD.

  PERFORM LIBERAR_CONT_PROMAT.

  IF TD EQ 'PRO'.

    IF NOT C_CONTAINER_PROMAT IS BOUND.

      PERFORM INST_CONT_PROMAT USING 'PRO'.
      PERFORM BUILD_FIELDCAT_PROMAT USING 'PRO'.
      PERFORM GET_DATA_PROMAT USING 'PRO'.
      PERFORM INSTANCE_ALV_PRO.
      PERFORM BUILD_LAYOUT_PROMAT USING 'PRO'.
      PERFORM SET_HANDLERS_PRODUCTO.
      PERFORM DISPLAY_ALV_PROMAT USING 'PRO'.

    ELSE.

      PERFORM REFRESCAR_ALV_PROMAT.

    ENDIF.

  ELSEIF TD EQ 'MAT'.

    IF NOT C_CONTAINER_PROMAT IS BOUND.

      PERFORM INST_CONT_PROMAT USING 'MAT'.
      PERFORM BUILD_FIELDCAT_PROMAT USING 'MAT'.
      PERFORM GET_DATA_PROMAT USING 'MAT'.
      PERFORM INSTANCE_ALV_MAT.
      PERFORM BUILD_LAYOUT_PROMAT USING 'MAT'.
      PERFORM SET_HANDLERS_MATERIAL.
      PERFORM DISPLAY_ALV_PROMAT USING 'MAT'.

    ELSE.

      PERFORM REFRESCAR_ALV_PROMAT.

    ENDIF.

  ELSEIF TD EQ 'PROV'.

    IF C_CONTAINER_PROMAT IS NOT BOUND.

      PERFORM INST_CONT_PROMAT USING 'PROV'.
      PERFORM BUILD_FIELDCAT_PROMAT USING 'PROV'.
      PERFORM GET_DATA_PROMAT USING 'PROV'.
      PERFORM INSTANCE_ALV_PROV2.
      PERFORM BUILD_LAYOUT_PROMAT USING 'PROV'.
      PERFORM SET_HANDLERS.
      PERFORM DISPLAY_ALV_PROMAT USING 'PROV'.

    ELSE.

      PERFORM REFRESCAR_ALV_PROMAT.

    ENDIF.

  ELSEIF TD EQ 'MAQ'.

    IF NOT C_CONTAINER_PROMAT IS BOUND.

      PERFORM INST_CONT_PROMAT USING 'MAQ'.
      PERFORM BUILD_FIELDCAT_PROMAT USING 'MAQ'.
      PERFORM GET_DATA_PROMAT USING 'MAQ'.
      PERFORM INSTANCE_ALV_MAQ.
      PERFORM BUILD_LAYOUT_PROMAT USING 'MAQ'.
      PERFORM SET_HANDLERS_MAQUILERO.
      PERFORM DISPLAY_ALV_PROMAT USING 'MAQ'.

    ELSE.

      PERFORM REFRESCAR_ALV_PROMAT.

    ENDIF.

  ELSEIF TD EQ 'CLI'.

    IF NOT C_CONTAINER_PROMAT IS BOUND.

      PERFORM INST_CONT_PROMAT USING 'CLI'.
      PERFORM BUILD_FIELDCAT_PROMAT USING 'CLI'.
      PERFORM GET_DATA_PROMAT USING 'CLI'.
      PERFORM INSTANCE_ALV_CLI.
      PERFORM BUILD_LAYOUT_PROMAT USING 'CLI'.
      PERFORM SET_HANDLERS_CLIENTE.
      PERFORM DISPLAY_ALV_PROMAT USING 'CLI'.

    ELSE.

      PERFORM REFRESCAR_ALV_PROMAT.

    ENDIF.

  ENDIF.

ENDFORM.

*& Form INIT_4001
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4001 .

*    PERFORM actualizar_materiales.
  PERFORM CONTAINERS_PROMAT USING 'MAT'.

ENDFORM.
*& Form init_4002
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4002 ."Displays de la tabla productos

*    PERFORM actualizar_tab_productos.
  PERFORM CONTAINERS_PROMAT USING 'PRO'.

ENDFORM.
*& Form INIT_4004
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4004 .

      PERFORM CONTAINERS_PROMAT USING 'PROV'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4005
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4005 .

  PERFORM CONTAINERS_PROMAT USING 'MAQ'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4006
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4006 .

  PERFORM CONTAINERS_PROMAT USING 'CLI'.

ENDFORM.

**************************************************************************************
*                      SUBRUTINAS PARA LA SECCION DE MOVIMIENTOS                     *
**************************************************************************************

FORM SET_HANDLER_EP.

    IF GO_EVENT_VIEP IS NOT BOUND.

      CREATE OBJECT GO_EVENT_VIEP.

      SET HANDLER: GO_EVENT_VIEP->handle_hotspot_click_ep FOR galv_grid2.

    ENDIF.

ENDFORM.

FORM SET_HANDLER_EM.

    IF GO_EVENT_VIEM IS NOT BOUND.

      CREATE OBJECT GO_EVENT_VIEM.

      SET HANDLER: GO_EVENT_VIEM->handle_hotspot_click_em FOR galv_grid2.

    ENDIF.

ENDFORM.

FORM SET_HANDLER_SP.

    IF GO_EVENT_VISP IS NOT BOUND.

      CREATE OBJECT GO_EVENT_VISP.

      SET HANDLER: GO_EVENT_VISP->handle_hotspot_click_sp FOR galv_grid2.

    ENDIF.

ENDFORM.

FORM SET_HANDLER_SM.

    IF GO_EVENT_VISM IS NOT BOUND.

      CREATE OBJECT GO_EVENT_VISM.

      SET HANDLER: GO_EVENT_VISM->handle_hotspot_click_sm FOR galv_grid2.

    ENDIF.

ENDFORM.

"FORM PARA LIMPIAR LOS CONTENEDORES QUE MUESTRAN LAS TABLAS EN CADA PESTAÑA DEL TABSTIP"
FORM LIBERAR_CONT_MOVIMIENTOS.

  IF c_container2 IS BOUND.

      c_container2->free(
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          others            = 3
      ).
      IF SY-SUBRC <> 0.
       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      CLEAR c_container2.

      IF galv_grid2 IS BOUND.

        CLEAR galv_grid2.

      ENDIF.

      IF GO_EVENT_VIEP IS BOUND.

        CLEAR GO_EVENT_VIEP.

      ENDIF.

      IF GO_EVENT_VIEM IS BOUND.

        CLEAR GO_EVENT_VIEM.

      ENDIF.

      IF GO_EVENT_VISP IS BOUND.

        CLEAR GO_EVENT_VISP.

      ENDIF.

      IF GO_EVENT_VISM IS BOUND.

        CLEAR GO_EVENT_VISM.

      ENDIF.


     ENDIF.

ENDFORM.

"FORM PARA RECARGAR LAS TABLAS QUE SE MUESTRAN EN CADA PESTAÑA DEL TABSTRIP"
FORM REFRESCAR_ALV_MOVIMIENTOS.

  galv_grid2->refresh_table_display(
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

"FORM PARA INSTANCIAR EL CONTENEDOR DE LOS MOVIMIENTOS"
FORM INSTANCE_CONT_MOVIMIENTOS USING TM.

  IF TM EQ 'EP'.
    CREATE OBJECT c_container2
      EXPORTING
*        parent                      =
        container_name              = 'C_EP'
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

  ELSEIF TM EQ 'EM'.
    CREATE OBJECT c_container2
      EXPORTING
*        parent                      =
        container_name              = 'C_EM'
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

  ELSEIF TM EQ 'SP'.
    CREATE OBJECT c_container2
      EXPORTING
*        parent                      =
        container_name              = 'C_SP'
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

  ELSEIF TM EQ 'SM'.
    CREATE OBJECT c_container2
      EXPORTING
*        parent                      =
        container_name              = 'C_SM'
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

"FORM PARA MOSTRAR ALV DE LOS MOVIMIENTOS"
FORM BUILD_FIELCAT_MOVIMIENTOS USING TM.

  IF TM EQ 'EP'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_ENT_PRODUCTO'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCATEP
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCATEP ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname .
          WHEN 'ID_EMPLEADO'.
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
          WHEN 'FOLIO_ENT_PRO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 1.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'NOMBRE'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 2.
          WHEN 'APELLIDO_PATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 3.
          WHEN 'APELLIDO_MATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 4.
          WHEN 'FOLIO_SAL_MAT'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 5.
          WHEN 'FECHA_ENTRADA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 6.
          WHEN 'ALMACENISTA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 7.
          WHEN 'PESO_TOTAL'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 8.
          WHEN 'MERMA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 9.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF TM EQ 'EM'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_ENT_MATERIAL'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCATEM
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCATEM ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname .
          WHEN 'ID_PROVEEDOR'.
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
          WHEN 'FOLIO_ENT_MAT'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 1.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'NOMBRE'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 2.
          WHEN 'APELLIDO_PATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 3.
          WHEN 'APELLIDO_MATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 4.
          WHEN 'FECHA_ENTRADA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 5.
          WHEN 'ALMACENISTA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 6.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF TM EQ 'SP'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_SAL_PRODUCTO'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCATSP
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCATSP ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname .
          WHEN 'ID_CLIENTE'.
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
          WHEN 'FOLIO_SAL_PRO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 1.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'NOMBRE'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 2.
          WHEN 'APELLIDO_PATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 3.
          WHEN 'APELLIDO_MATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 4.
          WHEN 'FECHA_SALIDA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 5.
          WHEN 'ALMACENISTA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 6.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF TM EQ 'SM'.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_SAL_MATERIAL'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCATSM
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCATSM ASSIGNING <LS_FIELDCAT_ENT_SAL>.
        CASE <LS_FIELDCAT_ENT_SAL>-fieldname .
          WHEN 'ID_EMPLEADO'.
            <LS_FIELDCAT_ENT_SAL>-no_out = ABAP_TRUE.
          WHEN 'FOLIO_SAL_MAT'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 1.
            <LS_FIELDCAT_ENT_SAL>-hotspot = ABAP_TRUE.
          WHEN 'NOMBRE'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 2.
          WHEN 'APELLIDO_PATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 3.
          WHEN 'APELLIDO_MATERNO'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 4.
          WHEN 'FECHA_SALIDA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 5.
          WHEN 'ALMACENISTA'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 6.
          WHEN 'ESTATUS'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 7.
          WHEN 'PESO_TOTAL'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 8.
          WHEN 'PESO_RESTANTE'.
            <LS_FIELDCAT_ENT_SAL>-col_pos = 9.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ENDIF.

ENDFORM.

"FORM PARA OBTENER DATOS DE LOS MOVIMIENTOS CON RANGOS"
FORM GET_DATA_MOVIMIENTOS USING TM.

  IF TM EQ 'EM'.

    IF SY-UCOMM = 'BTN_BEM'.

      IF NOT ZTC_BUSQUEDA-FECHA_DESDE EQ 00000000 AND NOT ZTC_BUSQUEDA-FECHA_HASTA EQ 00000000.
*        ztc_busqueda-fecha_desde <= ztc_busqueda-fecha_hasta OR
*       ztc_busqueda-fecha_desde EQ '' AND ztc_busqueda-fecha_hasta IS INITIAL.

           SELECT a~FOLIO_ENT_MAT
                  a~ID_PROVEEDOR
                  a~FECHA_ENTRADA
                  a~ALMACENISTA
                  b~NOMBRE
                  b~APELLIDO_PATERNO
                  b~APELLIDO_MATERNO
             INTO CORRESPONDING FIELDS OF TABLE GT_EM_MOVIMIENTOS
             FROM ZTC_ENT_MATERIAL AS A
                  INNER JOIN ZTC_PROVEEDORES AS B
                        ON B~ID_PROVEEDOR EQ A~ID_PROVEEDOR
             WHERE fecha_entrada BETWEEN ZTC_BUSQUEDA-fecha_desde AND ZTC_BUSQUEDA-fecha_hasta.

        CLEAR: OK_CODE_4007.

      ELSEIF NOT ZTC_ENT_MATERIAL-FOLIO_ENT_MAT EQ ''.

        SELECT a~FOLIO_ENT_MAT
               a~ID_PROVEEDOR
               a~FECHA_ENTRADA
               a~ALMACENISTA
               b~NOMBRE
               b~APELLIDO_PATERNO
               b~APELLIDO_MATERNO
          INTO CORRESPONDING FIELDS OF TABLE GT_EM_MOVIMIENTOS
          FROM ZTC_ENT_MATERIAL AS A
               INNER JOIN ZTC_PROVEEDORES AS B
                     ON B~ID_PROVEEDOR EQ A~ID_PROVEEDOR
        WHERE FOLIO_ENT_MAT = ZTC_ENT_MATERIAL-FOLIO_ENT_MAT.

        CLEAR: OK_CODE_4007.

      ELSE.

        MESSAGE 'NO SE PUEDE' TYPE 'I'. "Aqui deberia de ir un mensaje de comprobacion

        CLEAR: OK_CODE_4007.

      ENDIF.

    ELSE.

      SELECT a~FOLIO_ENT_MAT
             a~ID_PROVEEDOR
             a~FECHA_ENTRADA
             a~ALMACENISTA
             b~NOMBRE
             b~APELLIDO_PATERNO
             b~APELLIDO_MATERNO
        INTO CORRESPONDING FIELDS OF TABLE GT_EM_MOVIMIENTOS
        FROM ZTC_ENT_MATERIAL AS A
             INNER JOIN ZTC_PROVEEDORES AS B
                   ON B~ID_PROVEEDOR EQ A~ID_PROVEEDOR.

    ENDIF.

  ELSEIF TM EQ 'EP'.

    IF SY-UCOMM = 'BTN_BEP'.

      IF NOT ZTC_BUSQUEDA-FECHA_DESDE EQ 00000000 AND NOT ZTC_BUSQUEDA-FECHA_HASTA EQ 00000000.
*        ztc_busqueda-fecha_desde <= ztc_busqueda-fecha_hasta OR
*       ztc_busqueda-fecha_desde EQ '' AND ztc_busqueda-fecha_hasta IS INITIAL.

        SELECT a~FOLIO_ENT_PRO
               a~ID_EMPLEADO
               a~FOLIO_SAL_MAT
               a~FECHA_ENTRADA
               a~ALMACENISTA
               a~PESO_TOTAL
               a~MERMA
               b~NOMBRE
               b~APELLIDO_PATERNO
               b~APELLIDO_MATERNO
          INTO CORRESPONDING FIELDS OF TABLE GT_EP_MOVIMIENTOS
          FROM ZTC_ENT_PRODUCTO AS A
               INNER JOIN ZTC_EMPLEADOS AS B
                     ON B~ID_EMPLEADO EQ A~ID_EMPLEADO
        WHERE fecha_entrada BETWEEN ZTC_BUSQUEDA-fecha_desde AND ZTC_BUSQUEDA-fecha_hasta.

        CLEAR: OK_CODE_4007.

      ELSEIF NOT ZTC_ENT_PRODUCTO-FOLIO_ENT_PRO EQ ''.

        SELECT a~FOLIO_ENT_PRO
               a~ID_EMPLEADO
               a~FOLIO_SAL_MAT
               a~FECHA_ENTRADA
               a~ALMACENISTA
               a~PESO_TOTAL
               a~MERMA
               b~NOMBRE
               b~APELLIDO_PATERNO
               b~APELLIDO_MATERNO
          INTO CORRESPONDING FIELDS OF TABLE GT_EP_MOVIMIENTOS
          FROM ZTC_ENT_PRODUCTO AS A
               INNER JOIN ZTC_EMPLEADOS AS B
                     ON B~ID_EMPLEADO EQ A~ID_EMPLEADO
        WHERE FOLIO_ENT_PRO = ZTC_ENT_PRODUCTO-FOLIO_ENT_PRO.

        CLEAR: OK_CODE_4007.

      ELSE.

        MESSAGE 'NO SE PUEDE' TYPE 'I'. "Aqui deberia de ir un mensaje de comprobacion

        CLEAR: OK_CODE_4007.

      ENDIF.

    ELSE.

    SELECT a~FOLIO_ENT_PRO
           a~ID_EMPLEADO
           a~FOLIO_SAL_MAT
           a~FECHA_ENTRADA
           a~ALMACENISTA
           a~PESO_TOTAL
           a~MERMA
           b~NOMBRE
           b~APELLIDO_PATERNO
           b~APELLIDO_MATERNO
      INTO CORRESPONDING FIELDS OF TABLE GT_EP_MOVIMIENTOS
      FROM ZTC_ENT_PRODUCTO AS A
           INNER JOIN ZTC_EMPLEADOS AS B
                 ON B~ID_EMPLEADO EQ A~ID_EMPLEADO.

    ENDIF.

  ELSEIF TM EQ 'SM'.

    IF SY-UCOMM = 'BTN_BEM'.

    IF NOT ZTC_BUSQUEDA-FECHA_DESDE EQ 00000000 AND NOT ZTC_BUSQUEDA-FECHA_HASTA EQ 00000000.
*        ztc_busqueda-fecha_desde <= ztc_busqueda-fecha_hasta OR
*       ztc_busqueda-fecha_desde EQ '' AND ztc_busqueda-fecha_hasta IS INITIAL.
        SELECT a~FOLIO_SAL_MAT
               a~ID_EMPLEADO
               a~FECHA_SALIDA
               a~ALMACENISTA
               a~ESTATUS
               a~PESO_TOTAL
               a~PESO_RESTANTE
               b~NOMBRE
               b~APELLIDO_PATERNO
               b~APELLIDO_MATERNO
          INTO CORRESPONDING FIELDS OF TABLE GT_SM_MOVIMIENTOS
          FROM ZTC_SAL_MATERIAL AS A
             INNER JOIN ZTC_EMPLEADOS AS B
                   ON B~ID_EMPLEADO EQ A~ID_EMPLEADO
        WHERE fecha_salida BETWEEN ZTC_BUSQUEDA-fecha_desde AND ZTC_BUSQUEDA-fecha_hasta.

        CLEAR: OK_CODE_4007.

      ELSEIF NOT ZTC_SAL_MATERIAL-FOLIO_SAL_MAT EQ ''.

        SELECT a~FOLIO_SAL_MAT
               a~ID_EMPLEADO
               a~FECHA_SALIDA
               a~ALMACENISTA
               a~ESTATUS
               a~PESO_TOTAL
               a~PESO_RESTANTE
               b~NOMBRE
               b~APELLIDO_PATERNO
               b~APELLIDO_MATERNO
          INTO CORRESPONDING FIELDS OF TABLE GT_SM_MOVIMIENTOS
          FROM ZTC_SAL_MATERIAL AS A
             INNER JOIN ZTC_EMPLEADOS AS B
                   ON B~ID_EMPLEADO EQ A~ID_EMPLEADO
        WHERE FOLIO_SAL_MAT = ZTC_SAL_MATERIAL-FOLIO_SAL_MAT.

        CLEAR: OK_CODE_4007.

      ELSE.

        MESSAGE 'NO SE PUEDE' TYPE 'I'. "Aqui deberia de ir un mensaje de comprobacion

        CLEAR: OK_CODE_4007.

      ENDIF.

    ELSE.

      SELECT a~FOLIO_SAL_MAT
             a~ID_EMPLEADO
             a~FECHA_SALIDA
             a~ALMACENISTA
             a~ESTATUS
             a~PESO_TOTAL
             a~PESO_RESTANTE
             b~NOMBRE
             b~APELLIDO_PATERNO
             b~APELLIDO_MATERNO
        INTO CORRESPONDING FIELDS OF TABLE GT_SM_MOVIMIENTOS
        FROM ZTC_SAL_MATERIAL AS A
             INNER JOIN ZTC_EMPLEADOS AS B
                   ON B~ID_EMPLEADO EQ A~ID_EMPLEADO.

    ENDIF.

  ELSEIF TM EQ 'SP'.

    IF SY-UCOMM = 'BTN_BSP'.

      IF NOT ZTC_BUSQUEDA-FECHA_DESDE EQ 00000000 AND NOT ZTC_BUSQUEDA-FECHA_HASTA EQ 00000000.
*        ztc_busqueda-fecha_desde <= ztc_busqueda-fecha_hasta OR
*       ztc_busqueda-fecha_desde EQ '' AND ztc_busqueda-fecha_hasta IS INITIAL.

        SELECT a~FOLIO_SAL_PRO
               a~ID_CLIENTE
               a~FECHA_SALIDA
               a~ALMACENISTA
               b~NOMBRE
               b~APELLIDO_PATERNO
               b~APELLIDO_MATERNO
          INTO CORRESPONDING FIELDS OF TABLE GT_SP_MOVIMIENTOS
          FROM ZTC_SAL_PRODUCTO AS A
               INNER JOIN ZTC_CLIENTES AS B
                     ON B~ID_CLIENTE EQ A~ID_CLIENTE
        WHERE fecha_salida BETWEEN ZTC_BUSQUEDA-fecha_desde AND ZTC_BUSQUEDA-fecha_hasta.

        CLEAR: OK_CODE_4007.

      ELSEIF NOT ZTC_SAL_PRODUCTO-FOLIO_SAL_PRO EQ ''.

        SELECT a~FOLIO_SAL_PRO
               a~ID_CLIENTE
               a~FECHA_SALIDA
               a~ALMACENISTA
               b~NOMBRE
               b~APELLIDO_PATERNO
               b~APELLIDO_MATERNO
          INTO CORRESPONDING FIELDS OF TABLE GT_SP_MOVIMIENTOS
          FROM ZTC_SAL_PRODUCTO AS A
               INNER JOIN ZTC_CLIENTES AS B
                     ON B~ID_CLIENTE EQ A~ID_CLIENTE
        WHERE FOLIO_SAL_PRO = ZTC_SAL_PRODUCTO-FOLIO_SAL_PRO.

        CLEAR: OK_CODE_4007.

      ELSE.

        MESSAGE 'NO SE PUEDE' TYPE 'I'. "Aqui deberia de ir un mensaje de comprobacion

        CLEAR: OK_CODE_4007.

      ENDIF.

    ELSE.

      SELECT a~FOLIO_SAL_PRO
             a~ID_CLIENTE
             a~FECHA_SALIDA
             a~ALMACENISTA
             b~NOMBRE
             b~APELLIDO_PATERNO
             b~APELLIDO_MATERNO
        INTO CORRESPONDING FIELDS OF TABLE GT_SP_MOVIMIENTOS
        FROM ZTC_SAL_PRODUCTO AS A
             INNER JOIN ZTC_CLIENTES AS B
                   ON B~ID_CLIENTE EQ A~ID_CLIENTE.

    ENDIF.

  ENDIF.

ENDFORM.

"FORM PARA INSTANCIAR EL ALV EN LA ENTRADA DE MATERIALES"
FORM INSTANCE_ALV_EM.

  CREATE OBJECT galv_grid2
    EXPORTING
      i_parent                = C_CONTAINER2
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

"FORM PARA INSTANCIAR EL ALV EN LA ENTRADA DE PRODUCTOS"
FORM INSTANCE_ALV_EP.

  CREATE OBJECT galv_grid2
    EXPORTING
      i_parent                = C_CONTAINER2
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

"FORM PARA INSTANCIAR EL ALV EN LA SALIDA DE MATERIALES"
FORM INSTANCE_ALV_SM.

  CREATE OBJECT galv_grid2
    EXPORTING
      i_parent                = C_CONTAINER2
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

"FORM PARA INSTANCIAR EL ALV EN LA SALIDA DE PRODUCTOS"
FORM INSTANCE_ALV_SP.

  CREATE OBJECT galv_grid2
    EXPORTING
      i_parent                = C_CONTAINER2
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

"FORM PARA CONSTRUIR EL LAYOUT DE LAS ENTRADAS Y SALIDAS"
FORM BUILD_LAYOUT_MOVIMIENTOS USING TM.

  IF TM EQ 'EM'.
    FIELD-SYMBOLS <LS_EM> TYPE GTY_EM_MOVIMIENTOS.

    GS_LAYO-zebra = ABAP_TRUE.
    GS_LAYO-stylefname = 'FIELD_STYLE'.
    GS_LAYO-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCATEM ASSIGNING <LS_FIELDCAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_EM_MOVIMIENTOS ASSIGNING <LS_EM>.

        LS_STYLE-fieldname = <LS_FIELDCAT>-fieldname.
        LS_STYLE-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE INTO TABLE <LS_EM>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF TM EQ 'EP'.
    FIELD-SYMBOLS <LS_EP> TYPE GTY_EP_MOVIMIENTOS.

    GS_LAYO-zebra = ABAP_TRUE.
    GS_LAYO-stylefname = 'FIELD_STYLE'.
    GS_LAYO-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCATEP ASSIGNING <LS_FIELDCAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_EP_MOVIMIENTOS ASSIGNING <LS_EP>.

        LS_STYLE-fieldname = <LS_FIELDCAT>-fieldname.
        LS_STYLE-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE INTO TABLE <LS_EP>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF TM EQ 'SM'.
    FIELD-SYMBOLS <LS_SM> TYPE GTY_SM_MOVIMIENTOS.

    GS_LAYO-zebra = ABAP_TRUE.
    GS_LAYO-stylefname = 'FIELD_STYLE'.
    GS_LAYO-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCATSM ASSIGNING <LS_FIELDCAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_SM_MOVIMIENTOS ASSIGNING <LS_SM>.

        LS_STYLE-fieldname = <LS_FIELDCAT>-fieldname.
        LS_STYLE-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE INTO TABLE <LS_SM>-field_style.

      ENDLOOP.

    ENDLOOP.

  ELSEIF TM EQ 'SP'.
    FIELD-SYMBOLS <LS_SP> TYPE GTY_SP_MOVIMIENTOS.

    GS_LAYO-zebra = ABAP_TRUE.
    GS_LAYO-stylefname = 'FIELD_STYLE'.
    GS_LAYO-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCATSP ASSIGNING <LS_FIELDCAT> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_SP_MOVIMIENTOS ASSIGNING <LS_SP>.

        LS_STYLE-fieldname = <LS_FIELDCAT>-fieldname.
        LS_STYLE-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE INTO TABLE <LS_SP>-field_style.

      ENDLOOP.

    ENDLOOP.

  ENDIF.

ENDFORM.

"FORM PARA MOSTRAR EL ALV EN LAS PESTAÑAS DE LOS MOVIMIENTOS"
FORM DISPLAY_ALV_MOVIMIENTOS USING TM.

  DATA: LT_S TYPE LVC_T_SORT,
        LS_S TYPE LVC_S_SORT.

  IF TM EQ 'EM'.

    LS_S-fieldname = 'FOLIO_ENT_MAT'.
    LS_S-up = ABAP_TRUE.

    APPEND LS_S TO LT_S.


    galv_grid2->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYO
      CHANGING
        it_outtab                     = GT_EM_MOVIMIENTOS
        it_fieldcatalog               = GT_FIELDCATEM
        it_sort                       = LT_S
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

  ELSEIF TM EQ 'EP'.

    LS_S-fieldname = 'FOLIO_ENT_PRO'.
    LS_S-up = ABAP_TRUE.

    APPEND LS_S TO LT_S.

    galv_grid2->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYO
      CHANGING
        it_outtab                     = GT_EP_MOVIMIENTOS
        it_fieldcatalog               = GT_FIELDCATEP
        it_sort                       = LT_S
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

  ELSEIF TM EQ 'SM'.

    LS_S-fieldname = 'FOLIO_SAL_MAT'.
    LS_S-up = ABAP_TRUE.

    APPEND LS_S TO LT_S.


    galv_grid2->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYO
      CHANGING
        it_outtab                     = GT_SM_MOVIMIENTOS
        it_fieldcatalog               = GT_FIELDCATSM
        it_sort                       = LT_S
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

  ELSEIF TM EQ 'SP'.

    LS_S-fieldname = 'FOLIO_SAL_PRO'.
    LS_S-up = ABAP_TRUE.

    APPEND LS_S TO LT_S.

    galv_grid2->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYO
      CHANGING
        it_outtab                     = GT_SP_MOVIMIENTOS
        it_fieldcatalog               = GT_FIELDCATSP
        it_sort                       = LT_S
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
*& Form CONTAINERS_MOVIMIENTOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CONTAINERS_MOVIMIENTOS USING TM.

  PERFORM LIBERAR_CONT_MOVIMIENTOS.

  IF TM EQ 'EM'.

    IF NOT C_CONTAINER2 IS BOUND.

      PERFORM INSTANCE_CONT_MOVIMIENTOS USING 'EM'.
      PERFORM BUILD_FIELCAT_MOVIMIENTOS USING 'EM'.
      PERFORM GET_DATA_MOVIMIENTOS USING 'EM'.
      PERFORM INSTANCE_ALV_EM.
      PERFORM BUILD_LAYOUT_MOVIMIENTOS USING 'EM'.
      PERFORM SET_HANDLER_EM.
      PERFORM DISPLAY_ALV_MOVIMIENTOS USING 'EM'.

    ELSE.

      PERFORM REFRESCAR_ALV_MOVIMIENTOS.

    ENDIF.

  ELSEIF TM EQ 'EP'.

    IF NOT C_CONTAINER2 IS BOUND.

      PERFORM INSTANCE_CONT_MOVIMIENTOS USING 'EP'.
      PERFORM BUILD_FIELCAT_MOVIMIENTOS USING 'EP'.
      PERFORM GET_DATA_MOVIMIENTOS USING 'EP'.
      PERFORM INSTANCE_ALV_EP.
      PERFORM BUILD_LAYOUT_MOVIMIENTOS USING 'EP'.
      PERFORM SET_HANDLER_EP.
      PERFORM DISPLAY_ALV_MOVIMIENTOS USING 'EP'.

    ELSE.

      PERFORM REFRESCAR_ALV_MOVIMIENTOS.

    ENDIF.

  ELSEIF TM EQ 'SM'.

    IF NOT C_CONTAINER2 IS BOUND.

      PERFORM INSTANCE_CONT_MOVIMIENTOS USING 'SM'.
      PERFORM BUILD_FIELCAT_MOVIMIENTOS USING 'SM'.
      PERFORM GET_DATA_MOVIMIENTOS USING 'SM'.
      PERFORM INSTANCE_ALV_SM.
      PERFORM BUILD_LAYOUT_MOVIMIENTOS USING 'SM'.
      PERFORM SET_HANDLER_SM.
      PERFORM DISPLAY_ALV_MOVIMIENTOS USING 'SM'.

    ELSE.

      PERFORM REFRESCAR_ALV_MOVIMIENTOS.

    ENDIF.

  ELSEIF TM EQ 'SP'.

    IF NOT C_CONTAINER2 IS BOUND.

      PERFORM INSTANCE_CONT_MOVIMIENTOS USING 'SP'.
      PERFORM BUILD_FIELCAT_MOVIMIENTOS USING 'SP'.
      PERFORM GET_DATA_MOVIMIENTOS USING 'SP'.
      PERFORM INSTANCE_ALV_SP.
      PERFORM BUILD_LAYOUT_MOVIMIENTOS USING 'SP'.
      PERFORM SET_HANDLER_SP.
      PERFORM DISPLAY_ALV_MOVIMIENTOS USING 'SP'.

    ELSE.

      PERFORM REFRESCAR_ALV_MOVIMIENTOS.

    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4007
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4007 .

  PERFORM CONTAINERS_MOVIMIENTOS USING 'EP'.

  CLEAR: ztc_busqueda-fecha_desde,
         ztc_busqueda-fecha_hasta,
         ztc_ent_producto-folio_ent_pro.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4008
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4008 .

  PERFORM CONTAINERS_MOVIMIENTOS USING 'EM'.

  CLEAR: ztc_busqueda-fecha_desde,
         ztc_busqueda-fecha_hasta,
         ztc_ent_material-folio_ent_mat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4009
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4009 .

  PERFORM CONTAINERS_MOVIMIENTOS USING 'SP'.

  CLEAR: ztc_busqueda-fecha_desde,
         ztc_busqueda-fecha_hasta,
         ztc_sal_producto-folio_sal_pro.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4010
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4010 .

  PERFORM CONTAINERS_MOVIMIENTOS USING 'SM'.

  CLEAR: ztc_busqueda-fecha_desde,
         ztc_busqueda-fecha_hasta,
         ztc_sal_material-folio_sal_mat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form LIBERAR_DETALLES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LIBERAR_DETALLES.

  IF C_CONTAINER_DETA IS BOUND.

    C_CONTAINER_DETA->free(
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        others            = 3
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CLEAR C_CONTAINER_DETA.

    IF GALV_GRID_DETA IS BOUND.

      CLEAR GALV_GRID_DETA.

    ENDIF.

  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESCAR_ALV_DETA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESCAR_ALV_DETA.

  GALV_GRID_DETA->refresh_table_display(
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
*& Form INST_CONT_DETA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM INST_CONT_DETA USING D1.

  IF D1 EQ 'EMD'.

    CREATE OBJECT c_container_deta
      EXPORTING
*        parent                      =
        container_name              = 'C_ENTRADA_MATERIAL_DETA'
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

  ELSEIF D1 EQ 'EPD'.

    CREATE OBJECT c_container_deta
      EXPORTING
*        parent                      =
        container_name              = 'C_ENTRADA_PRODUCTO_DETA'
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

  ELSEIF D1 EQ 'SMD'.

    CREATE OBJECT c_container_deta
      EXPORTING
*        parent                      =
        container_name              = 'C_SALIDA_MATERIAL_DETA'
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

  ELSEIF D1 EQ 'SPD'.

    CREATE OBJECT c_container_deta
      EXPORTING
*        parent                      =
        container_name              = 'C_SALIDA_PRODUCTO_DETA'
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
*& Form BUILD_FIELDCAT_DETA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM BUILD_FIELDCAT_DETA USING D2.

  IF D2 EQ 'EMD'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_ENT_MAT_DETA'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_EM
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_EM ASSIGNING <LS_FIELDCAT_DETA>.
        CASE <LS_FIELDCAT_DETA>-fieldname .
          WHEN 'FOLIO_ENT_MAT'.
            <LS_FIELDCAT_DETA>-no_out = ABAP_TRUE.
          WHEN 'ID_MATERIAL'.
            <LS_FIELDCAT_DETA>-col_pos = 1.
          WHEN 'DESCRIPCION'.
            <LS_FIELDCAT_DETA>-col_pos = 2.
          WHEN 'COLOR'.
            <LS_FIELDCAT_DETA>-col_pos = 3.
          WHEN 'ROLLOS'.
            <LS_FIELDCAT_DETA>-col_pos = 4.
          WHEN 'METROS'.
            <LS_FIELDCAT_DETA>-col_pos = 5.
          WHEN 'PESO'.
            <LS_FIELDCAT_DETA>-col_pos = 6.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF D2 EQ 'EPD'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_ENT_PRO_DETA'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_EP
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
   IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_EP ASSIGNING <LS_FIELDCAT_DETA>.
        CASE <LS_FIELDCAT_DETA>-fieldname .
          WHEN 'FOLIO_ENT_PRO'.
            <LS_FIELDCAT_DETA>-no_out = ABAP_TRUE.
          WHEN 'ID_PRODUCTO'.
            <LS_FIELDCAT_DETA>-col_pos = 1.
          WHEN 'DESCRIPCION'.
            <LS_FIELDCAT_DETA>-col_pos = 2.
          WHEN 'COLOR'.
            <LS_FIELDCAT_DETA>-col_pos = 3.
          WHEN 'TALLA'.
            <LS_FIELDCAT_DETA>-col_pos = 4.
          WHEN 'PIEZAS'.
            <LS_FIELDCAT_DETA>-col_pos = 5.
          WHEN 'PESO'.
            <LS_FIELDCAT_DETA>-col_pos = 6.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF D2 EQ 'SMD'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_SAL_MAT_DETA'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_SM
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_SM ASSIGNING <LS_FIELDCAT_DETA>.
        CASE <LS_FIELDCAT_DETA>-fieldname .
          WHEN 'FOLIO_SAL_MAT'.
            <LS_FIELDCAT_DETA>-no_out = ABAP_TRUE.
          WHEN 'ID_MATERIAL'.
            <LS_FIELDCAT_DETA>-col_pos = 1.
          WHEN 'DESCRIPCION'.
            <LS_FIELDCAT_DETA>-col_pos = 2.
          WHEN 'COLOR'.
            <LS_FIELDCAT_DETA>-col_pos = 3.
          WHEN 'ROLLOS'.
            <LS_FIELDCAT_DETA>-col_pos = 4.
          WHEN 'TIPO_ROLLO'.
            <LS_FIELDCAT_DETA>-col_pos = 5.
          WHEN 'METROS'.
            <LS_FIELDCAT_DETA>-col_pos = 6.
          WHEN 'PESO'.
            <LS_FIELDCAT_DETA>-col_pos = 7.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ELSEIF D2 EQ 'SPD'.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_SAL_PRO_DETA'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_SP
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_SP ASSIGNING <LS_FIELDCAT_DETA>.
        CASE <LS_FIELDCAT_DETA>-fieldname .
          WHEN 'FOLIO_SAL_PRO'.
            <LS_FIELDCAT_DETA>-no_out = ABAP_TRUE.
          WHEN 'ID_PRODUCTO'.
            <LS_FIELDCAT_DETA>-col_pos = 1.
          WHEN 'DESCRIPCION'.
            <LS_FIELDCAT_DETA>-col_pos = 2.
          WHEN 'COLOR'.
            <LS_FIELDCAT_DETA>-col_pos = 3.
          WHEN 'TALLA'.
            <LS_FIELDCAT_DETA>-col_pos = 4.
          WHEN 'PIEZAS'.
            <LS_FIELDCAT_DETA>-col_pos = 5.
          WHEN 'PESO'.
            <LS_FIELDCAT_DETA>-col_pos = 6.
          WHEN 'PRECIO'.
            <LS_FIELDCAT_DETA>-col_pos = 7.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA_DETA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM GET_DATA_DETA USING D3.

  IF D3 EQ 'EMD'.

    SELECT A~FOLIO_ENT_MAT
           A~ID_MATERIAL
           A~ROLLOS
           A~METROS
           A~PESO
           B~DESCRIPCION
           B~COLOR
      INTO CORRESPONDING FIELDS OF TABLE GT_EMD
      FROM ZTC_ENT_MAT_DETA AS A
        INNER JOIN ZTC_MATERIALES AS B
              ON B~ID_MATERIAL EQ A~ID_MATERIAL
      WHERE FOLIO_ENT_MAT EQ ZTC_ENT_MATERIAL-FOLIO_ENT_MAT.

  ELSEIF D3 EQ 'EPD'.

    SELECT A~FOLIO_ENT_PRO
           A~ID_PRODUCTO
           A~PIEZAS
           A~PESO
           B~DESCRIPCION
           B~COLOR
           B~TALLA
      INTO CORRESPONDING FIELDS OF TABLE GT_EPD
      FROM ZTC_ENT_PRO_DETA AS A
        INNER JOIN ZTC_PRODUCTOS AS B
              ON B~ID_PRODUCTO EQ A~ID_PRODUCTO
      WHERE FOLIO_ENT_PRO EQ ZTT_ENT_PRO-FOLIO_ENT_PRO.

  ELSEIF D3 EQ 'SMD'.

    SELECT A~FOLIO_SAL_MAT
           A~ID_MATERIAL
           A~ROLLOS
           A~TIPO_ROLLO
           A~METROS
           A~PESO
           B~DESCRIPCION
           B~COLOR
      INTO CORRESPONDING FIELDS OF TABLE GT_SMD
      FROM ZTC_SAL_MAT_DETA AS A
        INNER JOIN ZTC_MATERIALES AS B
              ON B~ID_MATERIAL EQ A~ID_MATERIAL
      WHERE FOLIO_SAL_MAT EQ ZTT_SAL_MAT-FOLIO_SAL_MAT.

  ELSEIF D3 EQ 'SPD'.

    SELECT A~FOLIO_SAL_PRO
           A~ID_PRODUCTO
           A~PIEZAS
           A~PESO
           A~PRECIO
           B~DESCRIPCION
           B~COLOR
           B~TALLA
      INTO CORRESPONDING FIELDS OF TABLE GT_SPD
      FROM ZTC_SAL_PRO_DETA AS A
        INNER JOIN ZTC_PRODUCTOS AS B
              ON B~ID_PRODUCTO EQ A~ID_PRODUCTO
      WHERE FOLIO_SAL_PRO EQ ZTT_SAL_PRO-FOLIO_SAL_PRO.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_EMD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_EMD.

  CREATE OBJECT galv_grid_deta
    EXPORTING
      i_parent                = C_CONTAINER_DETA
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
*& Form INSTANCE_ALV_EMD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_EPD.

  CREATE OBJECT galv_grid_deta
    EXPORTING
      i_parent                = C_CONTAINER_DETA
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
*& Form INSTANCE_ALV_EMD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_SMD.

  CREATE OBJECT galv_grid_deta
    EXPORTING
      i_parent                = C_CONTAINER_DETA
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
*& Form INSTANCE_ALV_EMD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_SPD.

  CREATE OBJECT galv_grid_deta
    EXPORTING
      i_parent                = C_CONTAINER_DETA
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
*& Form BUILD_LAYOUT_DETA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM BUILD_LAYOUT_DETA USING D4.

  IF D4 EQ 'EMD'.

    GS_LAYOUT_DETA-zebra = ABAP_TRUE.
    GS_LAYOUT_DETA-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_DETA-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_EM ASSIGNING <LS_FIELDCAT_DETA> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_EMD ASSIGNING <LS_EM>.

        LS_STYLE_DETA-fieldname = <LS_FIELDCAT_DETA>-fieldname.
        LS_STYLE_DETA-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_DETA INTO TABLE <LS_EM>-field_style.

      ENDLOOP.
    ENDLOOP.

  ELSEIF D4 EQ 'EPD'.

    GS_LAYOUT_DETA-zebra = ABAP_TRUE.
    GS_LAYOUT_DETA-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_DETA-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_EP ASSIGNING <LS_FIELDCAT_DETA> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_EPD ASSIGNING <LS_EP>.

        LS_STYLE_DETA-fieldname = <LS_FIELDCAT_DETA>-fieldname.
        LS_STYLE_DETA-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_DETA INTO TABLE <LS_EP>-field_style.

      ENDLOOP.
    ENDLOOP.

  ELSEIF D4 EQ 'SMD'.

    GS_LAYOUT_DETA-zebra = ABAP_TRUE.
    GS_LAYOUT_DETA-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_DETA-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_SM ASSIGNING <LS_FIELDCAT_DETA> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_SMD ASSIGNING <LS_SM>.

        LS_STYLE_DETA-fieldname = <LS_FIELDCAT_DETA>-fieldname.
        LS_STYLE_DETA-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_DETA INTO TABLE <LS_SM>-field_style.

      ENDLOOP.
    ENDLOOP.

  ELSEIF D4 EQ 'SPD'.

    GS_LAYOUT_DETA-zebra = ABAP_TRUE.
    GS_LAYOUT_DETA-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_DETA-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_SP ASSIGNING <LS_FIELDCAT_DETA> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_SPD ASSIGNING <LS_SP>.

        LS_STYLE_DETA-fieldname = <LS_FIELDCAT_DETA>-fieldname.
        LS_STYLE_DETA-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_DETA INTO TABLE <LS_SP>-field_style.

      ENDLOOP.
    ENDLOOP.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV_DETA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&---------------------------------------------------------------------*
FORM DISPLAY_ALV_DETA USING D5.

  IF D5 EQ 'EMD'.

    galv_grid_deta->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_DETA
      CHANGING
        it_outtab                     = GT_EMD
        it_fieldcatalog               = GT_FIELDCAT_EM
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

  ELSEIF D5 EQ 'EPD'.

    galv_grid_deta->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_DETA
      CHANGING
        it_outtab                     = GT_EPD
        it_fieldcatalog               = GT_FIELDCAT_EP
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

  ELSEIF D5 EQ 'SMD'.

    galv_grid_deta->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_DETA
      CHANGING
        it_outtab                     = GT_SMD
        it_fieldcatalog               = GT_FIELDCAT_SM
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

  ELSEIF D5 EQ 'SPD'.

    galv_grid_deta->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_DETA
      CHANGING
        it_outtab                     = GT_SPD
        it_fieldcatalog               = GT_FIELDCAT_SP
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
*& Form CONTAINERS_DETALLES
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CONTAINERS_DETALLES USING D6 .

  PERFORM LIBERAR_DETALLES.

  IF D6 EQ 'EMD'.

    IF NOT C_CONTAINER_DETA IS BOUND.

      PERFORM INST_CONT_DETA USING 'EMD'.
      PERFORM BUILD_FIELDCAT_DETA USING 'EMD'.
      PERFORM GET_DATA_DETA USING 'EMD'.
      PERFORM INSTANCE_ALV_EMD.
      PERFORM BUILD_LAYOUT_DETA USING 'EMD'.
      PERFORM DISPLAY_ALV_DETA USING 'EMD'.

    ELSE.

      PERFORM REFRESCAR_ALV_DETA.

    ENDIF.

  ELSEIF D6 EQ 'EPD'.

    IF NOT C_CONTAINER_DETA IS BOUND.

      PERFORM INST_CONT_DETA USING 'EPD'.
      PERFORM BUILD_FIELDCAT_DETA USING 'EPD'.
      PERFORM GET_DATA_DETA USING 'EPD'.
      PERFORM INSTANCE_ALV_EPD.
      PERFORM BUILD_LAYOUT_DETA USING 'EPD'.
      PERFORM DISPLAY_ALV_DETA USING 'EPD'.

    ELSE.

      PERFORM REFRESCAR_ALV_DETA.

    ENDIF.

  ELSEIF D6 EQ 'SMD'.

    IF NOT C_CONTAINER_DETA IS BOUND.

      PERFORM INST_CONT_DETA USING 'SMD'.
      PERFORM BUILD_FIELDCAT_DETA USING 'SMD'.
      PERFORM GET_DATA_DETA USING 'SMD'.
      PERFORM INSTANCE_ALV_SMD.
      PERFORM BUILD_LAYOUT_DETA USING 'SMD'.
      PERFORM DISPLAY_ALV_DETA USING 'SMD'.

    ELSE.

      PERFORM REFRESCAR_ALV_DETA.

    ENDIF.

  ELSEIF D6 EQ 'SPD'.

    IF NOT C_CONTAINER_DETA IS BOUND.

      PERFORM INST_CONT_DETA USING 'SPD'.
      PERFORM BUILD_FIELDCAT_DETA USING 'SPD'.
      PERFORM GET_DATA_DETA USING 'SPD'.
      PERFORM INSTANCE_ALV_SPD.
      PERFORM BUILD_LAYOUT_DETA USING 'SPD'.
      PERFORM DISPLAY_ALV_DETA USING 'SPD'.

    ELSE.

      PERFORM REFRESCAR_ALV_DETA.

    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form LIBERAR_DETALLES2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LIBERAR_DETALLES2 .

  IF C_CONTAINER_DETA2 IS BOUND.

    C_CONTAINER_DETA2->free(
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        others            = 3
    ).
    IF SY-SUBRC <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
       WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CLEAR C_CONTAINER_DETA2.

    IF GALV_GRID_DETA2 IS BOUND.

      CLEAR GALV_GRID_DETA2.

    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESCAR_ALV_DETA2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESCAR_ALV_DETA2 .

  GALV_GRID_DETA2->refresh_table_display(
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
*& Form INST_CONT_DETA2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INST_CONT_DETA2 .

  CREATE OBJECT c_container_deta2
      EXPORTING
*        parent                      =
        container_name              = 'C_DEV_DETA'
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
*& Form BUILD_FIELDCAT_DETA2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM BUILD_FIELDCAT_DETA2 .

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
*       I_BUFFER_ACTIVE              =
       I_STRUCTURE_NAME             = 'ZTC_DEV_PRODUCTO'
*       I_CLIENT_NEVER_DISPLAY       = 'X'
*       I_BYPASSING_BUFFER           =
*       I_INTERNAL_TABNAME           =
      CHANGING
        ct_fieldcat                  = GT_FIELDCAT_DEV
     EXCEPTIONS
       INCONSISTENT_INTERFACE       = 1
       PROGRAM_ERROR                = 2
       OTHERS                       = 3
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      LOOP AT GT_FIELDCAT_DEV ASSIGNING <LS_FIELDCAT_DETA2>.
        CASE <LS_FIELDCAT_DETA2>-fieldname .
          WHEN 'FOLIO_ENT_PRO'.
            <LS_FIELDCAT_DETA2>-no_out = ABAP_TRUE.
          WHEN 'ID_MATERIAL'.
            <LS_FIELDCAT_DETA2>-col_pos = 1.
          WHEN 'DESCRIPCION'.
            <LS_FIELDCAT_DETA2>-col_pos = 2.
          WHEN 'COLOR'.
            <LS_FIELDCAT_DETA2>-col_pos = 3.
          WHEN 'ROLLOS'.
            <LS_FIELDCAT_DETA2>-col_pos = 4.
          WHEN 'TIPO_ROLLO'.
            <LS_FIELDCAT_DETA2>-col_pos = 5.
          WHEN 'METROS'.
            <LS_FIELDCAT_DETA2>-col_pos = 6.
          WHEN 'PESO'.
            <LS_FIELDCAT_DETA2>-col_pos = 7.
          WHEN OTHERS.
        ENDCASE.
      ENDLOOP.
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA_DETA2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA_DETA2 .

  SELECT A~FOLIO_ENT_PRO
         A~ID_MATERIAL
         A~ROLLOS
         A~TIPO_ROLLO
         A~METROS
         A~PESO
         B~DESCRIPCION
         B~COLOR
    INTO CORRESPONDING FIELDS OF TABLE GT_DEV
    FROM ZTC_DEV_PRODUCTO AS A
      INNER JOIN ZTC_MATERIALES AS B
            ON B~ID_MATERIAL EQ A~ID_MATERIAL
    WHERE FOLIO_ENT_PRO EQ ZTT_ENT_PRO-FOLIO_ENT_PRO.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INSTANCE_ALV_DETA2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INSTANCE_ALV_DETA2 .

  CREATE OBJECT galv_grid_deta2
    EXPORTING
      i_parent                = C_CONTAINER_DETA2
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
*& Form BUILD_LAYOUT_DETA2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM BUILD_LAYOUT_DETA2 .

    GS_LAYOUT_DETA2-zebra = ABAP_TRUE.
    GS_LAYOUT_DETA2-stylefname = 'FIELD_STYLE'.
    GS_LAYOUT_DETA2-cwidth_opt = ABAP_TRUE.

    LOOP AT GT_FIELDCAT_DEV ASSIGNING <LS_FIELDCAT_DETA2> WHERE KEY = ABAP_TRUE.
      LOOP AT GT_DEV ASSIGNING <LS_DEV>.

        LS_STYLE_DETA2-fieldname = <LS_FIELDCAT_DETA2>-fieldname.
        LS_STYLE_DETA2-style = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.
        INSERT LS_STYLE_DETA2 INTO TABLE <LS_DEV>-field_style.

      ENDLOOP.
    ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV_DETA2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY_ALV_DETA2 .

  galv_grid_deta2->set_table_for_first_display(
      EXPORTING
        is_layout                     = GS_LAYOUT_DETA2
      CHANGING
        it_outtab                     = GT_DEV
        it_fieldcatalog               = GT_FIELDCAT_DEV
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
*& Form CONTAINERS_DETALLES2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CONTAINERS_DETALLES2 .

  PERFORM LIBERAR_DETALLES2.

    IF NOT C_CONTAINER_DETA2 IS BOUND.

      PERFORM INST_CONT_DETA2.
      PERFORM BUILD_FIELDCAT_DETA2.
      PERFORM GET_DATA_DETA2.
      PERFORM INSTANCE_ALV_DETA2.
      PERFORM BUILD_LAYOUT_DETA2.
      PERFORM DISPLAY_ALV_DETA2.

    ELSE.

      PERFORM REFRESCAR_ALV_DETA2.

    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4020
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4020.

  ZTC_ENT_MATERIAL-FOLIO_ENT_MAT = GS_EM_SELECCIONADO-FOLIO_ENT_MAT.
  ZTC_PROVEEDORES-NOMBRE = GS_EM_SELECCIONADO-NOMBRE.
  ZTC_ENT_MATERIAL-FECHA_ENTRADA = GS_EM_SELECCIONADO-FECHA_ENTRADA.
  ZTC_ENT_MATERIAL-ALMACENISTA = GS_EM_SELECCIONADO-ALMACENISTA.

  PERFORM CONTAINERS_DETALLES USING 'EMD'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4021
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4021 .

  ZTT_ENT_PRO-FOLIO_ENT_PRO = GS_EP_SELECCIONADO-FOLIO_ENT_PRO.
  ZTT_ENT_PRO-FOLIO_SAL_MAT = GS_EP_SELECCIONADO-FOLIO_SAL_MAT.
  ZTC_EMPLEADOS-NOMBRE = GS_EP_SELECCIONADO-NOMBRE.
  ZTT_ENT_PRO-ALMACENISTA = GS_EP_SELECCIONADO-ALMACENISTA.
  ZTT_ENT_PRO-FECHA_ENTRADA = GS_EP_SELECCIONADO-FECHA_ENTRADA.
  ZTT_ENT_PRO-PESO_TOTAL = GS_EP_SELECCIONADO-PESO_TOTAL.
  ZTC_ENT_PRODUCTO-MERMA = GS_EP_SELECCIONADO-MERMA.

  PERFORM CONTAINERS_DETALLES USING 'EPD'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_40212
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_40212 .

  PERFORM CONTAINERS_DETALLES2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_2023
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_2023 .

  ZTT_SAL_PRO-FOLIO_SAL_PRO = GS_SP_SELECCIONADO-FOLIO_SAL_PRO.
  ZTC_CLIENTES-NOMBRE = GS_SP_SELECCIONADO-NOMBRE.
  ZTT_SAL_PRO-ALMACENISTA = GS_SP_SELECCIONADO-ALMACENISTA.
  ZTT_SAL_PRO-FECHA_SALIDA = GS_SP_SELECCIONADO-FECHA_SALIDA.

  PERFORM CONTAINERS_DETALLES USING 'SPD'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_4022
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_4022 .

  ZTT_SAL_MAT-FOLIO_SAL_MAT = GS_SM_SELECCIONADO-FOLIO_SAL_MAT.
  ZTC_EMPLEADOS-NOMBRE = GS_SM_SELECCIONADO-NOMBRE.
  ZTT_SAL_MAT-ALMACENISTA = GS_SM_SELECCIONADO-ALMACENISTA.
  ZTT_SAL_MAT-FECHA_SALIDA = GS_SM_SELECCIONADO-FECHA_SALIDA.
  ZTT_SAL_MAT-PESO_TOTAL = GS_SM_SELECCIONADO-PESO_TOTAL.
  ZTT_SAL_MAT-PESO_RESTANTE = GS_SM_SELECCIONADO-PESO_RESTANTE.

  PERFORM CONTAINERS_DETALLES USING 'SMD'.

ENDFORM.
