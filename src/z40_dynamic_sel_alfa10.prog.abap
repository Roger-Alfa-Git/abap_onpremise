*&---------------------------------------------------------------------*
*& Report Z40_DYNAMIC_SEL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z40_dynamic_sel_alfa10.

PARAMETERS: pa_tabla TYPE c LENGTH 16,
            pa_col   TYPE c LENGTH 50,
            pa_donde TYPE c LENGTH 50.

FIELD-SYMBOLS <gt_itab> TYPE STANDARD TABLE.

DATA: gr_tref       TYPE REF TO data,
      grx_excepcion TYPE REF TO cx_root.

TRY.

    DATA(gr_comp_tabla) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( pa_tabla ) )->get_components( ).

    DATA(gr_estruc_tipo) = cl_abap_structdescr=>create( gr_comp_tabla ).

    DATA(gr_tabla_tipo) = cl_abap_tabledescr=>create( gr_estruc_tipo ).

    CREATE DATA gr_tref TYPE HANDLE gr_tabla_tipo.

    ASSIGN gr_tref->* TO <gt_itab>.

    SELECT (pa_col) FROM (pa_tabla)
      INTO CORRESPONDING FIELDS OF TABLE <gt_itab>
      WHERE (pa_donde).

  CATCH cx_root INTO grx_excepcion.
    WRITE: / grx_excepcion->get_text( ).
ENDTRY.

IF <gt_itab> IS NOT INITIAL.
  cl_demo_output=>display( <gt_itab> ).
ENDIF.


*//////////Ejercicio del video//////////////////////////////////////////////////////////////////////////////////////
*PARAMETERS: pa_table TYPE c LENGTH 16,
*            pa_col   TYPE c LENGTH 50,
*            pa_where TYPE c LENGTH 50.
*
*FIELD-SYMBOLS <gt_itab> TYPE STANDARD TABLE.
*
*DATA: gr_tref       TYPE REF TO data,
*      grx_exception TYPE REF TO cx_root.
*
*TRY.
*
*    DATA(gr_comp_table) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( pa_table ) )->get_components( ).
*
*    DATA(gr_struct_type) = cl_abap_structdescr=>create( gr_comp_table ).
*
*    DATA(gr_table_type) = cl_abap_tabledescr=>create( gr_struct_type ).
*
*    CREATE DATA gr_tref TYPE HANDLE gr_table_type.
*
*    ASSIGN gr_tref->* TO <gt_itab>.
*
*    SELECT (pa_col) FROM (pa_table)
*      INTO CORRESPONDING FIELDS OF TABLE <gt_itab>
*      WHERE (pa_where).
*
*  CATCH cx_root INTO grx_exception.
*    WRITE: / grx_exception->get_text( ).
*ENDTRY.
*
*IF <gt_itab> IS NOT INITIAL.
*  cl_demo_output=>display( <gt_itab> ).
*ENDIF.
