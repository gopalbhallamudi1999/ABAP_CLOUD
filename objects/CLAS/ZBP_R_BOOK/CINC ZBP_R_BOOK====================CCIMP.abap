CLASS lhc_book DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF book_status,
        available TYPE c LENGTH 1 VALUE 'A',
        borrowed  TYPE c LENGTH 1 VALUE 'B',
      END OF book_status.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Book RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Book RESULT result.

    METHODS markAvailable FOR MODIFY
      IMPORTING keys FOR ACTION Book~markAvailable RESULT result.

    METHODS markBorrowed FOR MODIFY
      IMPORTING keys FOR ACTION Book~markBorrowed RESULT result.

    METHODS setInitialValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Book~setInitialValues.

    METHODS validatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Book~validatePrice.
ENDCLASS.

CLASS lhc_book IMPLEMENTATION.

  METHOD get_global_authorizations.
    " Simple demo: everyone may create, update and delete books.
    result = VALUE #( %create = if_abap_behv=>auth-allowed
                      %update = if_abap_behv=>auth-allowed
                      %delete = if_abap_behv=>auth-allowed ).
  ENDMETHOD.

  METHOD get_instance_features.
    " Only enable the action that actually changes the status
    READ ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(books).

    result = VALUE #( FOR book IN books
      ( %tky                   = book-%tky
        %action-markAvailable  = COND #( WHEN book-Status = book_status-available
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled )
        %action-markBorrowed   = COND #( WHEN book-Status = book_status-borrowed
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD markAvailable.
    MODIFY ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys ( %tky   = key-%tky
                                        Status = book_status-available ) ).

    READ ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(books).

    result = VALUE #( FOR book IN books ( %tky   = book-%tky
                                          %param = book ) ).
  ENDMETHOD.

  METHOD markBorrowed.
    MODIFY ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys ( %tky   = key-%tky
                                        Status = book_status-borrowed ) ).

    READ ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(books).

    result = VALUE #( FOR book IN books ( %tky   = book-%tky
                                          %param = book ) ).
  ENDMETHOD.

  METHOD setInitialValues.
    " Assign a readable sequential Book ID and default status on create
    READ ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        FIELDS ( BookID Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(books).

    DELETE books WHERE BookID IS NOT INITIAL.
    CHECK books IS NOT INITIAL.

    SELECT SINGLE FROM zbook_a
      FIELDS MAX( book_id )
      INTO @DATA(max_book_id).

    MODIFY ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        UPDATE FIELDS ( BookID Status )
        WITH VALUE #( FOR book IN books INDEX INTO i
                      ( %tky   = book-%tky
                        BookID = max_book_id + i
                        Status = book_status-available ) ).
  ENDMETHOD.

  METHOD validatePrice.
    READ ENTITIES OF zr_book IN LOCAL MODE
      ENTITY Book
        FIELDS ( Price CurrencyCode ) WITH CORRESPONDING #( keys )
      RESULT DATA(books).

    LOOP AT books INTO DATA(book).
      IF book-Price < 0.
        APPEND VALUE #( %tky = book-%tky ) TO failed-book.
        APPEND VALUE #( %tky           = book-%tky
                        %msg           = new_message_with_text(
                                           severity = if_abap_behv_message=>severity-error
                                           text     = 'Price must not be negative' )
                        %element-Price = if_abap_behv=>mk-on ) TO reported-book.
      ENDIF.

      IF book-Price > 0 AND book-CurrencyCode IS INITIAL.
        APPEND VALUE #( %tky = book-%tky ) TO failed-book.
        APPEND VALUE #( %tky                  = book-%tky
                        %msg                  = new_message_with_text(
                                                  severity = if_abap_behv_message=>severity-error
                                                  text     = 'Enter a currency for the price' )
                        %element-CurrencyCode = if_abap_behv=>mk-on ) TO reported-book.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
