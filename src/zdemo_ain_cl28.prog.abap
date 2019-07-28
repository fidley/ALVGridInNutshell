*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl28
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl28.

include zdemo_ain_include_screen.

start-of-selection.

  select * up to 50 rows from spfli
    into table @data(flights).

  data(grid) = new cl_gui_alv_grid(
                    i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                   ).
  data(fcat) = value lvc_t_fcat(
                                 ( fieldname = 'CARRID'  )
                                 ( fieldname = 'CONNID' )
                                 ( fieldname = 'COUNTRYFR' )
                                 ( fieldname = 'CITYFROM'  )
                                 ( fieldname = 'AIRPFROM'  )
                                 ( fieldname = 'COUNTRYTO' )
                                 ( fieldname = 'CITYTO' )
                                 ( fieldname = 'FLTIME' )
                                 ( fieldname = 'DEPTIME' )
                                 ( fieldname = 'ARRTIME' )
                                 ( fieldname = 'DISTANCE' no_sum = abap_true qfieldname = 'DISTID' )
                                 ( fieldname = 'DISTID')

                               ).
  grid->set_table_for_first_display(
    exporting
        is_layout = value #( col_opt = abap_true )
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
