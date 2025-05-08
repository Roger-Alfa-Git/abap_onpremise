*&---------------------------------------------------------------------*
*& Report ZPRUEBA_2_1_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprueba_2_1_alfa10.

DATA: gt_tabla  TYPE TABLE OF zdataflightalfa10,
      gt_tabla2 TYPE TABLE OF zdataflightalfa10,
      gs_tabla  TYPE zdataflightalfa10,
      gs_tabla2 TYPE zdataflightalfa10.

SELECT DISTINCT  s1~carrid, s1~carrname, s1~currcode, s2~connid, s6~landx50 AS countryfr, s2~cityfrom, s5~name AS airfrname, s7~landx50 AS countryto, s2~cityto , s8~name AS airtoname, s2~distance, s2~distid,
 s3~fldate, s3~price, s3~currency, s3~seatsmax, s3~seatsocc, s3~seatsmax_b, s3~seatsocc_b, s3~seatsmax_f, s3~seatsocc_f, s3~paymentsum FROM scarr AS s1
 INNER JOIN spfli    AS s2 ON s1~carrid    EQ s2~carrid
 RIGHT JOIN sflight  AS s3 ON s2~connid    EQ s3~connid AND s2~carrid EQ s3~carrid
 INNER JOIN t005t    AS s6 ON s2~countryfr     EQ s6~land1
 INNER JOIN t005t    AS s7 ON s2~countryto     EQ s7~land1
 INNER JOIN sairport AS s5 ON s2~airpfrom EQ s5~id
 INNER JOIN sairport AS s8 ON s2~airpto    EQ s8~id
INTO CORRESPONDING FIELDS OF TABLE @gt_tabla
  WHERE s2~countryfr     EQ s6~land1 AND s2~countryto     EQ s7~land1
  AND s2~airpfrom EQ s5~id AND s2~airpto    EQ s8~id
  ORDER BY s3~fldate DESCENDING.

DATA(lv_count) = lines( gt_tabla ).
WRITE: / 'Número de registros 1:', lv_count.

SELECT DISTINCT  s1~carrid, s1~carrname, s1~currcode, s2~connid, s2~cityfrom, s2~cityto ,  s2~distance, s2~distid,
 s3~fldate, s3~price, s3~currency, s3~seatsmax, s3~seatsocc, s3~seatsmax_b, s3~seatsocc_b, s3~seatsmax_f, s3~seatsocc_f, s3~paymentsum FROM scarr AS s1
 INNER JOIN spfli    AS s2 ON s1~carrid    EQ s2~carrid
 RIGHT JOIN sflight  AS s3 ON s2~connid    EQ s3~connid
INTO CORRESPONDING FIELDS OF TABLE @gt_tabla2.

DATA(lv_count2) = lines( gt_tabla2 ).
WRITE: / 'Número de registros 2:', lv_count2.

SELECT DISTINCT * FROM scarr AS s1
 INNER JOIN spfli    AS s2 ON s1~carrid    EQ s2~carrid
 INNER JOIN sflight  AS s3 ON s2~connid    EQ s3~connid
 INNER JOIN t005t    AS s6 ON s2~countryfr     EQ s6~land1
 INNER JOIN t005t    AS s7 ON s2~countryto     EQ s7~land1
 INNER JOIN sairport AS s5 ON s2~airpfrom EQ s5~id
 INNER JOIN sairport AS s8 ON s2~airpto    EQ s8~id
INTO TABLE @DATA(gt_tabla5)
  ORDER BY s3~fldate.

DATA(lv_count3) = lines( gt_tabla5 ).
WRITE: / 'Número de registros 3:', lv_count3.

SELECT * FROM sflight
INTO TABLE @DATA(gt_tabla3).

DATA(lv_count4) = lines( gt_tabla3 ).
WRITE: / 'Número de registros 4:', lv_count4.

SELECT * FROM spfli
INTO TABLE @DATA(gt_tabla4).

DATA(lv_count5) = lines( gt_tabla4 ).
WRITE: / 'Número de registros 5:', lv_count5.

SELECT * FROM scarr
INTO TABLE @DATA(gt_tabla6).

DATA(lv_count6) = lines( gt_tabla6 ).
WRITE: / 'Número de registros 6:', lv_count6.
