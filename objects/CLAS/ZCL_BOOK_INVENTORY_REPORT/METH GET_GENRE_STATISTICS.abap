  METHOD get_genre_statistics.
    SELECT genre, price
      FROM zbook_a
      WHERE genre IS NOT INITIAL
      INTO TABLE @DATA(books).

    LOOP AT books INTO DATA(book).
      " ATC INFO: SELECT SINGLE without the full key is possibly not unique
      SELECT SINGLE genre FROM zbook_a WHERE genre = @book-genre INTO @DATA(genre).

      READ TABLE result ASSIGNING FIELD-SYMBOL(<statistic>) WITH KEY genre = genre.
      IF sy-subrc <> 0.
        APPEND VALUE #( genre = genre ) TO result ASSIGNING <statistic>.
      ENDIF.
      <statistic>-book_count  = <statistic>-book_count + 1.
      <statistic>-total_price = <statistic>-total_price + book-price.
    ENDLOOP.
  ENDMETHOD.