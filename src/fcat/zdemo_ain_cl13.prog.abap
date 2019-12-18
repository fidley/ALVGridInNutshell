*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl13
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl13.
include zdemo_ain_include_screen.

types: begin of t_data,
        connid type spfli-connid,
        distance type f,
        end of t_data,
        tt_data type standard table of t_data.
data: data type tt_data.

parameters: p_exp type lvc_expont default 2.

start-of-selection.

select * up to 50 rows from spfli into corresponding fields of table data.


data(grid) = new cl_gui_alv_grid(
                  i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                 ).
data(fcat) = value lvc_t_fcat(
                               ( fieldname = 'CONNID' just = 'R'  )
                               ( fieldname = 'DISTANCE'   exponent = p_exp )
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
