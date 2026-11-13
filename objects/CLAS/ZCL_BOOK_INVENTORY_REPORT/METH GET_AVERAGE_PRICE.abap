  METHOD get_average_price.
    IF book_count > 0.
      result = total_price / book_count.
    ENDIF.
  ENDMETHOD.