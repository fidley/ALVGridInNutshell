*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl05
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl05.
include zdemo_ain_include_screen.

parameters: own_seq as checkbox.

start-of-selection.

select * up to 50 rows from spfli into table @data(flights).

data(grid) = new cl_gui_alv_grid(
                   i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                ).
if own_seq eq abap_true.
  data(fcat) = value lvc_t_fcat(
                                 ( fieldname = 'CARRID'
                                   col_pos   = 3 )

                                 ( fieldname = 'CONNID'
                                   col_pos   = 4  )

                                 ( fieldname = 'CITYFROM'
                                   col_pos   = 1 )

                                 ( fieldname = 'CITYTO'
                                   col_pos   = 2 )
                                 ).
endif.

grid->set_table_for_first_display(
  exporting
    i_structure_name              = 'SPFLI'
  changing
    it_fieldcatalog               = fcat
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
