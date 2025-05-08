*&---------------------------------------------------------------------*
*& Include          Z_VIDEOS9_ALFA10_SEL
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-b01.

  SELECTION-SCREEN SKIP.

  SELECTION-SCREEN BEGIN OF BLOCK block7 WITH FRAME TITLE TEXT-b07.

* tipo Proceso - CRUD
    PARAMETERS: p_create RADIOBUTTON GROUP crud, "Create - Alta empleado
                p_read   RADIOBUTTON GROUP crud, "Read - Visualizar empleado
                p_update RADIOBUTTON GROUP crud,  " UPDATE - Actualizar datos
                p_delete RADIOBUTTON GROUP crud, " DELETE - Baja empleado
                p_modify RADIOBUTTON GROUP crud. " Modify - Modificar empleado


  SELECTION-SCREEN END OF BLOCK block7.

  SELECTION-SCREEN SKIP.

  SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-b02.

    PARAMETERS: p_ape1   TYPE c LENGTH 20 , "Primer Apellido
                p_ape2   TYPE c LENGTH 20 , "Segundo Apellido
                p_nombre TYPE c LENGTH 30 . "Nombre

    SELECTION-SCREEN SKIP.


*fecha de nacimeinto
    PARAMETERS p_fechan TYPE sydatum.

* Numero de documento identificativo
    PARAMETERS p_dni TYPE c LENGTH 15 OBLIGATORY.

* Domicilio
    PARAMETERS p_domici TYPE c LENGTH 50.

*Correo electronico
    PARAMETERS p_email TYPE c LENGTH 30.

  SELECTION-SCREEN END OF BLOCK block2.
*
* Datos relativos a la solicitud de alta
*
*
* Tipo de contrato y beneficios
*

  SELECTION-SCREEN BEGIN OF BLOCK block3 WITH FRAME TITLE TEXT-b03.

    SELECTION-SCREEN SKIP.

    SELECTION-SCREEN BEGIN OF BLOCK block4 WITH FRAME TITLE TEXT-b04.

*Tipo de contrato
      PARAMETERS: p_cntr_i RADIOBUTTON GROUP cntr, "Indefinido
                  p_cntr_t RADIOBUTTON GROUP cntr DEFAULT 'X', "Temporal
                  p_cntr_p RADIOBUTTON GROUP cntr. "Practicas

    SELECTION-SCREEN END OF BLOCK block4.

    SELECTION-SCREEN SKIP.

    SELECTION-SCREEN BEGIN OF BLOCK block5 WITH FRAME TITLE TEXT-b05.

      SELECTION-SCREEN BEGIN OF LINE.
*Beneficios
        PARAMETERS p_tik_r TYPE c AS CHECKBOX DEFAULT 'X'.
        SELECTION-SCREEN COMMENT (22) c_tik_r.

        PARAMETERS p_seg_m TYPE c AS CHECKBOX.
        SELECTION-SCREEN COMMENT (22) c_seg_m.

        PARAMETERS p_frm_p TYPE c AS CHECKBOX.
        SELECTION-SCREEN COMMENT (22) c_frm_p.

      SELECTION-SCREEN END OF LINE.

    SELECTION-SCREEN END OF BLOCK block5.
*
* Datos relativos a la actividad laboral
*
*
*P
    PARAMETERS: p_horas TYPE i, "Horas semanales
                p_sal_m TYPE i. "Salario mensual
*Fecha de alta
    PARAMETERS p_fechaa TYPE sydatum.

    SELECTION-SCREEN SKIP.

    SELECTION-SCREEN BEGIN OF BLOCK block6 WITH FRAME TITLE TEXT-b06.
      SELECT-OPTIONS: s_prog FOR trdir-name,
                      s_tcode FOR tstc-tcode.
    SELECTION-SCREEN END OF BLOCK block6.

    SELECTION-SCREEN SKIP.

  SELECTION-SCREEN END OF BLOCK block3.
SELECTION-SCREEN END OF BLOCK block1.
