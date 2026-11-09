  METHOD apply_max_rows.
    IF iv_max > 0 AND lines( ct_rows ) > iv_max.
      DELETE ct_rows FROM iv_max + 1.
    ENDIF.
  ENDMETHOD.