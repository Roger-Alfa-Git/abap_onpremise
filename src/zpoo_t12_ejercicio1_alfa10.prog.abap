*&---------------------------------------------------------------------*
*& Report ZPOO_T12_EJERCICIO1_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t12_ejercicio1_alfa10.

CLASS lcl_context DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: get_instancia RETURNING VALUE(instancia) TYPE REF TO lcl_context.
  PRIVATE SECTION.
    DATA: objeto TYPE REF TO lcl_context.
ENDCLASS.

CLASS lcl_context IMPLEMENTATION.
  METHOD get_instancia.
    IF instancia IS NOT BOUND.
      CREATE OBJECT instancia.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: lr_instanicia  TYPE REF TO lcl_context,
        lr_instanicia2 TYPE REF TO lcl_context.

START-OF-SELECTION.

  lr_instanicia = lcl_context=>get_instancia( ).

  lr_instanicia2 = lcl_context=>get_instancia( ).

  IF lr_instanicia IS NOT INITIAL AND lr_instanicia2 IS NOT INITIAL.
    IF lr_instanicia EQ lr_instanicia2.
      WRITE: / 'Los objetos Singleton iguales'.
    ELSE.
      WRITE: / 'Los objetos Singleton diferentes.'.
    ENDIF.
  ELSE.
    WRITE: / 'Error al obtener las instancias del Singleton.'.
  ENDIF.
