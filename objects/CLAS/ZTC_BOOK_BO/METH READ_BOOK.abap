  METHOD read_book.
    READ ENTITIES OF zr_book
      ENTITY Book
        ALL FIELDS WITH VALUE #( ( %key = book_key ) )
      RESULT DATA(books).

    cl_abap_unit_assert=>assert_equals( exp = 1 act = lines( books ) msg = 'Book must exist' ).
    result = CORRESPONDING #( books[ 1 ] ).
  ENDMETHOD.