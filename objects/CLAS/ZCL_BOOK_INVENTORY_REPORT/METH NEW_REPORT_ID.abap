  METHOD new_report_id.
    TRY.
        result = cl_system_uuid=>create_uuid_c32_static( ).
      CATCH cx_uuid_error.
        CLEAR result.
    ENDTRY.
  ENDMETHOD.