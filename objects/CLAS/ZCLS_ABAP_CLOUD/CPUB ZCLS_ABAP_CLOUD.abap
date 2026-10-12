CLASS zcls_abap_cloud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS validate_employee
      IMPORTING
        iv_employee_name TYPE string
        iv_salary        TYPE decfloat34
      RETURNING VALUE(rv_valid) TYPE abap_boolean.

    METHODS calculate_bonus
      IMPORTING
        iv_salary        TYPE decfloat34
        iv_bonus_percent TYPE decfloat34
      RETURNING VALUE(rv_bonus) TYPE decfloat34.

    METHODS validate_email
      IMPORTING iv_email TYPE string
      RETURNING VALUE(rv_valid) TYPE abap_boolean.

    METHODS validate_quantity
      IMPORTING iv_quantity TYPE i
      RETURNING VALUE(rv_valid) TYPE abap_boolean.

    METHODS calculate_discount
      IMPORTING
        iv_amount  TYPE decfloat34
        iv_percent TYPE decfloat34
      RETURNING VALUE(rv_discount) TYPE decfloat34.

    METHODS calculate_net_amount
      IMPORTING
        iv_amount           TYPE decfloat34
        iv_discount_percent TYPE decfloat34
      RETURNING VALUE(rv_net_amount) TYPE decfloat34.

    METHODS get_employee_grade
      IMPORTING iv_salary TYPE decfloat34
      RETURNING VALUE(rv_grade) TYPE string.

    METHODS check_date_range
      IMPORTING
        iv_start_date TYPE d
        iv_end_date   TYPE d
      RETURNING VALUE(rv_valid) TYPE abap_boolean.

    METHODS format_employee_name
      IMPORTING iv_name TYPE string
      RETURNING VALUE(rv_name) TYPE string.

    METHODS validate_currency_amount
      IMPORTING iv_amount TYPE decfloat34
      RETURNING VALUE(rv_valid) TYPE abap_boolean.

    METHODS calculate_tax
      IMPORTING
        iv_amount     TYPE decfloat34
        iv_tax_percent TYPE decfloat34
      RETURNING VALUE(rv_tax) TYPE decfloat34.

    METHODS check_minimum_order
      IMPORTING
        iv_quantity TYPE i
        iv_minimum  TYPE i
      RETURNING VALUE(rv_valid) TYPE abap_boolean.

    METHODS calculate_average
      IMPORTING
        iv_value1 TYPE decfloat34
        iv_value2 TYPE decfloat34
      RETURNING VALUE(rv_average) TYPE decfloat34.

    METHODS validate_bonus_percentage
      IMPORTING iv_percent TYPE decfloat34
      RETURNING VALUE(rv_valid) TYPE abap_boolean.
