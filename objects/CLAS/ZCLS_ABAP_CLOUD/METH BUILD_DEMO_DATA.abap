  METHOD build_demo_data.
    DATA lv_recent TYPE d.
    DATA lv_older  TYPE d.
    DATA lv_old    TYPE d.

    lv_recent = iv_base - 2.
    lv_older  = iv_base - 10.
    lv_old    = iv_base - 40.

    rt_rows = VALUE #(
      ( vbeln = '0000000101' posnr = '000010' vkorg = '1010' erdat = lv_recent
        kunnr = '0000100001' name1 = 'Alpha Retail'  matnr = 'TG11' maktx = 'Trading Good 11'
        kwmeng = 5  netwr = '1200.00' waerk = 'EUR' faksp = ''
        gbstk_h = 'A' lfstk_h = 'A' fkstk_h = 'A' )
      ( vbeln = '0000000101' posnr = '000020' vkorg = '1010' erdat = lv_recent
        kunnr = '0000100001' name1 = 'Alpha Retail'  matnr = 'TG12' maktx = 'Trading Good 12'
        kwmeng = 2  netwr = '1200.00' waerk = 'EUR' faksp = '01'
        gbstk_h = 'A' lfstk_h = 'A' fkstk_h = 'A' )
      ( vbeln = '0000000102' posnr = '000010' vkorg = '1010' erdat = lv_older
        kunnr = '0000100002' name1 = 'Beta Wholesale' matnr = 'FG01' maktx = 'Finished Good 01'
        kwmeng = 10 netwr = '4500.00' waerk = 'EUR' faksp = ''
        gbstk_h = 'B' lfstk_h = 'B' fkstk_h = 'A' )
      ( vbeln = '0000000103' posnr = '000010' vkorg = '1010' erdat = lv_older
        kunnr = '0000100003' name1 = 'Gamma Stores'  matnr = 'FG02' maktx = 'Finished Good 02'
        kwmeng = 1  netwr = '300.00'  waerk = 'EUR' faksp = ''
        gbstk_h = 'C' lfstk_h = 'C' fkstk_h = 'C' )
      ( vbeln = '0000000104' posnr = '000010' vkorg = '1010' erdat = lv_old
        kunnr = '0000100004' name1 = 'Delta Trading' matnr = 'TG11' maktx = 'Trading Good 11'
        kwmeng = 7  netwr = '840.00'  waerk = 'EUR' faksp = ''
        gbstk_h = 'A' lfstk_h = 'A' fkstk_h = 'A' )
      ( vbeln = '0000000201' posnr = '000010' vkorg = '1710' erdat = lv_recent
        kunnr = '0000200001' name1 = 'Omega Inc'     matnr = 'FG03' maktx = 'Finished Good 03'
        kwmeng = 3  netwr = '990.00'  waerk = 'USD' faksp = ''
        gbstk_h = 'A' lfstk_h = 'A' fkstk_h = 'A' ) ).
  ENDMETHOD.