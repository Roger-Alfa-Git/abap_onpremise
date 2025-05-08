*&---------------------------------------------------------------------*
*& Include          Z_PRACTICA_ALV_2_1_ALFA10_PAI
*&---------------------------------------------------------------------*
MODULE user_command_2000 INPUT.
  code = sy-ucomm.
  CASE code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'B_TAB'.
      gv_carri = sflight-carrid.
      gv_conni = spfli-connid.
      gv_confr = t005t-land1.
      gv_conto = t005t-landx50.
    WHEN 'BTN_L'.
     CLEAR: gv_carri, sflight-carrid, gv_conni, spfli-connid, gv_confr, t005t-land1, gv_conto, t005t-landx50.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

MODULE user_exit_2000 INPUT.
  code = sy-ucomm.
  IF code EQ 'CANCEL'.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDMODULE.
