  METHOD validate_bonus_percentage.
    rv_valid = abap_false.

    IF iv_percent >= 0 AND iv_percent <= 100.
      rv_valid = abap_true.
    ENDIF.
  ENDMETHOD.