CLASS zcls_abap_cloud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES ty_icon TYPE c LENGTH 4.

    TYPES: BEGIN OF ty_row,
             vbeln   TYPE c LENGTH 10,
             posnr   TYPE n LENGTH 6,
             vkorg   TYPE c LENGTH 4,
             erdat   TYPE d,
             kunnr   TYPE c LENGTH 10,
             name1   TYPE c LENGTH 40,
             matnr   TYPE c LENGTH 40,
             maktx   TYPE c LENGTH 40,
             kwmeng  TYPE p LENGTH 13 DECIMALS 3,
             netwr   TYPE p LENGTH 15 DECIMALS 2,   " header value shown per item row
             waerk   TYPE c LENGTH 5,
             faksp   TYPE c LENGTH 2,               " billing block at item
             gbstk_h TYPE c LENGTH 1,               " header overall status
             lfstk_h TYPE c LENGTH 1,               " header delivery status
             fkstk_h TYPE c LENGTH 1,               " header billing status
             iconrec TYPE ty_icon,                  " recent indicator
           END OF ty_row.

    TYPES tt_rows TYPE STANDARD TABLE OF ty_row WITH EMPTY KEY.

    CONSTANTS c_icon_green  TYPE ty_icon VALUE '@5C@'.
    CONSTANTS c_icon_grey   TYPE ty_icon VALUE '@5D@'.
    CONSTANTS c_completed   TYPE c LENGTH 1 VALUE 'C'.
    CONSTANTS c_mode_header TYPE c LENGTH 1 VALUE 'H'.
    CONSTANTS c_mode_item   TYPE c LENGTH 1 VALUE 'I'.

    METHODS is_recent
      IMPORTING iv_date          TYPE d
                iv_today         TYPE d
      RETURNING VALUE(rv_recent) TYPE abap_bool.

    METHODS recent_icon
      IMPORTING iv_recent      TYPE abap_bool
      RETURNING VALUE(rv_icon) TYPE ty_icon.

    METHODS is_header_open
      IMPORTING iv_overall     TYPE c
                iv_delivery    TYPE c
                iv_billing     TYPE c
      RETURNING VALUE(rv_open) TYPE abap_bool.

    METHODS is_item_open
      IMPORTING iv_billing_block TYPE c
      RETURNING VALUE(rv_open)   TYPE abap_bool.

    METHODS is_valid_sales_org
      IMPORTING iv_sales_org    TYPE c
      RETURNING VALUE(rv_valid) TYPE abap_bool.

    METHODS apply_max_rows
      IMPORTING iv_max  TYPE i
      CHANGING  ct_rows TYPE tt_rows.

    METHODS post_process
      IMPORTING iv_today TYPE d
      CHANGING  ct_rows  TYPE tt_rows.

    METHODS get_data
      IMPORTING iv_sales_org   TYPE c
                iv_date_from   TYPE d
                iv_date_to     TYPE d
                iv_mode        TYPE c
      RETURNING VALUE(rt_rows) TYPE tt_rows.
