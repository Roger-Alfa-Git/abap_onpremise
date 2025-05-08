class ZCX_ACCESO_ALFA10 definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  constants:
    begin of ZCX_ACCESO_ALFA10,
      msgid type symsgid value 'ZMSJ_ALFA10',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'MSJV1',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_ACCESO_ALFA10 .
  constants USUARIO type SOTR_CONC value '000C292775F91EEF8ECBA6642E7F8A24' ##NO_TEXT.
  data MSJV1 type MSGV1 .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MSJV1 type MSGV1 optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_ACCESO_ALFA10 IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MSJV1 = MSJV1 .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_ACCESO_ALFA10 .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
