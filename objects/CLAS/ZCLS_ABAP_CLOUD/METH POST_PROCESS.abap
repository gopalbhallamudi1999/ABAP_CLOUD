  METHOD post_process.
    LOOP AT ct_rows ASSIGNING FIELD-SYMBOL(<ls_row>).
      <ls_row>-iconrec = recent_icon( is_recent( iv_date  = <ls_row>-erdat
                                                 iv_today = iv_today ) ).
    ENDLOOP.
  ENDMETHOD.