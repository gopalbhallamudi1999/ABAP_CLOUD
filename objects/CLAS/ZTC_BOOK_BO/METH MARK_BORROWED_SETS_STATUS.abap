  METHOD mark_borrowed_sets_status.
    DATA(book_key) = create_book( title = 'Dune' author = 'Frank Herbert' price = '12.99' currency_code = 'USD' ).

    MODIFY ENTITIES OF zr_book
      ENTITY Book
        EXECUTE markBorrowed FROM VALUE #( ( %key = book_key ) )
      RESULT DATA(result)
      FAILED DATA(failed).

    cl_abap_unit_assert=>assert_initial( act = failed msg = 'Action must not fail' ).
    cl_abap_unit_assert=>assert_equals( exp = 'B' act = result[ 1 ]-%param-Status msg = 'Action returns borrowed book' ).
    cl_abap_unit_assert=>assert_equals( exp = 'B' act = read_book( book_key )-Status msg = 'Book is borrowed' ).
  ENDMETHOD.