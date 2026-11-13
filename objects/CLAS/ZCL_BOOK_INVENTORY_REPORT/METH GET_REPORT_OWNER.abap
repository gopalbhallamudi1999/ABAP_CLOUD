  METHOD get_report_owner.
    TRY.
        result = cl_abap_context_info=>get_user_formatted_name( ).
      CATCH cx_abap_context_info_error INTO DATA(context_error).
        result = context_error->get_text( ).
    ENDTRY.
  ENDMETHOD.