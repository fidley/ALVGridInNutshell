*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl24
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
*&- 1st character ='C' if we're using custom colour or 'X' for default *
*&- 2nd character = colour code (from 0 to 7)                          *
*&                                  0 = background colour              *
*&                                  1 = blue                           *
*&                                  2 = gray                           *
*&                                  3 = yellow                         *
*&                                  4 = blue/gray                      *
*&                                  5 = green                          *
*&                                  6 = red                            *
*&                                  7 = orange                         *
*&- 3rd character = intensified (0=off, 1=on)                          *
*&- 4th character = inverse display (0=off, 1=on)                      *
*&---------------------------------------------------------------------*
report zdemo_ain_cl24.

include zdemo_ain_include_screen.

start-of-selection.

  types: begin of t_data,
           no_emphasize type spfli-carrid,
           standard     type spfli-carrid,
           c100         type spfli-carrid,
           c101         type spfli-carrid,
           c110         type spfli-carrid,
           c111         type spfli-carrid,
           c200         type spfli-carrid,
           c201         type spfli-carrid,
           c210         type spfli-carrid,
           c211         type spfli-carrid,
           c300         type spfli-carrid,
           c301         type spfli-carrid,
           c310         type spfli-carrid,
           c311         type spfli-carrid,
           c400         type spfli-carrid,
           c401         type spfli-carrid,
           c410         type spfli-carrid,
           c411         type spfli-carrid,
           c500         type spfli-carrid,
           c501         type spfli-carrid,
           c510         type spfli-carrid,
           c511         type spfli-carrid,
           c600         type spfli-carrid,
           c601         type spfli-carrid,
           c610         type spfli-carrid,
           c611         type spfli-carrid,
           c700         type spfli-carrid,
           c701         type spfli-carrid,
           c710         type spfli-carrid,
           c711         type spfli-carrid,
           c000         type spfli-carrid,
           c001         type spfli-carrid,
           c010         type spfli-carrid,
           c011         type spfli-carrid,
         end of t_data.
  data flights type standard table of t_data.

  select carrid as no_emphasize
    up to 50 rows from spfli
    into corresponding fields of table @flights.

  loop at flights assigning field-symbol(<fl>).
    <fl>-standard = <fl>-c100 = <fl>-c101 = <fl>-c110 = <fl>-c111 =
                <fl>-c200 = <fl>-c201 = <fl>-c210 = <fl>-c211 =
                <fl>-c300 = <fl>-c301 = <fl>-c310 = <fl>-c311 =
                <fl>-c400 = <fl>-c401 = <fl>-c410 = <fl>-c411 =
                <fl>-c500 = <fl>-c501 = <fl>-c510 = <fl>-c511 =
                <fl>-c600 = <fl>-c601 = <fl>-c610 = <fl>-c611 =
                <fl>-c700 = <fl>-c701 = <fl>-c710 = <fl>-c711 =
                <fl>-c000 = <fl>-c001 = <fl>-c010 = <fl>-c011 = <fl>-no_emphasize.

  endloop.

  data(grid) = new cl_gui_alv_grid(
                    i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                   ).
  data(fcat) = value lvc_t_fcat(
                                 ( fieldname = 'NO_EMPHASIZE' reptext = 'NO_EMPHASIZE' )
                                 ( fieldname = 'STANDARD' emphasize = abap_true reptext = 'STANDARD' )
                                 ( fieldname = 'C100' emphasize = 'C100' reptext = 'C100')
                                 ( fieldname = 'C101' emphasize = 'C101' reptext = 'C101')
                                 ( fieldname = 'C110' emphasize = 'C110' reptext = 'C110')
                                 ( fieldname = 'C111' emphasize = 'C111' reptext = 'C111')
                                 ( fieldname = 'C200' emphasize = 'C200' reptext = 'C200')
                                 ( fieldname = 'C201' emphasize = 'C201' reptext = 'C201')
                                 ( fieldname = 'C210' emphasize = 'C210' reptext = 'C210')
                                 ( fieldname = 'C211' emphasize = 'C211' reptext = 'C211')
                                 ( fieldname = 'C300' emphasize = 'C300' reptext = 'C300')
                                 ( fieldname = 'C301' emphasize = 'C301' reptext = 'C301')
                                 ( fieldname = 'C310' emphasize = 'C310' reptext = 'C310')
                                 ( fieldname = 'C311' emphasize = 'C311' reptext = 'C311')
                                 ( fieldname = 'C400' emphasize = 'C400' reptext = 'C400')
                                 ( fieldname = 'C401' emphasize = 'C401' reptext = 'C401')
                                 ( fieldname = 'C410' emphasize = 'C410' reptext = 'C410')
                                 ( fieldname = 'C411' emphasize = 'C411' reptext = 'C411')
                                 ( fieldname = 'C500' emphasize = 'C500' reptext = 'C500')
                                 ( fieldname = 'C501' emphasize = 'C501' reptext = 'C501')
                                 ( fieldname = 'C510' emphasize = 'C510' reptext = 'C510')
                                 ( fieldname = 'C511' emphasize = 'C511' reptext = 'C511')
                                 ( fieldname = 'C600' emphasize = 'C600' reptext = 'C600')
                                 ( fieldname = 'C601' emphasize = 'C601' reptext = 'C601')
                                 ( fieldname = 'C610' emphasize = 'C610' reptext = 'C610')
                                 ( fieldname = 'C611' emphasize = 'C611' reptext = 'C611')
                                 ( fieldname = 'C700' emphasize = 'C700' reptext = 'C700')
                                 ( fieldname = 'C701' emphasize = 'C701' reptext = 'C701')
                                 ( fieldname = 'C710' emphasize = 'C710' reptext = 'C710')
                                 ( fieldname = 'C711' emphasize = 'C711' reptext = 'C711')
                                 ( fieldname = 'C000' emphasize = 'C000' reptext = 'C000')
                                 ( fieldname = 'C001' emphasize = 'C001' reptext = 'C001')
                                 ( fieldname = 'C010' emphasize = 'C010' reptext = 'C010')
                                 ( fieldname = 'C011' emphasize = 'C011' reptext = 'C011')
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
