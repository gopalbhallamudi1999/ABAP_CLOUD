*Changed the check out from QA to DEV*
CLASS ltc_sales_order_test DEFINITION FINAL
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    CONSTANTS c_today TYPE d VALUE '20260115'.

    DATA mo_cut TYPE REF TO zcls_abap_cloud.

    METHODS setup.

    METHODS recent_today        FOR TESTING.
    METHODS recent_edge_7       FOR TESTING.
    METHODS recent_future       FOR TESTING.
    METHODS not_recent_8        FOR TESTING.
    METHODS icon_green          FOR TESTING.
    METHODS icon_grey           FOR TESTING.
    METHODS header_open         FOR TESTING.
    METHODS header_completed    FOR TESTING.
    METHODS header_delivered    FOR TESTING.
    METHODS header_blank        FOR TESTING.
    METHODS item_open           FOR TESTING.
    METHODS item_blocked        FOR TESTING.
    METHODS sales_org_valid     FOR TESTING.
    METHODS sales_org_empty     FOR TESTING.
    METHODS max_rows_cut        FOR TESTING.
    METHODS max_rows_keep       FOR TESTING.
    METHODS post_process_recent FOR TESTING.
    METHODS post_process_old    FOR TESTING.
    METHODS get_data_header     FOR TESTING.
    METHODS get_data_item       FOR TESTING.
ENDCLASS.



CLASS ltc_sales_order_test IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD recent_today.
    cl_abap_unit_assert=>assert_true(
      act = mo_cut->is_recent( iv_date = c_today iv_today = c_today )
      msg = 'Today should be recent' ).
  ENDMETHOD.

  METHOD recent_edge_7.
    DATA lv_date TYPE d.
    lv_date = c_today - 7.
    cl_abap_unit_assert=>assert_true(
      act = mo_cut->is_recent( iv_date = lv_date iv_today = c_today )
      msg = 'Boundary 7 days should be recent' ).
  ENDMETHOD.

  METHOD recent_future.
    DATA lv_date TYPE d.
    lv_date = c_today + 1.
    cl_abap_unit_assert=>assert_true(
      act = mo_cut->is_recent( iv_date = lv_date iv_today = c_today )
      msg = 'Future date should be recent' ).
  ENDMETHOD.

  METHOD not_recent_8.
    DATA lv_date TYPE d.
    lv_date = c_today - 8.
    cl_abap_unit_assert=>assert_false(
      act = mo_cut->is_recent( iv_date = lv_date iv_today = c_today )
      msg = 'Older than 7 days should not be recent' ).
  ENDMETHOD.

  METHOD icon_green.
    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->recent_icon( abap_true )
      exp = '@5C@'
      msg = 'Recent icon should be green' ).
  ENDMETHOD.

  METHOD icon_grey.
    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->recent_icon( abap_false )
      exp = '@5D@'
      msg = 'Non-recent icon should be grey' ).
  ENDMETHOD.

  METHOD header_open.
    cl_abap_unit_assert=>assert_true(
      act = mo_cut->is_header_open( iv_overall = 'A' iv_delivery = 'A' iv_billing = 'A' )
      msg = 'Header with status A should be open' ).
  ENDMETHOD.

  METHOD header_completed.
    cl_abap_unit_assert=>assert_false(
      act = mo_cut->is_header_open( iv_overall = 'C' iv_delivery = 'A' iv_billing = 'A' )
      msg = 'Completed header should not be open' ).
  ENDMETHOD.

  METHOD header_delivered.
    cl_abap_unit_assert=>assert_false(
      act = mo_cut->is_header_open( iv_overall = 'A' iv_delivery = 'C' iv_billing = 'A' )
      msg = 'Fully delivered header should not be open' ).
  ENDMETHOD.

  METHOD header_blank.
    cl_abap_unit_assert=>assert_true(
      act = mo_cut->is_header_open( iv_overall = ' ' iv_delivery = ' ' iv_billing = ' ' )
      msg = 'Header with blank status should be open' ).
  ENDMETHOD.

  METHOD item_open.
    cl_abap_unit_assert=>assert_true(
      act = mo_cut->is_item_open( '  ' )
      msg = 'Item without billing block should be open' ).
  ENDMETHOD.

  METHOD item_blocked.
    cl_abap_unit_assert=>assert_false(
      act = mo_cut->is_item_open( '01' )
      msg = 'Item with billing block should not be open' ).
  ENDMETHOD.

  METHOD sales_org_valid.
    cl_abap_unit_assert=>assert_true(
      act = mo_cut->is_valid_sales_org( '1010' )
      msg = 'Sales Org 1010 should be valid' ).
  ENDMETHOD.

  METHOD sales_org_empty.
    cl_abap_unit_assert=>assert_false(
      act = mo_cut->is_valid_sales_org( '' )
      msg = 'Empty Sales Org should not be valid' ).
  ENDMETHOD.

  METHOD max_rows_cut.
    DATA(lt_rows) = VALUE zcls_abap_cloud=>tt_rows(
      ( vbeln = '1' ) ( vbeln = '2' ) ( vbeln = '3' ) ( vbeln = '4' ) ( vbeln = '5' ) ).
    mo_cut->apply_max_rows( EXPORTING iv_max = 3 CHANGING ct_rows = lt_rows ).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_rows )
      exp = 3
      msg = '5 rows capped at 3 should leave 3' ).
  ENDMETHOD.

  METHOD max_rows_keep.
    DATA(lt_rows) = VALUE zcls_abap_cloud=>tt_rows(
      ( vbeln = '1' ) ( vbeln = '2' ) ).
    mo_cut->apply_max_rows( EXPORTING iv_max = 5 CHANGING ct_rows = lt_rows ).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_rows )
      exp = 2
      msg = '2 rows with max 5 should stay 2' ).
  ENDMETHOD.

  METHOD post_process_recent.
    DATA(lt_rows) = VALUE zcls_abap_cloud=>tt_rows( ( vbeln = '1' erdat = c_today ) ).
    mo_cut->post_process( EXPORTING iv_today = c_today CHANGING ct_rows = lt_rows ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_rows[ 1 ]-iconrec
      exp = '@5C@'
      msg = 'Row created today should get green icon' ).
  ENDMETHOD.

  METHOD post_process_old.
    DATA lv_date TYPE d.
    lv_date = c_today - 10.
    DATA(lt_rows) = VALUE zcls_abap_cloud=>tt_rows( ( vbeln = '1' erdat = lv_date ) ).
    mo_cut->post_process( EXPORTING iv_today = c_today CHANGING ct_rows = lt_rows ).
    cl_abap_unit_assert=>assert_equals(
      act = lt_rows[ 1 ]-iconrec
      exp = '@5D@'
      msg = 'Row older than 7 days should get grey icon' ).
  ENDMETHOD.

  METHOD get_data_header.
    DATA lv_from TYPE d.
    lv_from = c_today - 30.
    DATA(lt_rows) = mo_cut->get_data( iv_sales_org = '1010'
                                      iv_date_from = lv_from
                                      iv_date_to   = c_today
                                      iv_mode      = zcls_abap_cloud=>c_mode_header ).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_rows )
      exp = 3
      msg = 'Header mode should return 3 open rows' ).
  ENDMETHOD.

  METHOD get_data_item.
    DATA lv_from TYPE d.
    lv_from = c_today - 30.
    DATA(lt_rows) = mo_cut->get_data( iv_sales_org = '1010'
                                      iv_date_from = lv_from
                                      iv_date_to   = c_today
                                      iv_mode      = zcls_abap_cloud=>c_mode_item ).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_rows )
      exp = 2
      msg = 'Item mode should return 2 open rows' ).
  ENDMETHOD.

ENDCLASS.