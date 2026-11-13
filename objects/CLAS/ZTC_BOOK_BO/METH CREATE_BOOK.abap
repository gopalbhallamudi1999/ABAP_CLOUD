  METHOD create_book.
    MODIFY ENTITIES OF zr_book
      ENTITY Book
        CREATE FIELDS ( Title Author Price CurrencyCode )
        WITH VALUE #( ( %cid         = 'NEW_BOOK'
                        Title        = title
                        Author       = author
                        Price        = price
                        CurrencyCode = currency_code ) )
      MAPPED DATA(mapped)
      FAILED DATA(failed).

    cl_abap_unit_assert=>assert_initial( act = failed msg = 'Create must not fail' ).
    result = CORRESPONDING #( mapped-book[ 1 ] ).
  ENDMETHOD.