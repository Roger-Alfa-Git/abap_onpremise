*&---------------------------------------------------------------------*
*& Include          ZGI_COVATEX_TOP
*&---------------------------------------------------------------------*

* --------- OK_CODES DE DYNPROS ---------
DATA: OK_CODE_4000 TYPE SYUCOMM,
      OK_CODE_4001 TYPE SYUCOMM,
      OK_CODE_4002 TYPE SYUCOMM,
      OK_CODE_4003 TYPE SYUCOMM,
      OK_CODE_4004 TYPE SYUCOMM,
      OK_CODE_4005 TYPE SYUCOMM,
      OK_CODE_4006 TYPE SYUCOMM,
      OK_CODE_4007 TYPE SYUCOMM,
      OK_CODE_4008 TYPE SYUCOMM,
      OK_CODE_4009 TYPE SYUCOMM,
      OK_CODE_4010 TYPE SYUCOMM,
      OK_CODE_4011 TYPE SYUCOMM,
      OK_CODE_4012 TYPE SYUCOMM,
      OK_CODE_4013 TYPE SYUCOMM,
      OK_CODE_4014 TYPE SYUCOMM,
      OK_CODE_4015 TYPE SYUCOMM,
      OK_CODE_4016 TYPE SYUCOMM,
      OK_CODE_4017 TYPE SYUCOMM,
      OK_CODE_4018 TYPE SYUCOMM,
      OK_CODE_4019 TYPE SYUCOMM,
      OK_CODE_4020 TYPE SYUCOMM,
      OK_CODE_4021 TYPE SYUCOMM,
      OK_CODE_4022 TYPE SYUCOMM,
      OK_CODE_4023 TYPE SYUCOMM,
      OK_CODE_4024 TYPE SYUCOMM,
      OK_CODE_4025 TYPE SYUCOMM,
      OK_CODE_4026 TYPE SYUCOMM,
      OK_CODE_4027 TYPE SYUCOMM,
      OK_CODE_4028 TYPE SYUCOMM,
      OK_CODE_4029 TYPE SYUCOMM,
      OK_CODE_4030 TYPE SYUCOMM,
      OK_CODE_4031 TYPE SYUCOMM,
      OK_CODE_4032 TYPE SYUCOMM,
      OK_CODE_4033 TYPE SYUCOMM,
      OK_CODE_4034 TYPE SYUCOMM,
      OK_CODE_4035 TYPE SYUCOMM. " BORRAR

DATA OK_CODE LIKE SY-UCOMM.

* ----------- Variables para Imagen --------------

DATA: CONTENEDOR TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      PICTURE_CONTROL TYPE REF TO CL_GUI_PICTURE,
      L_BYTECOUNT TYPE I,
      L_CONTENT TYPE STANDARD TABLE OF BAPICONTEN,
      URL(255) TYPE C,
      BEGIN OF GRAPHIC_TABLE OCCURS 0,
       LINE(255) TYPE X,
      END OF GRAPHIC_TABLE.

*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*********** DECLARACIONES PARA MATERIALES Y PRODUCTOS ***********
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
DATA: C_CONTAINER_PROMAT TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GALV_GRID_PROMAT TYPE REF TO CL_GUI_ALV_GRID.

DATA: GT_FIELDCAT_PRO TYPE lvc_t_fcat,
      GT_FIELDCAT_MAT2 TYPE lvc_t_fcat,
      GT_FIELDCAT_MAQ TYPE lvc_t_fcat,
      GT_FIELDCAT_PROV TYPE lvc_t_fcat,
      GT_FIELDCAT_CLI TYPE lvc_t_fcat.

TYPES: BEGIN OF GTY_PRO,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_PRODUCTOS.
TYPES    END OF GTY_PRO.
DATA: GT_PRO TYPE TABLE OF GTY_PRO.

TYPES: BEGIN OF GTY_MAT2,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_MATERIALES.
TYPES    END OF GTY_MAT2.
DATA: GT_MAT2 TYPE TABLE OF GTY_MAT2.

TYPES: BEGIN OF GTY_PROV2,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_PROVEEDORES.
TYPES END OF GTY_PROV2.
DATA: GT_PROV2 TYPE TABLE OF GTY_PROV2.

TYPES: BEGIN OF GTY_MAQ,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_EMPLEADOS.
TYPES    END OF GTY_MAQ.
DATA: GT_MAQ TYPE TABLE OF GTY_MAQ.

TYPES: BEGIN OF GTY_CLI,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_CLIENTES.
TYPES    END OF GTY_CLI.
DATA: GT_CLI TYPE TABLE OF GTY_CLI.

DATA GS_PROVEEDOR_SELECCIONADO TYPE GTY_PROV2.

DATA GS_PRODUCTO_SELECCIONADO TYPE GTY_PRO.

DATA GS_MAQUILERO_SELECCIONADO TYPE GTY_MAQ.

DATA GS_CLIENTE_SELECCIONADO TYPE GTY_CLI.

DATA GS_MATERIAL_SELECCIONADO TYPE GTY_MAT2.

DATA GS_LAYOUT_PROMAT TYPE LVC_S_LAYO.

FIELD-SYMBOLS: <LS_FIELDCAT_PROMAT> TYPE LVC_S_FCAT,
               <LS_PRO> TYPE GTY_PRO,
               <LS_MAT> TYPE GTY_MAT2,
               <LS_PROV> TYPE GTY_PROV2,
               <LS_MAQ> TYPE GTY_MAQ,
               <LS_CLI> TYPE GTY_CLI.

DATA LS_STYLE_PROMAT TYPE LVC_S_STYL.

*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
********* FIN DECLARACIONES PARA MATERIALES Y PRODUCTOS *********
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************

DATA: LO_COLUMNS TYPE REF TO CL_SALV_COLUMNS_TABLE,
      LO_COLUMN TYPE REF TO CL_SALV_COLUMN.

*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*** VARIABLES, CONSTANTES Y CONTROL PARA TABSTRIP MOVIMIENTOS ***
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************

CONSTANTS: BEGIN OF C_MOVIMIENTOS,
           TAB1 LIKE SY-UCOMM VALUE 'TC_1',
           TAB2 LIKE SY-UCOMM VALUE 'TC_2',
           TAB3 LIKE SY-UCOMM VALUE 'TC_3',
           TAB4 LIKE SY-UCOMM VALUE 'TC_4',
           END OF C_MOVIMIENTOS.

CONTROLS: TC_MOVIMIENTOS TYPE TABSTRIP.

DATA: BEGIN OF G_MOVIMIENTOS,
      SUBSCREEN LIKE SY-DYNNR,
      PROG LIKE SY-REPID VALUE 'ZGI_COVATEX',
      PRESSED_TAB LIKE SY-UCOMM VALUE C_MOVIMIENTOS-TAB1,
      END OF G_MOVIMIENTOS.

* Definicion de puntero para ct_fieldcat, usado para la traduccion de tablas y build_layout
FIELD-SYMBOLS: <LS_FIELDCAT> TYPE LVC_S_FCAT.

* Definicion de variable para style
DATA LS_STYLE TYPE LVC_S_STYL.

* Variables para fieldcat
DATA: GT_FIELDCATEP TYPE lvc_t_fcat,
      GT_FIELDCATEM TYPE lvc_t_fcat,
      GT_FIELDCATSP TYPE lvc_t_fcat,
      GT_FIELDCATSM TYPE lvc_t_fcat.

* Variables para objetos
DATA: C_CONTAINER2 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GALV_GRID2 TYPE REF TO CL_GUI_ALV_GRID.

* Definicion de tablas para la busqueda de movimientos
DATA: RFECHA TYPE RANGE OF SYDATUM WITH HEADER LINE,
      RFOLIO TYPE RANGE OF CHAR10 WITH HEADER LINE.

* Definicion de variable para el manejo de los datos dentro del layout
DATA GS_LAYO TYPE LVC_S_LAYO.


TYPES: BEGIN OF GTY_EP_MOVIMIENTOS,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_ENT_PRODUCTO.
TYPES    END OF GTY_EP_MOVIMIENTOS.
DATA: GT_EP_MOVIMIENTOS TYPE TABLE OF GTY_EP_MOVIMIENTOS.

TYPES: BEGIN OF GTY_EM_MOVIMIENTOS,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_ENT_MATERIAL.
TYPES    END OF GTY_EM_MOVIMIENTOS.
DATA: GT_EM_MOVIMIENTOS TYPE TABLE OF GTY_EM_MOVIMIENTOS.

TYPES: BEGIN OF GTY_SP_MOVIMIENTOS,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_SAL_PRODUCTO.
TYPES    END OF GTY_SP_MOVIMIENTOS.
DATA: GT_SP_MOVIMIENTOS TYPE TABLE OF GTY_SP_MOVIMIENTOS.

TYPES: BEGIN OF GTY_SM_MOVIMIENTOS,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_SAL_MATERIAL.
TYPES    END OF GTY_SM_MOVIMIENTOS.
DATA: GT_SM_MOVIMIENTOS TYPE TABLE OF GTY_SM_MOVIMIENTOS.

DATA: GS_EP_SELECCIONADO TYPE GTY_EP_MOVIMIENTOS,
      GS_EM_SELECCIONADO TYPE GTY_EM_MOVIMIENTOS,
      GS_SP_SELECCIONADO TYPE GTY_SP_MOVIMIENTOS,
      GS_SM_SELECCIONADO TYPE GTY_SM_MOVIMIENTOS.
*****************************************************************
*****************************************************************
*****************************************************************

TYPES: BEGIN OF GTY_ENT_MT,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTT_ENT_MAT.
TYPES    END OF GTY_ENT_MT.
DATA: GT_ENT_MT TYPE TABLE OF GTY_ENT_MT.
DATA GS_ENT_MT_SELECCIONADO TYPE GTY_ENT_MT.


TYPES: BEGIN OF GTY_SAL_MT,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ztt_sal_mat.
TYPES    END OF GTY_SAL_MT.
DATA: GT_SAL_MT TYPE TABLE OF GTY_SAL_MT.
DATA GS_SAL_MT_SELECCIONADO TYPE GTY_SAL_MT.


TYPES: BEGIN OF GTY_ENT_PR,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ztt_ent_pro.
TYPES    END OF GTY_ENT_PR.
DATA: GT_ENT_PR TYPE TABLE OF GTY_ENT_PR.
DATA GS_ENT_PR_SELECCIONADO TYPE GTY_ENT_PR.


TYPES: BEGIN OF GTY_DEV_PR,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ztt_dev_producto.
TYPES    END OF GTY_DEV_PR.
DATA: GT_DEV_PR TYPE TABLE OF GTY_DEV_PR.
DATA GS_DEV_PR_SELECCIONADO TYPE GTY_DEV_PR.


TYPES: BEGIN OF GTY_SAL_PR,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ztt_sal_pro.
TYPES    END OF GTY_SAL_PR.
DATA: GT_SAL_PR TYPE TABLE OF GTY_SAL_PR.
DATA GS_SAL_PR_SELECCIONADO TYPE GTY_SAL_PR.




DATA fol TYPE I.
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
* FIN VARIABLES, CONSTANTES Y CONTROL PARA TABSTRIP MOVIMIENTOS *
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************

DATA DD TYPE I.

*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*                     VARIABLES "GENERALES"                     *
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
*****************************************************************
DATA: GWA_PROVEEDORES TYPE ZTC_PROVEEDORES.

CLASS LCL_EVENT_RECEIVER DEFINITION DEFERRED.
CLASS LCL_EVENT_PRODUCTO DEFINITION DEFERRED.
CLASS LCL_EVENT_MAQUILERO DEFINITION DEFERRED.
CLASS LCL_EVENT_CLIENTE DEFINITION DEFERRED.
CLASS LCL_EVENT_MATERIAL DEFINITION DEFERRED.

DATA: GO_EVENT_RECEIVER TYPE REF TO LCL_EVENT_RECEIVER.
DATA: GO_EVENT_PRODUCTO TYPE REF TO LCL_EVENT_PRODUCTO.
DATA: GO_EVENT_MAQUILERO TYPE REF TO LCL_EVENT_MAQUILERO.
DATA: GO_EVENT_CLIENTE TYPE REF TO LCL_EVENT_CLIENTE.
DATA: GO_EVENT_MATERIAL TYPE REF TO LCL_EVENT_MATERIAL.

DATA SCREEN_WA TYPE SCREEN.

*---------------------------------------------------------------------------
*---------------------------------------------------------------------------
*---------------------------------------------------------------------------
CLASS LCL_EVENT_ENT_MATERIAL DEFINITION DEFERRED.

DATA: GO_EVENT_ENT_MATERIAL TYPE REF TO LCL_EVENT_ENT_MATERIAL.

*---------------------------------------------------------------------------

CLASS LCL_EVENT_ENT_PRODUCTO DEFINITION DEFERRED.

DATA: GO_EVENT_ENT_PROD TYPE REF TO LCL_EVENT_ENT_PRODUCTO.
*---------------------------------------------------------------------------

CLASS LCL_EVENT_DEV_PRODUCTO DEFINITION DEFERRED.

DATA: GO_EVENT_DEV_PROD TYPE REF TO LCL_EVENT_DEV_PRODUCTO.

*---------------------------------------------------------------------------

CLASS LCL_EVENT_SAL_PRODUCTO DEFINITION DEFERRED.

DATA: GO_EVENT_SAL_PROD TYPE REF TO LCL_EVENT_SAL_PRODUCTO.

*---------------------------------------------------------------------------

CLASS LCL_EVENT_SAL_MATERIAL DEFINITION DEFERRED.

DATA: GO_EVENT_SAL_MATERIAL TYPE REF TO LCL_EVENT_SAL_MATERIAL.


*-----REFERENCIA DE TABLAS----
TABLES: ZTC_MATERIALES,
        ZTC_PRODUCTOS,
        ZTC_PROVEEDORES,
        ZTC_EMPLEADOS,
        ZTC_CLIENTES,
        ZTC_ENT_PRODUCTO,
        ZTC_SAL_PRODUCTO,
        ZTC_ENT_MATERIAL,
        ZTC_SAL_MATERIAL,
        ZTC_BUSQUEDA,
        ZTC_ENT_MAT_DETA.


*-------------Variable para manejar insertar/modificar/eliminar------------
DATA: gv_max TYPE N LENGTH 10,"para almacenar y manejar el ID
      res TYPE i,
      su TYPE I."para usarlo en la suma al ID y regresarle el nuevo valor

*-------Tablas internas------------------------
DATA: gwa_mat TYPE ZTC_MATERIALES,
      gt_mat  type STANDARD TABLE OF ZTC_MATERIALES, "Para realizar el registro en tabla
      gwa_prod TYPE ZTC_PRODUCTOS,
      gt_prod TYPE STANDARD TABLE OF ZTC_PRODUCTOS,
      gwa_prov TYPE ZTC_PROVEEDORES,
      gwa_provs TYPE ZTE_PROVEEDORES,
      gt_prov TYPE STANDARD TABLE OF ZTC_PROVEEDORES,
      gwa_emp TYPE ztc_empleados,
      gwa_emps TYPE zte_empleados,
      gt_emp TYPE STANDARD TABLE OF ztc_empleados,
      gwa_client TYPE ztc_clientes,
      gwa_clients TYPE zte_clientes,
      gt_client TYPE STANDARD TABLE OF ztc_clientes.

DATA: gwa_ma TYPE ZTC_MATERIALES. "Para realizar el registro en tabla

*-----------------Para funciones estandar-------
*------Creo que tiene lo de carga de excel
DATA: p_arch LIKE rlgrap-filename.

DATA: GT_ARCH TYPE STANDARD TABLE OF alsmex_tabline,
      GWA_ARCH LIKE LINE OF gt_arch.

DATA masc TYPE char40.

*-------Variables necesarias para las validaciones-----------------
DATA: lt_match_result TYPE match_result_tab."Esta variable de busqueda de coincidencias dentro del texto
data: l_regex type string, "Almacena el texto que se esta buscando
      l_string type string. "Es la variable que almacena el texto en donde se estan buscando la coincidencias
data: l_matches TYPE i. "Analiza el numero de repeticiones que se da en la busqueda


*---------------Para los filtros------------------
DATA: reg_prod TYPE abap_bool.

DATA: tt_prod TYPE STANDARD TABLE OF ztc_productos,
      twa_prod LIKE LINE OF tt_prod.

DATA: dexcel TYPE I.

DATA er TYPE i.
DATA: tc TYPE string.


*---------------------------------------------------------------
*---------------------------------------------------------------
*---------------------------------------------------------------
*-------Pruebas para cambios de datos entre tablas--------------
*---------------------------------------------------------------
*----------------Entrada Materiales------------------------------
DATA: T_ENT_MATT TYPE TABLE OF ztt_ent_mat,
      T_ENT_MATC TYPE TABLE OF ztc_ent_mat_deta,
      S_ENT_MATT TYPE ztt_ent_mat,
      S_ENT_MATC TYPE ztc_ent_mat_deta.

DATA: lt_ent_mat TYPE TABLE OF ZTT_ENT_MAT,
      lt_materiales TYPE TABLE OF ZTC_MATERIALES,
      lt_result TYPE TABLE OF ZTC_MATERIALES,
      ls_ent_mat TYPE ZTT_ENT_MAT,
      ls_materiales TYPE ZTC_MATERIALES,
      lv_id     TYPE NUMC10, " Tipo de dato del identificador
      lv_suma   TYPE I.      " Tipo de dato de la suma

DATA: mlt_ent_mat TYPE TABLE OF ztt_ent_mat,
      mls_ent_mat TYPE ztt_ent_mat,
      mls_tc_ent_materiales TYPE ztc_ent_material.
*---------------------------------------------------------------
*----------------Salida Materiales-----------------------------
DATA: T_SAL_MATT TYPE TABLE OF ztt_sal_mat,
      T_SAL_MATC TYPE TABLE OF ztc_sal_mat_deta,
      S_SAL_MATT TYPE ztt_sal_mat,
      S_SAL_MATC TYPE ztc_sal_mat_deta.

DATA: lt_sal_mat TYPE TABLE OF ztt_sal_mat,
      lt_sal_materiales TYPE TABLE OF ZTC_MATERIALES,
      lt_sal_result TYPE TABLE OF ZTC_MATERIALES,
      ls_sal_mat TYPE ztt_sal_mat,
      ls_sal_materiales TYPE ZTC_MATERIALES,
      lv_sal_mat_id     TYPE NUMC10, " Tipo de dato del identificador
      lv_sal_mat_resta   TYPE I.      " Tipo de dato de la suma


DATA: mlt_sal_mat TYPE TABLE OF ztt_sal_mat,
      mls_sal_mat TYPE ztt_sal_mat,
      mls_tc_sal_materiales TYPE ztc_sal_material.

*---------------------------------------------------------------
*----------------ENTRADA PRODUCTOS------------------------------
DATA: T_ENT_PROT TYPE TABLE OF ztt_ent_pro,
      T_ENT_PROC TYPE TABLE OF ztc_ent_pro_deta,
      S_ENT_PROT TYPE ztt_ent_pro,
      S_ENT_PROC TYPE ztc_ent_pro_deta.
*---------------------------------------------------------------
*----------------DEVOLUCION PRODUCTOS---------------------------
DATA: T_DEV_PROT TYPE TABLE OF ztt_dev_producto,
      T_DEV_PROC TYPE TABLE OF ztc_dev_producto,
      S_DEV_PROT TYPE ztt_dev_producto,
      S_DEV_PROC TYPE ztc_dev_producto.

DATA: T_TAB_MAT TYPE TABLE OF ztc_materiales,
      S_TAB_MAT TYPE ztc_materiales.
*---------------------------------------------------------------
*----------Para actualizar el campo de productos en existencia
DATA: lt_ent_pro TYPE TABLE OF ztt_ent_pro,
      lt_ent_productos TYPE TABLE OF ztc_productos,
      lt_ent_pro_result TYPE TABLE OF ztc_productos,
      ls_ent_pro TYPE ztt_ent_pro,
      ls_ent_productos TYPE ztc_productos,
      lv_ent_pro_id     TYPE NUMC10, " Tipo de dato del identificador
      lv_ent_pro_suma   TYPE I.      " Tipo de dato de la suma

*---------------------------------------------------------------
*----------Para actualizar el campo de materiales
DATA: lt_ent_pro_mat        TYPE TABLE OF ztt_dev_producto,
      lt_ent_productos_mat  TYPE TABLE OF ztc_materiales,
      lt_ent_pro_result_mat TYPE TABLE OF ztc_materiales,
      ls_ent_pro_mat        TYPE ztt_dev_producto,
      ls_ent_productos_mat  TYPE ztc_materiales,
      lv_ent_pro_id_mat     TYPE NUMC10, " Tipo de dato del identificador
      lv_ent_pro_suma_mat   TYPE I.      " Tipo de dato de la suma

DATA: mlt_ent_pro TYPE TABLE OF ztt_ent_pro,
      mls_ent_pro TYPE ztt_ent_pro,
      mls_tc_ent_productos TYPE ztc_ent_producto.

DATA: SUM_DEV_PRO TYPE I,
      SUM_GEN_ENT_PRO TYPE I.

DATA: TYPE_SUM_ENT_PRO TYPE ABAP_BOOL,
      TYPE_SUM_DEV_PRO TYPE ABAP_BOOL.

DATA: INITIALS_FOLIO TYPE ABAP_BOOL,
      INITIALS_ENT_PRO TYPE ABAP_BOOL,
      INITIALS_DEV_PRO TYPE ABAP_BOOL.
*---------------------------------------------------------------
*------------------Salida Productos-----------------------------
DATA: T_SAL_PROT TYPE TABLE OF ztt_sal_pro,
      T_SAL_PROC TYPE TABLE OF ztc_sal_pro_deta,
      S_SAL_PROT TYPE ztt_sal_pro,
      S_SAL_PROC TYPE ztc_sal_pro_deta.

DATA: lt_sal_pro TYPE TABLE OF ztt_sal_pro,
      lt_sal_productos TYPE TABLE OF ztc_productos,
      lt_sal_pro_result TYPE TABLE OF ztc_productos,
      ls_sal_pro TYPE ztt_sal_pro,
      ls_sal_productos TYPE ztc_productos,
      lv_sal_pro_id     TYPE NUMC10, " Tipo de dato del identificador
      lv_sal_pro_resta   TYPE I.      " Tipo de dato de la suma


DATA: mlt_sal_pro TYPE TABLE OF ztt_sal_pro,
      mls_sal_pro TYPE ztt_sal_pro,
      mls_tc_sal_productos TYPE ztc_sal_producto.

*---------------------------------------------------------------
*---------------------------------------------------------------
*---------------------------------------------------------------
*---------------------------------------------------------------

DATA: li_fieldcat TYPE slis_t_fieldcat_alv,
      lwa_layout  TYPE slis_layout_alv.

DATA: GWA_PRUEBA1 TYPE ZTC_ENT_MATERIAL,
      GWA_PRUEBA2 TYPE ZTC_ENT_MAT_DETA.

*----------------Para las demas ------------------------------
*-------------ALV de ENTRADAS-SALIDAS-------------------------

TABLES: ZTT_ENT_MAT,
        ZTT_SAL_MAT,
        ZTT_ENT_PRO,
        ZTT_SAL_PRO,
        ZTT_DEV_PRODUCTO.

DATA: C_CONTAINER_ENT_SAL TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GALV_GRID_ENT_SAL TYPE REF TO CL_GUI_ALV_GRID.

DATA: C_CONTAINER_ENT_SAL2 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GALV_GRID_ENT_SAL2 TYPE REF TO CL_GUI_ALV_GRID.

DATA: GT_FIELDCAT_ENT_MAT TYPE lvc_t_fcat, " DIFERENTE PARA CADA UNA
      GT_FIELDCAT_SAL_MAT TYPE lvc_t_fcat,
      GT_FIELDCAT_ENT_PRO TYPE lvc_t_fcat,
      GT_FIELDCAT_SAL_PRO TYPE lvc_t_fcat,
      GT_FIELDCAT_DEV_PRO TYPE lvc_t_fcat.
***************************************************************

TYPES: BEGIN OF GTY_ENT_MAT,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTT_ENT_MAT.
TYPES    END OF GTY_ENT_MAT.
DATA: GT_ENT_MAT TYPE TABLE OF GTY_ENT_MAT.


TYPES: BEGIN OF GTY_SAL_MAT,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTT_SAL_MAT.
TYPES    END OF GTY_SAL_MAT.
DATA: GT_SAL_MAT TYPE TABLE OF GTY_SAL_MAT.

TYPES: BEGIN OF GTY_ENT_PRO,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTT_ENT_PRO.
TYPES    END OF GTY_ENT_PRO.
DATA: GT_ENT_PRO TYPE TABLE OF GTY_ENT_PRO.

TYPES: BEGIN OF GTY_SAL_PRO,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTT_SAL_PRO.
TYPES    END OF GTY_SAL_PRO.
DATA: GT_SAL_PRO TYPE TABLE OF GTY_SAL_PRO.

TYPES: BEGIN OF GTY_DEV_PRO,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTT_DEV_PRODUCTO.
TYPES  END OF  GTY_DEV_PRO.
DATA: GT_DEV_PRO TYPE TABLE OF GTY_DEV_PRO.

DATA: GS_LAYOUT_ENT_SAL TYPE LVC_S_LAYO.
DATA: GS_LAYOUT_ENT_SAL2 TYPE LVC_S_LAYO.

****************************************************************

FIELD-SYMBOLS: <LS_FIELDCAT_ENT_SAL> TYPE LVC_S_FCAT,
               <LS_FIELDCAT_ENT_SAL2> TYPE LVC_S_FCAT,
               <LS_ENT_MAT> TYPE GTY_ENT_MAT,
               <LS_SAL_MAT> TYPE GTY_SAL_MAT,
               <LS_ENT_PRO> TYPE GTY_ENT_PRO,
               <LS_SAL_PRO> TYPE GTY_SAL_PRO,
               <LS_DEV_PRO> TYPE GTY_DEV_PRO.
*               <LS_MAQ> TYPE GTY_MAQ,
*               <LS_CLI> TYPE GTY_CLI.

*********************************************************************

DATA LS_STYLE_ENT_SAL TYPE LVC_S_STYL.
DATA LS_STYLE_ENT_SAL2 TYPE LVC_S_STYL.

*---------------------------------------------------------------------------
DATA: gtt_ent_mat TYPE TABLE OF ZTT_ENT_MAT.
*---------------------------------------------------------------------------
*---------------------------------------------------------------------------
*---------------------------------------------------------------------------
*---------------------------------------------------------------------------

DATA: GWA_ENT_MAT TYPE ZTT_ENT_MAT,
      GWA_SAL_MAT TYPE ZTT_SAL_MAT,
      GWA_ENT_PRO TYPE ZTT_ENT_PRO,
      GWA_DEV_ENT_PRO TYPE ZTT_DEV_PRODUCTO,
      GWA_SAL_PRO TYPE ZTT_SAL_PRO.

*---------------------------------------------------------------------------
*---------------------------------------------------------------------------
*---------------------------------------------------------------------------
*---------------------------------------------------------------------------



*---------------------------------------------------------------------------
*-----------Variable global para limpiar movimientos------------------------
DATA: DYN_MOV TYPE STRING.
*-----------Variable global para SABER SI ES MENOR A 0------------------------
data fgl type abap_bool.
*---------------------------------------------------------------------------
*---------------------------------------------------------------------------
*************************************************************





*_______________________________________________________________________________
********************************************************************************
*_______________________________________________________________________________

TABLES: ZTE_MATERIALES,
        ZTE_PRODUCTOS,
        ZTE_PROVEEDORES,
        ZTE_EMPLEADOS,
        ZTE_CLIENTES.

DATA: C_CONTAINER_EXCEL TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GALV_GRID_EXCEL TYPE REF TO CL_GUI_ALV_GRID.

DATA: GT_FIELDCAT_MAT_EXC TYPE lvc_t_fcat,
      GT_FIELDCAT_PRO_EXC TYPE lvc_t_fcat,
      GT_FIELDCAT_PROV_EXC TYPE lvc_t_fcat,
      GT_FIELDCAT_EMP_EXC TYPE lvc_t_fcat,
      GT_FIELDCAT_CLI_EXC TYPE lvc_t_fcat.

TYPES: BEGIN OF GTY_MAT_EXC,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTE_MATERIALES.
TYPES  END OF   GTY_MAT_EXC.
DATA: GT_MAT_EXC TYPE TABLE OF GTY_MAT_EXC.

TYPES: BEGIN OF GTY_PRO_EXC,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTE_PRODUCTOS.
TYPES  END OF   GTY_PRO_EXC.
DATA: GT_PRO_EXC TYPE TABLE OF GTY_PRO_EXC.

TYPES: BEGIN OF GTY_PROV_EXC,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTE_PROVEEDORES.
TYPES  END OF   GTY_PROV_EXC.
DATA: GT_PROV_EXC TYPE TABLE OF GTY_PROV_EXC.

TYPES: BEGIN OF GTY_EMP_EXC,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTE_EMPLEADOS.
TYPES  END OF   GTY_EMP_EXC.
DATA: GT_EMP_EXC TYPE TABLE OF GTY_EMP_EXC.

TYPES: BEGIN OF GTY_CLI_EXC,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTE_CLIENTES.
TYPES  END OF   GTY_CLI_EXC.
DATA: GT_CLI_EXC TYPE TABLE OF GTY_CLI_EXC.

DATA: GS_LAYOUT_EXCEL TYPE LVC_S_LAYO.

FIELD-SYMBOLS: <LS_FIELDCAT_EXCEL> TYPE LVC_S_FCAT,
               <LS_MAT_EXC> TYPE GTY_MAT_EXC,
               <LS_PRO_EXC> TYPE GTY_PRO_EXC,
               <LS_PROV_EXC> TYPE GTY_PROV_EXC,
               <LS_EMP_EXC> TYPE GTY_EMP_EXC,
               <LS_CLI_EXC> TYPE GTY_CLI_EXC.

DATA LS_STYLE_EXCEL TYPE LVC_S_STYL.

* _______________________________________________________________________
* _______________________________________________________________________
* _______________________________________________________________________
* _______________________________________________________________________

CLASS LCL_EVENT_VIEP DEFINITION DEFERRED.
CLASS LCL_EVENT_VIEM DEFINITION DEFERRED.
CLASS LCL_EVENT_VISP DEFINITION DEFERRED.
CLASS LCL_EVENT_VISM DEFINITION DEFERRED.

DATA: GO_EVENT_VIEP TYPE REF TO LCL_EVENT_VIEP.
DATA: GO_EVENT_VIEM TYPE REF TO LCL_EVENT_VIEM.
DATA: GO_EVENT_VISP TYPE REF TO LCL_EVENT_VISP.
DATA: GO_EVENT_VISM TYPE REF TO LCL_EVENT_VISM.

* _______________________________________________________________________
* _______________________________________________________________________
* _______________________________________________________________________
* _______________________________________________________________________

DATA: C_CONTAINER_DETA TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GALV_GRID_DETA TYPE REF TO CL_GUI_ALV_GRID.

DATA: GT_FIELDCAT_EM TYPE lvc_t_fcat,
      GT_FIELDCAT_EP TYPE lvc_t_fcat,
      GT_FIELDCAT_SM TYPE lvc_t_fcat,
      GT_FIELDCAT_SP TYPE lvc_t_fcat.

TYPES: BEGIN OF GTY_EMD,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_ENT_MAT_DETA.
TYPES  END OF   GTY_EMD.
DATA: GT_EMD TYPE TABLE OF GTY_EMD.

TYPES: BEGIN OF GTY_EPD,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_ENT_PRO_DETA.
TYPES  END OF   GTY_EPD.
DATA: GT_EPD TYPE TABLE OF GTY_EPD.

TYPES: BEGIN OF GTY_SMD,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_SAL_MAT_DETA.
TYPES  END OF   GTY_SMD.
DATA: GT_SMD TYPE TABLE OF GTY_SMD.

TYPES: BEGIN OF GTY_SPD,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_SAL_PRO_DETA.
TYPES  END OF   GTY_SPD.
DATA: GT_SPD TYPE TABLE OF GTY_SPD.

DATA: GS_LAYOUT_DETA TYPE LVC_S_LAYO.

FIELD-SYMBOLS: <LS_FIELDCAT_DETA> TYPE LVC_S_FCAT,
               <LS_EM> TYPE GTY_EMD,
               <LS_EP> TYPE GTY_EPD,
               <LS_SM> TYPE GTY_SMD,
               <LS_SP> TYPE GTY_SPD.

DATA LS_STYLE_DETA TYPE LVC_S_STYL.

* _______________________________________________________________________________
* _______________________________________________________________________________
* _______________________________________________________________________________
* _______________________________________________________________________________

DATA: C_CONTAINER_DETA2 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GALV_GRID_DETA2 TYPE REF TO CL_GUI_ALV_GRID.

DATA: GT_FIELDCAT_DEV TYPE lvc_t_fcat.

TYPES: BEGIN OF GTY_DEV,
                BBDD TYPE ABAP_BOOL,
                FIELD_STYLE TYPE LVC_T_STYL.
                INCLUDE STRUCTURE ZTC_DEV_PRODUCTO.
TYPES  END OF   GTY_DEV.
DATA: GT_DEV TYPE TABLE OF GTY_DEV.

DATA: GS_LAYOUT_DETA2 TYPE LVC_S_LAYO.

FIELD-SYMBOLS: <LS_FIELDCAT_DETA2> TYPE LVC_S_FCAT,
               <LS_DEV> TYPE GTY_DEV.

DATA LS_STYLE_DETA2 TYPE LVC_S_STYL.

* _______________________________________________________________________________
* _______________________________________________________________________________
* _______________________________________________________________________________
* _______________________________________________________________________________
DATA: T_EXC_PROVT TYPE TABLE OF zte_proveedores,
      T_EXC_PROVC TYPE TABLE OF ztc_proveedores,
      S_EXC_PROVT TYPE zte_proveedores,
      S_EXC_PROVC TYPE ztc_proveedores.

DATA: T_EXC_EMPT TYPE TABLE OF zte_empleados,
      T_EXC_EMPC TYPE TABLE OF ztc_empleados,
      S_EXC_EMPT TYPE zte_empleados,
      S_EXC_EMPC TYPE ztc_empleados.

DATA: T_EXC_CLIT TYPE TABLE OF zte_clientes,
      T_EXC_CLIC TYPE TABLE OF ztc_clientes,
      S_EXC_CLIT TYPE zte_clientes,
      S_EXC_CLIC TYPE ztc_clientes.

DATA: T_EXC_MATT TYPE TABLE OF ZTE_MATERIALES,
      T_EXC_MATC TYPE TABLE OF ZTC_MATERIALES,
      S_EXC_MATT TYPE ZTE_MATERIALES,
      S_EXC_MATC TYPE ZTC_MATERIALES.

DATA: T_EXC_PROT TYPE TABLE OF ZTE_PRODUCTOS,
      T_EXC_PROC TYPE TABLE OF ZTC_PRODUCTOS,
      S_EXC_PROT TYPE ZTE_PRODUCTOS,
      S_EXC_PROC TYPE ZTC_PRODUCTOS.

**********************************************************************************************
**********************************************************************************************
**********************************************************************************************
**********************************************************************************************
**********************************************************************************************
**********************************************************************************************

  DATA: LV_DESCRIPCION TYPE ZTC_MATERIALES-descripcion,
        LV_COLOR TYPE ZTC_MATERIALES-color.

  DATA: LV_DESCRIPCION2 TYPE ZTC_MATERIALES-descripcion,
        LV_COLOR2 TYPE ZTC_MATERIALES-color.

  DATA: LV_DESCRIPCION3 TYPE ZTC_PRODUCTOS-descripcion,
        LV_COLOR3 TYPE ZTC_PRODUCTOS-color,
        LV_TALLA3 TYPE ZTC_PRODUCTOS-talla.

  DATA: LV_DESCRIPCION4 TYPE ZTC_PRODUCTOS-descripcion,
        LV_COLOR4 TYPE ZTC_PRODUCTOS-color,
        LV_TALLA4 TYPE ZTC_PRODUCTOS-talla,
        LV_PRECIO4 TYPE ZTC_PRODUCTOS-precio.

  DATA: LV_DESCRIPCION22 TYPE ZTC_MATERIALES-descripcion,
        LV_COLOR22 TYPE ZTC_MATERIALES-color.

  DATA: LV_NOMBRE TYPE ZTC_PROVEEDORES-nombre,
        LV_APE TYPE ZTC_PROVEEDORES-apellido_paterno.

  DATA: LV_ID_EMPLEADO TYPE ZTT_ENT_PRO-id_empleado,
        LV_NOMBRE2 TYPE ZTC_EMPLEADOS-nombre,
        LV_APELLIDO2 TYPE ZTC_EMPLEADOS-apellido_paterno.

  DATA: LV_NOMBRE3 TYPE ZTC_EMPLEADOS-nombre,
        LV_APE3 TYPE ZTC_EMPLEADOS-apellido_paterno.

  DATA: LV_NOMBRE4 TYPE ZTC_CLIENTES-nombre,
        LV_APE4 TYPE ZTC_CLIENTES-apellido_paterno.
