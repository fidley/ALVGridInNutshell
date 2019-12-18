*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl04
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl04.
include zdemo_ain_include_screen.

parameters: dummy as checkbox.

at selection-screen output.

  select * up to 50 rows from spfli into table @data(flights).

  data(dialog) = new cl_gui_dialogbox_container(
                 width    = 400
                 height   = 200
  ).

  data(grid) = new cl_gui_alv_grid(
                    i_parent = dialog
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
  endif.
