*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl03
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl03.


parameters: dummy as checkbox.

at selection-screen output.
  select * up to 50 rows from spfli into table @data(flights).

  data(docking) = new cl_gui_docking_container(
                             side = cl_gui_docking_container=>dock_at_left
                             extension = 300
                             repid = sy-repid
                             dynnr = sy-dynnr
                                               ).
  data(grid) = new cl_gui_alv_grid(
                    i_parent = docking
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
