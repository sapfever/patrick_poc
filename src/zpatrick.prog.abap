*****           Implementation of object type ZPATRICK             *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
  BEGIN OF KEY,
      PURCHASINGDOCUMENT LIKE EKKO-EBELN,
  END OF KEY.
END_DATA OBJECT. " Do not change.. DATA is generated

BEGIN_METHOD PO_RELEASE CHANGING CONTAINER.
DATA:
      relcode LIKE bapimmpara-po_rel_cod,
      useexceptions LIKE bapimmpara-selection,
      nocommit LIKE bapimmpara-selection,
      relstatusnew LIKE bapimmpara-rel_status,
      relindicatornew LIKE bapimmpara-po_rel_ind,
      return type string.


  CALL FUNCTION 'ZPATRICK_PO_RELEASE'
    EXPORTING
      PO =   object-key-PurchasingDocument
      RG = ''
      RC = ''
      US = ''
    IMPORTING
      RETURN = return
    EXCEPTIONS
      OTHERS = 01.
  CASE SY-SUBRC.
    WHEN 0.            " OK
    WHEN OTHERS.       " to be implemented
  ENDCASE.
END_METHOD.

BEGIN_METHOD EXISTENCECHECK CHANGING CONTAINER.

TABLES ekko.

CALL FUNCTION 'ME_EKKO_SINGLE_READ'
  EXPORTING
    pi_ebeln         = object-key-purchasingdocument
  IMPORTING
    po_ekko          = ekko
  EXCEPTIONS
    no_records_found = 1
    OTHERS           = 2.
IF sy-subrc <> 0 OR ekko-bstyp NE 'F'.
  exit_object_not_found.
ENDIF.

END_METHOD.
