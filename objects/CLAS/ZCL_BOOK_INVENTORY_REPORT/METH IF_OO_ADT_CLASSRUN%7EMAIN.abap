  METHOD if_oo_adt_classrun~main.
    out->write( |Inventory report { new_report_id( ) } for { get_report_owner( ) }| ).  " ATC INFO: text not translatable
    DATA(statistics) = get_genre_statistics( ).

    LOOP AT statistics INTO DATA(statistic).
      out->write( |{ statistic-genre }: { statistic-book_count } books, value { statistic-total_price }| ).
      out->write( |Average price: { get_average_price( book_count  = statistic-book_count
                                                       total_price = statistic-total_price ) }| ).
    ENDLOOP.
  ENDMETHOD.