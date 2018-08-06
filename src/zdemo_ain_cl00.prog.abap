*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl11
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl00.
include zdemo_ain_include_screen.

types: begin of t_data,
        connid type spfli-connid,
        distance type f,
        text type char3,
        numeric type c length 3,
        end of t_data,
        tt_data type standard table of t_data.
data: data type tt_data.

initialization.

select * up to 50 rows from spfli into corresponding fields of table data.

loop at data assigning field-symbol(<data>).
    <data>-text = zcl_falv=>symbol-locked.
    <data>-numeric = '000'.
endloop.



data(grid) = new cl_gui_alv_grid(
                  i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                 ).
data(fcat) = value lvc_t_fcat(
                               ( fieldname = 'CONNID' just = 'R'  )
                               ( fieldname = 'DISTANCE' "qfieldname = 'DISTID'
                                             exponent = 5 )
                                ( fieldname = 'TEXT' symbol = abap_true )
                                ( fieldname = 'NUMERIC' lzero = abap_false )
                                             ).

grid->set_table_for_first_display(
  changing
    it_fieldcatalog               = fcat
    it_outtab                     = data
  exceptions
    invalid_parameter_combination = 1
    program_error                 = 2
    too_many_lines                = 3
    others                        = 4
).
if sy-subrc eq 0.
  call screen 0100.
endif.
