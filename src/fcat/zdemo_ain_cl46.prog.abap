*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
REPORT zdemo_ain_cl46.

INCLUDE zdemo_ain_include_screen.

PARAMETERS: ver1 RADIOBUTTON GROUP gr1 DEFAULT 'X',
            ver2 RADIOBUTTON GROUP gr1.

CLASS lcl_alv DEFINITION CREATE PUBLIC FINAL.
  PUBLIC SECTION.
    DATA: flights TYPE STANDARD TABLE OF spfli.

    METHODS display.
    METHODS select_flights.
  PROTECTED SECTION.
    DATA: grid TYPE REF TO cl_gui_alv_grid,
          fcat TYPE lvc_t_fcat.
    METHODS prepare_fcat_version_1.
    METHODS prepare_fcat_version_2.
    METHODS create_grid.
    METHODS show_grid.

ENDCLASS.

CLASS lcl_alv IMPLEMENTATION.


  METHOD create_grid.
    grid = NEW cl_gui_alv_grid(
                 i_parent = NEW cl_gui_custom_container( container_name = 'CC' )
                                ).
  ENDMETHOD.

  METHOD display.
    create_grid( ).
    IF ver1 EQ abap_true.
      prepare_fcat_version_1( ).
    ELSE.
      prepare_fcat_version_2( ).
    ENDIF.
    show_grid( ).
  ENDMETHOD.

  METHOD show_grid.
    grid->set_table_for_first_display(
    EXPORTING
        is_layout = VALUE #( col_opt = abap_true )
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
  ENDMETHOD.


  METHOD prepare_fcat_version_1.
    fcat = VALUE lvc_t_fcat(
                                   ( fieldname = 'CARRID' ref_table = 'SPFLI' col_id = 3 )
                                   ( fieldname = 'CONNID' ref_table = 'SPFLI' col_id = 4 )
                                   ( fieldname = 'COUNTRYFR'  ref_table = 'SPFLI' col_id = 1 )
                                   ( fieldname = 'CITYFROM'  ref_table = 'SPFLI' col_id = 2 )
                                   ( fieldname = 'AIRPFROM'  ref_table = 'SPFLI'  col_id = 5 )
                                   ( fieldname = 'COUNTRYTO' ref_table = 'SPFLI' col_id = 6  )
                                   ( fieldname = 'CITYTO'   ref_table = 'SPFLI'  col_id = 7  )
                                   ( fieldname = 'FLTIME' ref_table = 'SPFLI' col_id = 8 )
                                   ( fieldname = 'DEPTIME' ref_table = 'SPFLI' col_id = 9  )
                                   ( fieldname = 'FLTYPE' ref_table = 'SPFLI' col_id = 11  )
                                 ).

  ENDMETHOD.

  METHOD prepare_fcat_version_2.
    fcat = VALUE lvc_t_fcat(
                                   ( fieldname = 'CONNID' ref_table = 'SPFLI' col_id = 4 col_pos = 10 )
                                   ( fieldname = 'COUNTRYFR' ref_table = 'SPFLI' col_id = 1  col_pos = 9 )
                                   ( fieldname = 'CITYFROM' ref_table = 'SPFLI' col_id = 2 col_pos = 8 )
                                   ( fieldname = 'AIRPFROM'  ref_table = 'SPFLI' col_id = 5 col_pos = 7 )
                                   ( fieldname = 'COUNTRYTO' ref_table = 'SPFLI' col_id = 6 col_pos = 6 )
                                   ( fieldname = 'CITYTO' ref_table = 'SPFLI' col_id = 7 col_pos = 5 )
                                   ( fieldname = 'FLTIME' ref_table = 'SPFLI' col_id = 8 col_pos = 4 )
                                   ( fieldname = 'DEPTIME' ref_table = 'SPFLI' col_id = 9  col_pos = 3  )
                                   ( fieldname = 'FLTYPE' ref_table = 'SPFLI' col_id = 11  col_pos = 2  )
                                   ( fieldname = 'CARRID' ref_table = 'SPFLI' col_id = 3  col_pos = 1 )
                                 ).
    sort fcat by fieldname.

  ENDMETHOD.

  METHOD select_flights.
    SELECT * UP TO 50 ROWS FROM spfli INTO CORRESPONDING FIELDS OF TABLE @flights.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA(alv) = NEW lcl_alv( ).
  alv->select_flights( ).
  alv->display( ).
