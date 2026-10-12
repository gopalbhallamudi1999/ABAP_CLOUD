  METHOD calculate_discount.
    rv_discount = 0.

    IF iv_amount < 0
       OR iv_percent < 0
       OR iv_percent > 100.
      RETURN.
    ENDIF.

    rv_discount = iv_amount * iv_percent / 100.
  ENDMETHOD.