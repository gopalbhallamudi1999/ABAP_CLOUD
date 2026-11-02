  METHOD recent_icon.
    IF iv_recent = abap_true.
      rv_icon = c_icon_green.
    ELSE.
      rv_icon = c_icon_grey.
    ENDIF.
  ENDMETHOD.