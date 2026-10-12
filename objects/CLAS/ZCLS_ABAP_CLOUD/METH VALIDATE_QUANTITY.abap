  METHOD validate_quantity.
    rv_valid = abap_false.

    IF iv_quantity > 0.
      rv_valid = abap_true.
    ENDIF.
  ENDMETHOD.