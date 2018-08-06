*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl23
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl23.

include zdemo_ain_include_screen.

parameters: p_noconv type lvc_s_fcat-no_convext as checkbox.


start-of-selection.

  types: begin of t_data,
           spras   type t002c-spras,
         end of t_data.
  data languages type standard table of t_data.

 select spras
    up to 50 rows  from t002c
    into corresponding fields of table @languages.

  data(grid) = new cl_gui_alv_grid(
                    i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                   ).
  data(fcat) = value lvc_t_fcat(
                                 ( fieldname = 'SPRAS' no_convext = p_noconv ref_field = 'SPRAS' ref_table = 'T002C'  )
                               ).

  grid->set_table_for_first_display(
    changing
      it_fieldcatalog               = fcat
      it_outtab                     = languages
    exceptions
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      others                        = 4
  ).
  if sy-subrc eq 0.
    call screen 0100.
  endif.
