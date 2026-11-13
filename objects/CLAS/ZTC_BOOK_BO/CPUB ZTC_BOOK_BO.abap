"! <p class="shorttext synchronized">ABAP Unit tests for the Book business object ZR_BOOK</p>
"! Black-box tests through EML. Books are created in the RAP transactional buffer and
"! rolled back after each test; table ZBOOK_A is replaced by an SQL test double,
"! so the tests never change real book data.
"! @testing BDEF:ZR_BOOK
CLASS ztc_book_bo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.
