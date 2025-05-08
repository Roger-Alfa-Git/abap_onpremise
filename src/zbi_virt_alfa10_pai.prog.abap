*&---------------------------------------------------------------------*
*& Include          ZBI_VIRT_ALFA10_PAI
*&---------------------------------------------------------------------*
MODULE user_command_2000 INPUT.
  code = sy-ucomm.
  CASE code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

MODULE user_exit_2000 INPUT.
  code = sy-ucomm.
  IF code EQ 'CANCEL'.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDMODULE.
