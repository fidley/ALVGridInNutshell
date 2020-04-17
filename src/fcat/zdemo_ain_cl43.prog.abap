*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
REPORT zdemo_ain_cl43.

INCLUDE zdemo_ain_include_screen.


START-OF-SELECTION.

  SELECT * UP TO 50 ROWS FROM spfli
 INTO TABLE @DATA(flights).

  DATA(grid) = NEW cl_gui_alv_grid(
                 i_parent = NEW cl_gui_custom_container( container_name = 'CC' )
                                ).
  DATA(fcat) = VALUE lvc_t_fcat(
                                 ( fieldname = 'CARRID' ref_table = 'SPFLI' )
                                 ( fieldname = 'CONNID' ref_table = 'SPFLI' )
                                 ( fieldname = 'COUNTRYFR' sp_group = 1 ref_table = 'SPFLI' no_out = abap_true )
                                 ( fieldname = 'CITYFROM' sp_group = 1 ref_table = 'SPFLI' no_out = abap_true )
                                 ( fieldname = 'AIRPFROM' sp_group = 1 ref_table = 'SPFLI' no_out = abap_true )
                                 ( fieldname = 'COUNTRYTO' sp_group = 2 ref_table = 'SPFLI' no_out = abap_true )
                                 ( fieldname = 'CITYTO'  sp_group = 2 ref_table = 'SPFLI' no_out = abap_true )
                                 ( fieldname = 'FLTIME' ref_table = 'SPFLI' )
                                 ( fieldname = 'DEPTIME' ref_table = 'SPFLI' )
                                 ( fieldname = 'FLTYPE' ref_table = 'SPFLI' )
                               ).

  grid->set_table_for_first_display(
    EXPORTING
        is_layout = VALUE #( col_opt = abap_false edit = abap_true )
        it_special_groups = value #( ( sp_group  = 1 text = 'Group From' )
                                     ( sp_group  = 2 text = 'Group To' )
                                     )
    CHANGING
      it_fieldcatalog               = fcat
      it_outtab                     = flights
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4
  ).
  IF sy-subrc EQ 0.
    CALL SCREEN 0100.
  ENDIF.
