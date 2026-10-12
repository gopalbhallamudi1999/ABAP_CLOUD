  METHOD get_employee_grade.
    rv_grade = 'INVALID'.

    IF iv_salary < 0.
      RETURN.
    ENDIF.

    IF iv_salary >= 100000.
      rv_grade = 'A'.
    ELSEIF iv_salary >= 50000.
      rv_grade = 'B'.
    ELSE.
      rv_grade = 'C'.
    ENDIF.
  ENDMETHOD.