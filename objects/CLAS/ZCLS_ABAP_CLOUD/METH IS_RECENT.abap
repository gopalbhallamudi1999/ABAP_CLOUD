  METHOD is_recent.
    DATA lv_cutoff TYPE d.
    lv_cutoff = iv_today - 7.
    rv_recent = xsdbool( iv_date >= lv_cutoff ).
  ENDMETHOD.