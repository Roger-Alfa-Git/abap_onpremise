*&---------------------------------------------------------------------*
*& Report ZPOO_MULTI_INTERF_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_multi_interf_alfa10.

INTERFACE if_unidad_metrica.
  METHODS: dimensiones_und_metrica.
ENDINTERFACE.

INTERFACE if_unidad_inglesa.
  METHODS: dimensiones_und_inglesa.
ENDINTERFACE.

CLASS pantalla DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_unidad_metrica, if_unidad_inglesa.

    METHODS: constructor IMPORTING unidad_inglesa TYPE decfloat16.

  PRIVATE SECTION.
    DATA: unidad_ingles TYPE decfloat16.
ENDCLASS.

CLASS pantalla IMPLEMENTATION.
  METHOD constructor.
    me->unidad_ingles = unidad_inglesa.
  ENDMETHOD.

  METHOD if_unidad_metrica~dimensiones_und_metrica.
    DATA: lv_und_metrica TYPE decfloat16.

    lv_und_metrica = unidad_ingles * '2.54'.

    WRITE: / 'Unidad metrica = ',lv_und_metrica.
  ENDMETHOD.

  METHOD if_unidad_inglesa~dimensiones_und_inglesa.
    WRITE: / 'Unidad Inglesa = ', me->unidad_ingles.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_pantalla TYPE REF TO pantalla.

  CREATE OBJECT gr_pantalla
    EXPORTING
      unidad_inglesa = 22.

  gr_pantalla->if_unidad_metrica~dimensiones_und_metrica( ).

  gr_pantalla->if_unidad_inglesa~dimensiones_und_inglesa( ).
