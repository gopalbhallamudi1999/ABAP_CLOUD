  METHOD only_useful_action_enabled.
    DATA(book_key) = create_book( title = 'Clean ABAP' author = 'Klaus Haeuptle' price = '39.90' currency_code = 'EUR' ).

    GET PERMISSIONS ONLY INSTANCE FEATURES ENTITY zr_book
      FROM VALUE #( ( %key = book_key ) )
      REQUEST VALUE #( %action-markAvailable = if_abap_behv=>mk-on
                       %action-markBorrowed  = if_abap_behv=>mk-on )
      RESULT DATA(permissions).

    cl_abap_unit_assert=>assert_equals( exp = 1 act = lines( permissions-instances ) msg = 'Features for one book' ).
    DATA(features) = permissions-instances[ 1 ].
    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv=>fc-o-disabled act = features-%action-markAvailable
                                        msg = 'An available book cannot be marked available again' ).
    cl_abap_unit_assert=>assert_equals( exp = if_abap_behv=>fc-o-enabled act = features-%action-markBorrowed
                                        msg = 'An available book can be borrowed' ).
  ENDMETHOD.