  METHOD check_minimum_order.
    rv_valid = abap_false.

    IF iv_quantity < 0 OR iv_minimum < 0.
      RETURN.
    ENDIF.

    IF iv_quantity >= iv_minimum.
      rv_valid = abap_true.
    ENDIF.
  ENDMETHOD.