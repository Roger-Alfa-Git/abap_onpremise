*&---------------------------------------------------------------------*
*& Report Z07_UPDATE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z07_update_alfa10.

UPDATE zscarr_alfa10 SET: currcode = 'USD'
                         WHERE carrid EQ 'LH',
                         currcode = 'USD'
                         WHERE carrid EQ 'NG'.

IF sy-subrc EQ 0.
  WRITE: / 'SE HAN ACTUALIZADO TODOS LOS REGISTROS'.
ELSE.
  WRITE: / 'NO SE HAN ACTUALIZADO TODOS LOS REGISTROS'.
ENDIF.
