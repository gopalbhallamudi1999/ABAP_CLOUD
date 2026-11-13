  METHOD if_oo_adt_classrun~main.
    DATA books TYPE STANDARD TABLE OF zbook_a WITH EMPTY KEY.

    GET TIME STAMP FIELD DATA(now).

    books = VALUE #(
      ( book_id = '00000001' title = 'Clean ABAP'                    author = 'Klaus Haeuptle'
        genre = 'Programming' price = '39.90' currency_code = 'EUR' status = 'A' )
      ( book_id = '00000002' title = 'ABAP RESTful Programming Model' author = 'Stefan Haas'
        genre = 'Programming' price = '79.95' currency_code = 'EUR' status = 'B' )
      ( book_id = '00000003' title = 'The Pragmatic Programmer'      author = 'Andrew Hunt'
        genre = 'Software'    price = '45.00' currency_code = 'USD' status = 'A' )
      ( book_id = '00000004' title = 'Dune'                          author = 'Frank Herbert'
        genre = 'Fiction'     price = '12.99' currency_code = 'USD' status = 'A' ) ).

    LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).
      TRY.
          <book>-book_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error INTO DATA(uuid_error).
          out->write( uuid_error->get_text( ) ).
          RETURN.
      ENDTRY.
      <book>-local_created_by      = sy-uname.
      <book>-local_created_at      = now.
      <book>-local_last_changed_by = sy-uname.
      <book>-local_last_changed_at = now.
      <book>-last_changed_at       = now.
    ENDLOOP.

    DELETE FROM zbook_a WHERE book_id = 1.
    INSERT zbook_a FROM TABLE @books.

    out->write( |{ lines( books ) } books inserted into ZBOOK_A.| ).
  ENDMETHOD.