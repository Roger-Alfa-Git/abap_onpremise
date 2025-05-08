CLASS zamdp_consgen DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.


    TYPES: it_global      TYPE STANDARD TABLE OF zdataflightalfa10.

    CLASS-METHODS selectall
      IMPORTING
        VALUE(id_carrid) TYPE s_carr_id
        VALUE(id_connid) TYPE s_conn_id
        VALUE(id_counfr) TYPE land1
        VALUE(id_counto) TYPE land1
      EXPORTING
        VALUE(it_global) TYPE it_global.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zamdp_consgen IMPLEMENTATION.
  METHOD selectall BY DATABASE PROCEDURE

                                      FOR HDB

                                      LANGUAGE SQLSCRIPT

                                      OPTIONS READ-ONLY

                                      USING scarr spfli sflight.
    it_global = SELECT DISTINCT s1.carrid,
                      s1.carrname,
                      s1.currcode,
                      s2.connid,
                      s2.countryfr,
                      s2.cityfrom,
                      s2.airpfrom AS airfrname,
                      s2.countryto,
                      s2.cityto ,
                      s2.airpto AS airtoname,
                      s2.distance,
                      s2.distid,
                      s3.fldate,
                      s3.price,
                      s3.currency,
                      s3.seatsmax,
                      s3.seatsocc,
                      s3.seatsmax_b,
                      s3.seatsocc_b,
                      s3.seatsmax_f,
                      s3.seatsocc_f,
                      s3.paymentsum
        FROM scarr AS s1
        INNER JOIN spfli    AS s2 ON s1.carrid    = s2.carrid
        INNER JOIN sflight  AS s3 ON s2.connid    = s3.connid
        where s1.carrid = :id_carrid
          and s2.connid = :id_connid
          and s2.countryfr = :id_counfr
          and s2.countryto = :id_counto ;
  ENDMETHOD.
ENDCLASS.
