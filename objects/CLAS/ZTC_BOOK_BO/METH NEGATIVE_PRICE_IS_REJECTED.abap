  METHOD negative_price_is_rejected.
    create_book( title = 'Cheap' author = 'Nobody' price = '-5.00' currency_code = 'EUR' ).

    COMMIT ENTITIES RESPONSE OF zr_book
      FAILED DATA(failed)
      REPORTED DATA(reported).

    cl_abap_unit_assert=>assert_not_initial( act = failed-book msg = 'Negative price must be rejected' ).
    cl_abap_unit_assert=>assert_not_initial( act = reported-book msg = 'An error message is expected' ).
  ENDMETHOD.