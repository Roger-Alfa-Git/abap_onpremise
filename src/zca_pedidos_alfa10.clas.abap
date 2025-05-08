class ZCA_PEDIDOS_ALFA10 definition
  public
  inheriting from ZCB_PEDIDOS_ALFA10
  final
  create private .

public section.

  class-data AGENT type ref to ZCA_PEDIDOS_ALFA10 read-only .

  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCA_PEDIDOS_ALFA10 IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
***BUILD 090501
************************************************************************
* Purpose        : Initialize the 'class'.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : Singleton is created.
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 1999-09-20   : (OS) Initial Version
* - 2000-03-06   : (BGR) 2.0 modified REGISTER_CLASS_AGENT
************************************************************************
* GENERATED: Do not modify
************************************************************************

  create object AGENT.

  call method AGENT->REGISTER_CLASS_AGENT
    exporting
      I_CLASS_NAME          = 'ZCL_PEDIDOS_ALFA10'
      I_CLASS_AGENT_NAME    = 'ZCA_PEDIDOS_ALFA10'
      I_CLASS_GUID          = '000C292775F91EDF8EE327C5A4286267'
      I_CLASS_AGENT_GUID    = '000C292775F91EDF8EE327E957A2C267'
      I_AGENT               = AGENT
      I_STORAGE_LOCATION    = 'ZPE_ALFA10'
      I_CLASS_AGENT_VERSION = '2.0'.

           "CLASS_CONSTRUCTOR
  endmethod.
ENDCLASS.
