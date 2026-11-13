"! <p class="shorttext synchronized">Book inventory report (ReleaseOwl ATC demo)</p>
"! Prints books per genre and the total stock value.
"! ATC DEMO: this class has no errors or warnings; ATC reports only a few info findings
"! (priority 3, marked "ATC INFO" below) to show in the ReleaseOwl ATC report.
CLASS zcl_book_inventory_report DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_genre_stat,
             genre       TYPE zbook_a-genre,
             book_count  TYPE i,
             total_price TYPE zbook_a-price,
           END OF ty_genre_stat,
           tt_genre_stat TYPE STANDARD TABLE OF ty_genre_stat WITH EMPTY KEY.

    METHODS get_genre_statistics
      RETURNING VALUE(result) TYPE tt_genre_stat.

    METHODS get_average_price
      IMPORTING book_count    TYPE i
                total_price   TYPE zbook_a-price
      RETURNING VALUE(result) TYPE zbook_a-price.

    METHODS get_report_owner
      RETURNING VALUE(result) TYPE string.

    METHODS new_report_id
      RETURNING VALUE(result) TYPE sysuuid_c32.