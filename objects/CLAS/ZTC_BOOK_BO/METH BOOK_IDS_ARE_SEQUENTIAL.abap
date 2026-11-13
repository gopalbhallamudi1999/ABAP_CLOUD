  METHOD book_ids_are_sequential.
    MODIFY ENTITIES OF zr_book
      ENTITY Book
        CREATE FIELDS ( Title Author Price CurrencyCode )
        WITH VALUE #( ( %cid = 'B1' Title = 'Book One' Author = 'Author One' Price = '10.00' CurrencyCode = 'EUR' )
                      ( %cid = 'B2' Title = 'Book Two' Author = 'Author Two' Price = '20.00' CurrencyCode = 'USD' ) )
      MAPPED DATA(mapped).

    DATA(first)  = read_book( CORRESPONDING #( mapped-book[ KEY cid %cid = 'B1' ] ) ).
    DATA(second) = read_book( CORRESPONDING #( mapped-book[ KEY cid %cid = 'B2' ] ) ).
    cl_abap_unit_assert=>assert_equals( exp = '00000001' act = first-BookID  msg = 'First book gets ID 1' ).
    cl_abap_unit_assert=>assert_equals( exp = '00000002' act = second-BookID msg = 'Second book gets ID 2' ).
  ENDMETHOD.