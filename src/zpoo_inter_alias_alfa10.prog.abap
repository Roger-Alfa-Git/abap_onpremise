*&---------------------------------------------------------------------*
*& Report ZPOO_INTER_ALIAS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_inter_alias_alfa10.

INTERFACE if_grupo.
  METHODS establecer_grupo.
ENDINTERFACE.

INTERFACE if_sociedad.
  INTERFACES if_grupo.
  METHODS establecer_tipo_sociedad.
  ALIASES grupo FOR if_grupo~establecer_grupo.
ENDINTERFACE.

CLASS bp DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_sociedad.

    ALIASES tipo_sociedad FOR if_sociedad~establecer_tipo_sociedad.
ENDCLASS.

CLASS bp IMPLEMENTATION.
  METHOD tipo_sociedad.
    WRITE: / 'Sociedad Petrolera'.
  ENDMETHOD.
  METHOD if_sociedad~grupo.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_bp TYPE REF TO bp.

  CREATE OBJECT: gr_bp.

  gr_bp->tipo_sociedad( ).

  gr_bp->if_sociedad~establecer_tipo_sociedad( ).
