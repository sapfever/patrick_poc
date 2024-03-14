*&---------------------------------------------------------------------*
*& Report Z_SEND_EMAIL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_SEND_ACTIONABLE_EMAIL.

PARAMETERS p_email TYPE ADR6-SMTP_ADDR DEFAULT 'muhammad.ilyas@team.sapfever.com'.

DATA: lo_send_request TYPE REF TO cl_bcs,
      lo_document     TYPE REF TO cl_document_bcs,
      lv_recipient    TYPE somlreci1,
      lt_receivers    TYPE TABLE OF somlreci1,
      lv_subject      TYPE string,
      lv_html_body    TYPE string.

* Define recipients
lv_recipient-receiver = 'mu.ilyas@outlook.com'.
APPEND lv_recipient TO lt_receivers.

* Define email subject
lv_html_body =
|<html>| &
|<head>| &
|  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">| &
|  <script type="application/adaptivecard+json">| &
|\{| &
|    "type": "AdaptiveCard",| &
|    "body": [| &
|        \{| &
|            "type": "Container",| &
|            "style": "emphasis",| &
|            "items": [| &
|                \{| &
|                    "type": "ColumnSet",| &
|                    "id": "6c58df6a-340c-3739-b9a4-cff8c343dd5a",| &
|                    "columns": [| &
|                        \{| &
|                            "type": "Column",| &
|                            "id": "2d8e3517-0eb1-c220-4cf9-30d05b93b4a2",| &
|                            "padding": "None",| &
|                            "width": "stretch",| &
|                            "items": [| &
|                                \{| &
|                                    "type": "TextBlock",| &
|                                    "horizontalAlignment": "Left",| &
|                                    "color": "Dark",| &
|                                    "text": "Purchase Order ",| &
|                                    "wrap": true| &
|                                \}| &
|                            ]| &
|                        \},| &
|                        \{| &
|                            "type": "Column",| &
|                            "padding": "None",| &
|                            "width": "stretch",| &
|                            "items": [| &
|                                \{| &
|                                    "type": "TextBlock",| &
|                                    "id": "lbl_po",| &
|                                    "text": "#2",| &
|                                    "wrap": true,| &
|                                    "horizontalAlignment": "Right"| &
|                                \}| &
|                            ]| &
|                        \}| &
|                    ],| &
|                    "padding": "None"| &
|                \}| &
|            ],| &
|            "padding": "Default",| &
|            "spacing": "None"| &
|        \},| &
|        \{| &
|            "type": "Container",| &
|            "separator": true,| &
|            "style": "accent",| &
|            "items": [| &
|                \{| &
|                    "type": "TextBlock",| &
|                    "size": "Large",| &
|                    "weight": "Bolder",| &
|                    "color": "Dark",| &
|                    "text": "Vendor #1 PO #2 is waiting for your Approval",| &
|                    "wrap": true,| &
|                    "style": "heading"| &
|                \}| &
|            ],| &
|            "padding": "Default",| &
|            "spacing": "None"| &
|        \},| &
|        \{| &
|            "type": "Container",| &
|            "separator": true,| &
|            "items": [| &
|                \{| &
|                    "type": "Container",| &
|                    "items": [| &
|                        \{| &
|                            "type": "ColumnSet",| &
|                            "columns": [| &
|                                \{| &
|                                    "type": "Column",| &
|                                    "items": [| &
|                                        \{| &
|                                            "type": "TextBlock",| &
|                                            "id": "",| &
|                                            "text": "Item text"| &
|                                        \}| &
|                                    ],| &
|                                    "width": "auto",| &
|                                    "padding": "None"| &
|                                \},| &
|                                \{| &
|                                    "type": "Column",| &
|                                    "items": [| &
|                                        \{| &
|                                            "type": "TextBlock",| &
|                                            "spacing": "None",| &
|                                            "color": "Light",| &
|                                            "text": "item qty",| &
|                                            "wrap": true,| &
|                                            "horizontalAlignment": "Right"| &
|                                        \}| &
|                                    ],| &
|                                    "width": "stretch",| &
|                                    "padding": "None"| &
|                                \},| &
|                                \{| &
|                                    "type": "Column",| &
|                                    "padding": "None",| &
|                                    "width": "stretch",| &
|                                    "items": [| &
|                                        \{| &
|                                            "type": "TextBlock",| &
|                                            "id": "",| &
|                                            "text": "item value\n",| &
|                                            "wrap": true,| &
|                                            "horizontalAlignment": "Right"| &
|                                        \}| &
|                                    ]| &
|                                \}| &
|                            ],| &
|                            "padding": "None",| &
|                            "horizontalAlignment": "Left"| &
|                        \}| &
|                    ],| &
|                    "padding": "None"| &
|                \},| &
|                \{| &
|                    "type": "FactSet",| &
|                    "id": "",| &
|                    "facts": [| &
|                        \{| &
|                            "title": "Delivery Starts",| &
|                            "value": "#3"| &
|                        \},| &
|                        \{| &
|                            "title": "Total Value",| &
|                            "value": "#4"| &
|                        \},| &
|                        \{| &
|                            "title": "Shipment Type",| &
|                            "value": "#5"| &
|                        \}| &
|                    ]| &
|                \}| &
|            ],| &
|            "padding": \{| &
|                "top": "Default",| &
|                "bottom": "None",| &
|                "left": "Default",| &
|                "right": "Default"| &
|            \},| &
|            "spacing": "None"| &
|        \},| &
|        \{| &
|            "type": "Container",| &
|            "id": "466ee0a4-b5ba-520e-0b5d-53841fffe66e",| &
|            "padding": "Default",| &
|            "items": [| &
|                \{| &
|                    "type": "ActionSet",| &
|                    "actions": [| &
|                        \{| &
|                            "type": "Action.ShowCard",| &
|                            "title": "Approve",| &
|                            "card": \{| &
|                                "type": "AdaptiveCard",| &
|                                "body": [| &
|                                    \{| &
|                                        "type": "ColumnSet",| &
|                                        "id": "77116e02-ddb2-39a9-4da4-5aee5af75673",| &
|                                        "columns": [| &
|                                            \{| &
|                                                "type": "Column",| &
|                                                "id": "c507785f-a8de-fa80-45cd-c2db65db2bcd",| &
|                                                "padding": "None",| &
|                                                "width": "stretch",| &
|                                                "items": [| &
|                                                    \{| &
|                                                        "type": "Input.Text",| &
|                                                        "id": "txt_uid",| &
|                                                        "placeholder": "SAP User ID",| &
|                                                        "isRequired": true| &
|                                                    \}| &
|                                                ]| &
|                                            \},| &
|                                            \{| &
|                                                "type": "Column",| &
|                                                "padding": "None",| &
|                                                "width": "stretch",| &
|                                                "items": [| &
|                                                    \{| &
|                                                        "type": "Input.Text",| &
|                                                        "id": "txt_pwd",| &
|                                                        "placeholder": "SAP password",| &
|                                                        "isRequired": true| &
|                                                    \}| &
|                                                ]| &
|                                            \}| &
|                                        ],| &
|                                        "padding": "None"| &
|                                    \},| &
|                                    \{| &
|                                        "type": "ActionSet",| &
|                                        "actions": [| &
|                                            \{| &
|                                                "type": "Action.Http",| &
|                                                "title": "Submit",| &
|                                                "method": "POST",| &
|                                                "url": "https://erpehp8c.sapfever.com/sap/opu/odata/SAP/Z_POREL_SRV/PO_RELEASE",| &
|                                                "body": "\{Purchaseorder: \{\{lbl_po.value\}\}, RelStatusNew:true\}"| &
|                                            \}| &
|                                        ]| &
|                                    \}| &
|                                ],| &
|                                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",| &
|                                "padding": "None"| &
|                            \},| &
|                            "style": "positive",| &
|                            "isPrimary": true| &
|                        \},| &
|                        \{| &
|                            "type": "Action.Http",| &
|                            "id": "bb5978b4-f7c8-c3a2-e4da-0c49e025dd90",| &
|                            "title": "Decline",| &
|                            "method": "POST",| &
|                            "url": "https://erpehp8c.sapfever.com/sap/opu/odata/SAP/Z_POREL_SRV/PO_RELEASE",| &
|                            "body": "\{Purchaseorder: \{\{lbl_po.value\}\}, RelStatusNew:false\}"| &
|                        \}| &
|                    ]| &
|                \}| &
|            ],| &
|            "spacing": "None"| &
|        \}| &
|    ],| &
|    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",| &
|    "version": "1.0",| &
|    "padding": "None"| &
|\}| &
| </script>| &
|</head>| &
|<body>| &
|Actionable Message with SAP Workflows </br>| &
|POC developed by Mu. Ilyas@SAPFEVER</br>| &
|</body>| &
|</html>|
.


* Define HTML body
lv_subject  = 'Actionable email from SAP'.


data lv_content_size TYPE SO_OBJ_LEN.

lv_content_size = strlen( lv_html_body ).

data lv_text type soli_tab.

call function 'SCMS_STRING_TO_FTEXT'
exporting
  text      = lv_html_body
tables
  ftext_tab = lv_text.

* Create document
lo_document = cl_document_bcs=>create_document(
                i_type         = 'HTM'
                i_subject      = conv #( lv_subject )
                i_length       = lv_content_size
*                i_language     = space
*                i_importance   =
*                i_sensitivity  =
                 i_text         = lv_text
*                i_hex          =
*                i_header       =
*                i_sender       =
*                iv_vsi_profile =
              )
*              catch cx_document_bcs. " BCS: Document Exceptions
.

* Create email send request
lo_send_request = cl_bcs=>create_persistent( )
*                  catch cx_send_req_bcs. " BCS: Send Request Exceptions
.

*     add document object to send request
lo_send_request->set_document( lo_document ).

* Add recipients
lo_send_request->add_recipient( cl_cam_address_bcs=>create_internet_address( p_email ) ).

* Send email
TRY.
    lo_send_request->send(
      EXPORTING
        i_with_error_screen = 'X'
    ).
    WRITE: 'Email sent successfully.'.
    commit work.
  CATCH cx_bcs INTO DATA(lx_bcs).
    WRITE: / 'Error occurred while sending email:', lx_bcs->get_text( ).
ENDTRY.
