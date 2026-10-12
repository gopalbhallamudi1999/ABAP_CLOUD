  METHOD calculate_net_amount.
    rv_net_amount = 0.

    IF iv_amount < 0
       OR iv_discount_percent < 0
       OR iv_discount_percent > 100.
      RETURN.
    ENDIF.

    rv_net_amount = iv_amount -
      ( iv_amount * iv_discount_percent / 100 ).
  ENDMETHOD.