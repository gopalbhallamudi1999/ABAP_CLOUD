  METHOD validate_email.
    rv_valid = abap_false.

    IF iv_email CS '@' AND iv_email CS '.'.
      rv_valid = abap_true.
    ENDIF.
  ENDMETHOD.