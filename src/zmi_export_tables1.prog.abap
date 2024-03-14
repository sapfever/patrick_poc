*&---------------------------------------------------------------------*
*& Report  ZMI_EXPORT_TABLES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report  zmi_export_tables1.

type-pools: abap.

data: lo_excel                type ref to zcl_excel,
      lo_worksheet            type ref to zcl_excel_worksheet,
      lo_hyperlink            type ref to zcl_excel_hyperlink.


constants: gc_save_file_name type string value 'data.xlsx'.

data tabs type dd02l occurs 0 with header line.
select-options tabname for tabs-tabname  no intervals.
include zdemo_excel_outputopt_incl.


start-of-selection.


  " Creates active sheet
  create object lo_excel.

  select * from dd02l into table tabs where tabname in tabname.

  field-symbols <fsym_itab> type standard table.
  field-symbols <fsym_warea>.

  data : ref_rowtype   type ref to cl_abap_structdescr,
         ref_tabletype type ref to cl_abap_tabledescr.

  data : ref_itab type ref to data,
         ref_wa type ref to data.

  data sheetname type zexcel_sheet_title.

lo_worksheet = lo_excel->get_active_worksheet( ).

data row type i.
loop at tabs.
    select single ddtext into sheetname from dd02t where
      tabname = tabs-tabname and ddlanguage eq 'EN'.

add 1 to row.
lo_worksheet->set_cell( ip_column = 'A' ip_row = row ip_value = tabs-tabname ).
lo_worksheet->set_cell( ip_column = 'B' ip_row = row ip_value = sheetname ).

endloop.

  loop at tabs.

*    select SINGLE DDTEXT into sheetname from DD02T where
*      TABNAME = tabs-TABNAME and DDLANGUAGE eq 'EN'.
*
*    CONCATENATE  tabs-TABNAME ' (' sheetname ')' into sheetname.
*
*    REPLACE all OCCURRENCES OF '/' in sheetname WITH '-'.
*    REPLACE all OCCURRENCES OF '&' in sheetname WITH '-'.

    sheetname = tabs-tabname.

    ref_rowtype   ?= cl_abap_typedescr=>describe_by_name( tabs-tabname ).
    ref_tabletype  = cl_abap_tabledescr=>create( p_line_type = ref_rowtype ).

    create data ref_itab  type handle ref_tabletype.
    create data ref_wa    type handle ref_rowtype.

    assign ref_itab->* to <fsym_itab>.
    assign ref_wa->*   to <fsym_warea>.

    select *
      from (tabs-tabname)
      into table <fsym_itab>.


  lo_worksheet = lo_excel->add_new_worksheet( ).
  lo_worksheet->set_title( ip_title = sheetname ).
  lo_worksheet->bind_table(
    exporting
      ip_table            = <fsym_itab>
*      IT_FIELD_CATALOG    =
*      IS_TABLE_SETTINGS   =
*      IV_DEFAULT_DESCR    =
*      IV_NO_LINE_IF_EMPTY = ABAP_FALSE
*    IMPORTING
*      ES_TABLE_SETTINGS   =
  ).
*    CATCH ZCX_EXCEL.    " Exceptions for ABAP2XLSX

  endloop.

*** Create output
  lcl_output=>output( lo_excel ).
