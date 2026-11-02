  METHOD if_oo_adt_classrun~main.
    DATA lv_from TYPE d.

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).
    lv_from = lv_today - 30.

    IF is_valid_sales_org( c_sales_org ) = abap_false.
      out->write( 'Sales Organization is required' ).
      RETURN.
    ENDIF.

    DATA(lt_rows) = get_data( iv_sales_org = c_sales_org
                              iv_date_from = lv_from
                              iv_date_to   = lv_today
                              iv_mode      = c_mode_header ).

    apply_max_rows( EXPORTING iv_max  = c_max_rows
                    CHANGING  ct_rows = lt_rows ).

    post_process( EXPORTING iv_today = lv_today
                  CHANGING  ct_rows  = lt_rows ).

    IF lt_rows IS INITIAL.
      out->write( 'No open orders found for selection' ).
    ELSE.
      out->write( lt_rows ).
    ENDIF.
  ENDMETHOD.