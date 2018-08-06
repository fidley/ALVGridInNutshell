*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl01
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl01.
include zdemo_ain_include_screen.

initialization.

select * up to 50 rows from spfli into table @data(flights).

data(grid) = new cl_gui_alv_grid(
                     i_parent = new cl_gui_custom_container( container_name = 'CC' )
                               ).
grid->set_table_for_first_display(
  exporting
    i_structure_name              = 'SPFLI'
  changing
    it_outtab                     = flights
  exceptions
    invalid_parameter_combination = 1
    program_error                 = 2
    too_many_lines                = 3
    others                        = 4
).
if sy-subrc eq 0.
  call screen 0100.
endif.
