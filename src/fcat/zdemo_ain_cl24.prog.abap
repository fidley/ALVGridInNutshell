*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl24
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl24.

include zdemo_ain_include_screen.

parameters: p_edmLL radiobutton group edm default 'X',
            p_edmRR radiobutton group edm,
            p_edmCE radiobutton group edm,
            p_edmFT radiobutton group edm.

start-of-selection.

  types: begin of t_data,
           carrid   type spfli-carrid,
           connid   type spfli-connid,
           distance type spfli-distance,
           distid   type spfli-distid,
         end of t_data.
  data flights type standard table of t_data.

  select carrid, connid, distance, distid
    up to 50 rows from spfli
    into corresponding fields of table @flights.

  data(grid) = new cl_gui_alv_grid(
                    i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                   ).
  data(fcat) = value lvc_t_fcat(
                                 ( fieldname = 'CARRID' )
                                 ( fieldname = 'CONNID' edit_mask = cond #( when p_edmLL eq abap_true then 'LL__:__:__'
                                                                            when p_edmRR eq abap_true then 'RR__:__:__'
                                                                            when p_edmCE eq abap_true then '==ALPHA'
                                                                            when p_edmFT eq abap_true then 'Flight Number is: ____' ) )
                                 ( fieldname = 'DISTANCE' qfieldname = 'DISTID' edit_mask = 'V______' )
                                 ( fieldname = 'DISTID' )
                               ).
  grid->register_edit_event( i_event_id = cl_gui_alv_grid=>mc_evt_modified ).
  grid->set_table_for_first_display(
    exporting
        is_layout = value #( edit = abap_true col_opt = abap_true )
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
