  METHOD price_needs_currency.
    create_book( title = 'Priced' author = 'Somebody' price = '15.00' currency_code = '' ).

    COMMIT ENTITIES RESPONSE OF zr_book
      FAILED DATA(failed)
      REPORTED DATA(reported).

    cl_abap_unit_assert=>assert_not_initial( act = failed-book msg = 'Price without currency must be rejected' ).
    cl_abap_unit_assert=>assert_not_initial( act = reported-book msg = 'An error message is expected' ).
  ENDMETHOD.