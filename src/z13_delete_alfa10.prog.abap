*&---------------------------------------------------------------------*
*& Report Z13_DELETE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z13_delete_alfa10.

DELETE FROM zscarr_alfa10
WHERE carrid IN ( 'AB', 'JL' ).

IF sy-subrc EQ 0.
  WRITE: / 'Se han eliminado los registros'.
ELSE.
  WRITE: / 'NO se han eliminado los registros'.
ENDIF.
