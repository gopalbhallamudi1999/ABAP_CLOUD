  METHOD class_setup.
    sql_test_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'ZBOOK_A' ) ) ).
  ENDMETHOD.