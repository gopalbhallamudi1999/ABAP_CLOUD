  METHOD validate_currency_amount.
    rv_valid = abap_false.

    IF iv_amount >= 0.
      rv_valid = abap_true.
    ENDIF.
  ENDMETHOD.