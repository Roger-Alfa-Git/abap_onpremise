*&---------------------------------------------------------------------*
*& Report Z14_COMMIT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z14_commit_alfa10.

CLASS lcl_rollback DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: on_transaction_finish FOR EVENT transaction_finished
    OF cl_system_transaction_state IMPORTING kind.
ENDCLASS.

CLASS lcl_rollback IMPLEMENTATION.
  METHOD on_transaction_finish.
    IF kind EQ cl_system_transaction_state=>rollback_work.
      WRITE: / 'Operaciones en BBDD anuladas con exito'.
    ELSEIF kind EQ cl_system_transaction_state=>commit_work.
      WRITE: / 'Base de datos actualizados'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gwa_airlines TYPE zscarr_alfa10,
        lv_minutes   TYPE i.

  SET HANDLER lcl_rollback=>on_transaction_finish.

  SELECT SINGLE * FROM zscarr_alfa10
    INTO gwa_airlines
    WHERE carrid = 'BA'.

  lv_minutes = sy-timlo+4(2).

  IF sy-subrc EQ 0.

    gwa_airlines-currcode = 'GBP'.

    UPDATE zscarr_alfa10 FROM gwa_airlines.

    WRITE: / 'Minuto de la ejecucuion: ',lv_minutes.

    IF lv_minutes MOD 2 EQ 0.
      COMMIT WORK.
    ELSE.
      ROLLBACK WORK.
    ENDIF.

    IF sy-subrc EQ 0.
      WRITE: / 'Actualizado con exito'.
    ENDIF.
  ENDIF.
