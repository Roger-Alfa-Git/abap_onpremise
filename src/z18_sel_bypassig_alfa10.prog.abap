*&---------------------------------------------------------------------*
*& Report Z18_SEL_BYPASSIG_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z18_sel_bypassig_alfa10.
DATA: gwa_paises TYPE t005.

SELECT SINGLE * FROM t005 BYPASSING BUFFER
  INTO gwa_paises
  WHERE land1 EQ 'ES'.

IF sy-subrc EQ 0.
  WRITE: / gwa_paises-lkvrz.
ENDIF.

*/////////Ejercicio del video//////////////////////////////////////////////////////
*DATA: gwa_language TYPE t002.
*
*SELECT SINGLE * FROM t002
*  INTO gwa_language
*  WHERE spras EQ sy-langu.
*
*IF sy-subrc EQ 0.
*  WRITE: / gwa_language-laiso.
*ENDIF.
*
*SELECT SINGLE * FROM t002 BYPASSING BUFFER
*  INTO gwa_language
*  WHERE spras EQ 'E'.
*
*IF sy-subrc EQ 0.
*  WRITE: / gwa_language-laiso.
*ENDIF.
