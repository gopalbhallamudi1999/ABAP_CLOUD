  METHOD format_employee_name.
    rv_name = to_upper( condense( iv_name ) ).
  ENDMETHOD.