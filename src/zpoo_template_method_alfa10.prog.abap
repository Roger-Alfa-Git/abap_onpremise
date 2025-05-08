*&---------------------------------------------------------------------*
*& Report ZPOO_TEMPLATE_METHOD_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_template_method_alfa10.

CLASS lcl_juego DEFINITION ABSTRACT.
  PROTECTED SECTION.
    DATA: contador_jugadores TYPE i.

    METHODS: inicializar_juego ABSTRACT,
      crear_juego ABSTRACT IMPORTING jugador TYPE i,
      finalizar_juego ABSTRACT RETURNING VALUE(finalizado) TYPE abap_bool,
      imprimir_ganador ABSTRACT,
      jugar FINAL IMPORTING jugadores TYPE i.
ENDCLASS.

CLASS lcl_juego IMPLEMENTATION.
  METHOD jugar.
    DATA: lv_jugador TYPE i.
    me->contador_jugadores = jugadores.
    inicializar_juego( ).
    WHILE finalizar_juego( ) NE abap_false.
      crear_juego( jugador = lv_jugador ).
      lv_jugador = lv_jugador + 1.
    ENDWHILE.
    imprimir_ganador( ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_monopoly DEFINITION INHERITING FROM lcl_juego.
  PROTECTED SECTION.
    METHODS: inicializar_juego REDEFINITION,
      crear_juego REDEFINITION,
      finalizar_juego REDEFINITION,
      imprimir_ganador REDEFINITION.
ENDCLASS.

CLASS lcl_monopoly IMPLEMENTATION.
  METHOD inicializar_juego.

  ENDMETHOD.

  METHOD crear_juego.

  ENDMETHOD.

  METHOD finalizar_juego.
  ENDMETHOD.

  METHOD imprimir_ganador.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_ajedrez DEFINITION INHERITING FROM lcl_juego.
  PROTECTED SECTION.
    METHODS: inicializar_juego REDEFINITION,
      crear_juego REDEFINITION,
      finalizar_juego REDEFINITION,
      imprimir_ganador REDEFINITION.
ENDCLASS.

CLASS lcl_ajedrez IMPLEMENTATION.
  METHOD inicializar_juego.

  ENDMETHOD.

  METHOD crear_juego.

  ENDMETHOD.

  METHOD finalizar_juego.
  ENDMETHOD.

  METHOD imprimir_ganador.

  ENDMETHOD.
ENDCLASS.
