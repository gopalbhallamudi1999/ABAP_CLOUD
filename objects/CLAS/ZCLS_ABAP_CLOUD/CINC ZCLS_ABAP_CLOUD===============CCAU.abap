CLASS ltc_abap_cloud DEFINITION
  FINAL
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.

    DATA mo_cut TYPE REF TO zcls_abap_cloud.

    METHODS setup.
    METHODS test_validate_employee FOR TESTING.
    METHODS test_calculate_bonus FOR TESTING.
    METHODS test_validate_email FOR TESTING.
    METHODS test_validate_quantity FOR TESTING.
    METHODS test_calculate_discount FOR TESTING.
    METHODS test_calculate_net_amount FOR TESTING.
    METHODS test_get_employee_grade FOR TESTING.
    METHODS test_check_date_range FOR TESTING.
    METHODS test_format_employee_name FOR TESTING.
    METHODS test_validate_currency_amount FOR TESTING.
    METHODS test_calculate_tax FOR TESTING.
    METHODS test_check_minimum_order FOR TESTING.
    METHODS test_calculate_average FOR TESTING.
    METHODS test_validate_bonus_percentage FOR TESTING.

ENDCLASS.


CLASS ltc_abap_cloud IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW zcls_abap_cloud( ).
  ENDMETHOD.


  METHOD test_validate_employee.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_employee(
        iv_employee_name = 'Gopal'
        iv_salary = 50000 )
      exp = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_employee(
        iv_employee_name = ''
        iv_salary = 50000 )
      exp = abap_false ).

  ENDMETHOD.


  METHOD test_calculate_bonus.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->calculate_bonus(
        iv_salary = 50000
        iv_bonus_percent = 10 )
      exp = CONV decfloat34( '5000' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->calculate_bonus(
        iv_salary = 50000
        iv_bonus_percent = 150 )
      exp = CONV decfloat34( '0' ) ).

  ENDMETHOD.


  METHOD test_validate_email.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_email(
        iv_email = 'user@example.com' )
      exp = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_email(
        iv_email = 'invalid' )
      exp = abap_false ).

  ENDMETHOD.


  METHOD test_validate_quantity.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_quantity(
        iv_quantity = 10 )
      exp = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_quantity(
        iv_quantity = 0 )
      exp = abap_false ).

  ENDMETHOD.


  METHOD test_calculate_discount.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->calculate_discount(
        iv_amount = 1000
        iv_percent = 10 )
      exp = CONV decfloat34( '100' ) ).

  ENDMETHOD.


  METHOD test_calculate_net_amount.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->calculate_net_amount(
        iv_amount = 1000
        iv_discount_percent = 10 )
      exp = CONV decfloat34( '900' ) ).

  ENDMETHOD.


  METHOD test_get_employee_grade.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->get_employee_grade(
        iv_salary = 100000 )
      exp = 'A' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->get_employee_grade(
        iv_salary = 50000 )
      exp = 'B' ).

  ENDMETHOD.


  METHOD test_check_date_range.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->check_date_range(
        iv_start_date = '20260101'
        iv_end_date = '20261231' )
      exp = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->check_date_range(
        iv_start_date = '20261231'
        iv_end_date = '20260101' )
      exp = abap_false ).

  ENDMETHOD.


  METHOD test_format_employee_name.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->format_employee_name(
        iv_name = '  gopal bhallamudi  ' )
      exp = 'GOPAL BHALLAMUDI' ).

  ENDMETHOD.


  METHOD test_validate_currency_amount.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_currency_amount(
        iv_amount = 100 )
      exp = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_currency_amount(
        iv_amount = -1 )
      exp = abap_false ).

  ENDMETHOD.


  METHOD test_calculate_tax.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->calculate_tax(
        iv_amount = 1000
        iv_tax_percent = 18 )
      exp = CONV decfloat34( '180' ) ).

  ENDMETHOD.


  METHOD test_check_minimum_order.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->check_minimum_order(
        iv_quantity = 10
        iv_minimum = 5 )
      exp = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->check_minimum_order(
        iv_quantity = 2
        iv_minimum = 5 )
      exp = abap_false ).

  ENDMETHOD.


  METHOD test_calculate_average.

    DATA lv_unused_value TYPE i.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->calculate_average(
        iv_value1 = 10
        iv_value2 = 20 )
      exp = CONV decfloat34( '15' ) ).

  ENDMETHOD.


  METHOD test_validate_bonus_percentage.

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_bonus_percentage(
        iv_percent = 50 )
      exp = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_bonus_percentage(
        iv_percent = 101 )
      exp = abap_false ).

  ENDMETHOD.

ENDCLASS.