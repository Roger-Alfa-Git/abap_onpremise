*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO9_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio9_alfa10.

CLASS cl_fisica DEFINITION.
  PUBLIC SECTION.
    CONSTANTS: Planck        TYPE string VALUE 'ħ=h/2π',
               Boltzmann     TYPE string VALUE '⟨Ecin​⟩=23​kB​T',
               Volumen_molar TYPE string VALUE '22,4 L',
               distancia_T_S TYPE string VALUE '149,6·106 km'.

ENDCLASS.

START-OF-SELECTION.

  DATA: gv_fisica TYPE string.

  gv_fisica = cl_fisica=>boltzmann.
  WRITE: / gv_fisica.

  gv_fisica = cl_fisica=>distancia_t_s.
  WRITE: / gv_fisica.

  gv_fisica = cl_fisica=>planck.
  WRITE: / gv_fisica.

  gv_fisica = cl_fisica=>volumen_molar.
  WRITE: / gv_fisica.
