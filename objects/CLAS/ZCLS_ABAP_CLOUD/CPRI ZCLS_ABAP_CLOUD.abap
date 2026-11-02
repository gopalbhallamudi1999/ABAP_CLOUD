  PRIVATE SECTION.
    CONSTANTS c_sales_org TYPE c LENGTH 4 VALUE '1010'.
    CONSTANTS c_max_rows  TYPE i VALUE 5000.

    METHODS build_demo_data
      IMPORTING iv_base        TYPE d
      RETURNING VALUE(rt_rows) TYPE tt_rows.