*&---------------------------------------------------------------------*
*& Report Z_FERMINICH_COA_FSD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_FERMINICH_COA_FSD.

TABLES sscrfields.

DATA: it_text TYPE catsxt_longtext_itab.

SELECTION-SCREEN:
BEGIN OF LINE,
  PUSHBUTTON 12(10) text-020 USER-COMMAND cli2,
END OF LINE.

AT SELECTION-SCREEN.

  CASE sscrfields-ucomm.
    WHEN 'CLI2'.
      CALL FUNCTION 'CATSXT_SIMPLE_TEXT_EDITOR'
        EXPORTING
          im_title        = 'User Input Long Text'
          im_start_column = 10
          im_start_row    = 10
        CHANGING
          ch_text         = it_text.

  ENDCASE.

  START-OF-SELECTION.
