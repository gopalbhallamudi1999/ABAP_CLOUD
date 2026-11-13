  METHOD new_book_gets_id_and_status.
    DATA(book) = read_book( create_book( title = 'Clean ABAP' author = 'Klaus Haeuptle'
                                         price = '39.90' currency_code = 'EUR' ) ).

    cl_abap_unit_assert=>assert_equals( exp = '00000001' act = book-BookID msg = 'First book gets ID 1' ).
    cl_abap_unit_assert=>assert_equals( exp = 'A' act = book-Status msg = 'New book is available' ).
  ENDMETHOD.