*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl02
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl02.
include zdemo_ain_include_screen.

initialization.

select * up to 50 rows from spfli into table @data(flights).

 data(split) = new cl_gui_splitter_container(
      parent                  = new cl_gui_custom_container( container_name = 'CC' )
      rows                    = 2
      columns                 = 1
                                            ).
  data(grid) = new cl_gui_alv_grid(
                    i_parent = split->get_container( row = 1 column = 1 )
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
