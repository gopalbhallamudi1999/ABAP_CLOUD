  PRIVATE SECTION.
    TYPES ty_book_key TYPE STRUCTURE FOR KEY OF zr_book.

    CLASS-DATA sql_test_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.
    METHODS setup.
    METHODS teardown.

    "! Creates one book in the transactional buffer (not saved) and returns its key
    METHODS create_book
      IMPORTING title         TYPE zr_book-Title
                author        TYPE zr_book-Author
                price         TYPE zr_book-Price
                currency_code TYPE zr_book-CurrencyCode
      RETURNING VALUE(result) TYPE ty_book_key.

    METHODS read_book
      IMPORTING book_key      TYPE ty_book_key
      RETURNING VALUE(result) TYPE zr_book.

    METHODS new_book_gets_id_and_status FOR TESTING RAISING cx_static_check.
    METHODS book_ids_are_sequential     FOR TESTING RAISING cx_static_check.
    METHODS negative_price_is_rejected  FOR TESTING RAISING cx_static_check.
    METHODS price_needs_currency        FOR TESTING RAISING cx_static_check.
    METHODS mark_borrowed_sets_status   FOR TESTING RAISING cx_static_check.
    METHODS mark_available_sets_status  FOR TESTING RAISING cx_static_check.
    METHODS only_useful_action_enabled  FOR TESTING RAISING cx_static_check.