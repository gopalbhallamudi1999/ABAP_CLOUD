  METHOD is_header_open.
    rv_open = xsdbool( iv_overall  <> c_completed AND
                       iv_delivery <> c_completed AND
                       iv_billing  <> c_completed ).
  ENDMETHOD.