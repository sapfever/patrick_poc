class ZCL_Z_POREL_DPC_EXT definition
  public
  inheriting from ZCL_Z_POREL_DPC
  create public .

public section.
protected section.

  methods PO_RELEASE_CREATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z_POREL_DPC_EXT IMPLEMENTATION.


  method PO_RELEASE_CREATE_ENTITY.
**try.
*CALL METHOD SUPER->PO_RELEASE_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  importing
**    er_entity               =
*    .
** catch /iwbep/cx_mgw_busi_exception .
** catch /iwbep/cx_mgw_tech_exception .
**endtry.
    er_entity-purchaseorder = 'api works'.

  endmethod.
ENDCLASS.
