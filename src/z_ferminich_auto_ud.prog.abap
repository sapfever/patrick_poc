*&---------------------------------------------------------------------*
*& Report Z_FERMINICH_AUTO_UD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_FERMINICH_AUTO_UD.

TABLES: qals, afko, afpo, AUFPAR, QAVE.

select-options:
 so1 for qals-werk no-EXTENSION OBLIGATORY NO INTERVALS,
 so2 for qals-HERKUNFT no-EXTENSION OBLIGATORY NO INTERVALS,
 so3 for qals-ART,
 so4 for qals-ENSTEHDAT,
 so5 for AUFPAR-pi_aufart,

 so6 for QAVE-VCODE no-EXTENSION OBLIGATORY NO INTERVALS,
 so7 for qave-VCODEGRP no-EXTENSION OBLIGATORY NO INTERVALS.
