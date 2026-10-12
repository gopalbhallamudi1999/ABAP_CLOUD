  METHOD validate_employee.
    rv_valid = abap_false.

    IF iv_employee_name IS INITIAL OR iv_salary <= 0.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.