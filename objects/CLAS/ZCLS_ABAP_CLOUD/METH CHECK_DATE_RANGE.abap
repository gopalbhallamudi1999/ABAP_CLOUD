  METHOD check_date_range.
    rv_valid = abap_false.

    IF iv_start_date IS INITIAL
       OR iv_end_date IS INITIAL.
      RETURN.
    ENDIF.

    IF iv_start_date <= iv_end_date.
      rv_valid = abap_true.
    ENDIF.
  ENDMETHOD.