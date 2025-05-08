*&---------------------------------------------------------------------*
*& Report ZPOO_RESUMABLE_ALFA1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_resumable_alfa1.

CLASS lcx_tarjeta_caducada DEFINITION INHERITING FROM cx_static_check.
  PUBLIC SECTION.
    CONSTANTS: lcx_tarjeta_caducada TYPE string VALUE 'Su tarjeta es caducada y detenida por el cajero'.
ENDCLASS.

CLASS lcx_saldo_insuficiente DEFINITION INHERITING FROM cx_static_check.
  PUBLIC SECTION.
    CONSTANTS: lcx_saldo_insuficiente TYPE string VALUE 'Saldo insuficiente en su cuenta'.
ENDCLASS.

CLASS lcl_banco DEFINITION.
  PUBLIC SECTION.
    METHODS: validar_cuenta IMPORTING tarjeta       TYPE string
                                      importe       TYPE i
                                      cuenta_ahorro TYPE abap_bool OPTIONAL
                            RAISING   lcx_tarjeta_caducada RESUMABLE(lcx_saldo_insuficiente).
ENDCLASS.

CLASS lcl_banco IMPLEMENTATION.
  METHOD validar_cuenta.
    WRITE: / 'Comprobando Validez de la tarjeta'.
    IF tarjeta EQ '1111 2222 3333 4444'.
      RAISE EXCEPTION TYPE lcx_tarjeta_caducada.
    ENDIF.

    WRITE: / 'Comprobando Saldo en la cuenta'.

    IF importe GE 50.
      IF cuenta_ahorro EQ abap_true.
        RAISE RESUMABLE EXCEPTION TYPE lcx_saldo_insuficiente.
        WRITE: / 'Despues del levantamiento de RESUMABLE'.
      ELSE.
        RAISE EXCEPTION TYPE lcx_saldo_insuficiente.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_cajero DEFINITION.
  PUBLIC SECTION.
    METHODS: retirar_dinero IMPORTING tarjeta       TYPE string
                                      importe       TYPE i
                                      cuenta_ahorro TYPE abap_bool OPTIONAL.
ENDCLASS.


CLASS lcl_cajero IMPLEMENTATION.
  METHOD retirar_dinero.
    DATA: lo_banco       TYPE REF TO lcl_banco,
          lcx_exepciones TYPE REF TO cx_root.
    CREATE OBJECT lo_banco.
    TRY.
        lo_banco->validar_cuenta( tarjeta       = tarjeta
                                  importe       = importe
                                  cuenta_ahorro = cuenta_ahorro ).
        WRITE: / 'Recoge los billetes'.
        WRITE: / 'Operacion finalizada con exito'.
      CATCH               lcx_tarjeta_caducada.
        WRITE: / lcx_tarjeta_caducada=>lcx_tarjeta_caducada.
      CATCH BEFORE UNWIND lcx_saldo_insuficiente INTO lcx_exepciones.
        IF lcx_exepciones->is_resumable EQ abap_true.
          WRITE: / 'Retirar dinero de la cuenta ahorro'.
          RESUME.
        ELSE.
          WRITE: / 'Saldo insuficiente en la cuenta corriente'.
        ENDIF.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gcl_cajero TYPE REF TO lcl_cajero.

  CREATE OBJECT: gcl_cajero.

  WRITE: / 'Caso 1- Tarjeta Caducada'. SKIP.

  gcl_cajero->retirar_dinero(
    EXPORTING
      tarjeta       = '1111 2222 3333 4444'
      importe       = 30
*      cuenta_ahorro =
  ).

  SKIP 3.

  WRITE: / 'Caso 2- Saldo insuficiente'. SKIP.

  gcl_cajero->retirar_dinero(
    EXPORTING
      tarjeta       = '1111 2222 3333 5555'
      importe       = 100
*      cuenta_ahorro =
  ).

  SKIP 3.

  WRITE: / 'Caso 3- Retirando dinero de la cuenta de ahorro'. SKIP.

  gcl_cajero->retirar_dinero(
    EXPORTING
      tarjeta       = '1111 2222 3333 5555'
      importe       = 100
      cuenta_ahorro = abap_true
  ).
