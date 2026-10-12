  METHOD calculate_tax.
    rv_tax = 0.

    IF iv_amount < 0
       OR iv_tax_percent < 0
       OR iv_tax_percent > 100.
      RETURN.
    ENDIF.

    rv_tax = iv_amount * iv_tax_percent / 100.
  ENDMETHOD.