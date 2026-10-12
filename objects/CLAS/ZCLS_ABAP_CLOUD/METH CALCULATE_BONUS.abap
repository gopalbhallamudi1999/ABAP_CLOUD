  METHOD calculate_bonus.
    rv_bonus = 0.

    IF iv_salary <= 0
       OR iv_bonus_percent < 0
       OR iv_bonus_percent > 100.
      RETURN.
    ENDIF.

    rv_bonus = iv_salary * iv_bonus_percent / 100.
  ENDMETHOD.