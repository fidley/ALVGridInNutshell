*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
REPORT zdemo_ain_cl41s.

INCLUDE zdemo_ain_include_screen.

CLASS lcl_alv DEFINITION CREATE PUBLIC FINAL.
  PUBLIC SECTION.
    DATA: grid TYPE REF TO cl_gui_alv_grid.
    METHODS: constructor.
    METHODS: prepare_display CHANGING output_table TYPE STANDARD TABLE.
  PRIVATE SECTION.
    DATA: fcat TYPE lvc_t_fcat.
    METHODS init_grid.
    METHODS prepare_fcat.
    METHODS activate_reprep_interface.
    METHODS set_handlers.
    METHODS double_click FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_row
                e_column
                es_row_no.
ENDCLASS.

CLASS lcl_alv IMPLEMENTATION.

  METHOD constructor.
    init_grid( ).
    prepare_fcat( ).
    activate_reprep_interface( ).
    set_handlers(  ).
  ENDMETHOD.

  METHOD activate_reprep_interface.

    grid->activate_reprep_interface(
       EXPORTING
         is_reprep = VALUE #(   s_rprp_id = VALUE #( tool = 'RT' onam = sy-repid )
                                cb_repid = sy-repid
                                cb_frm_mod = 'CALLBACK_FOR_SELECTION'  )
       EXCEPTIONS
         no_sender = 1
         OTHERS    = 2
     ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.



  METHOD prepare_fcat.

    fcat = VALUE lvc_t_fcat(
                                   ( fieldname = 'CARRID' )
                                   ( fieldname = 'CONNID' )
                                   ( fieldname = 'COUNTRYFR' )
                                   ( fieldname = 'CITYFROM' reprep = abap_true rollname = 'S_FROM_CIT' )
                                   ( fieldname = 'AIRPFROM' ref_field = 'AIRPFROM' ref_table = 'SPFLI' )
                                   ( fieldname = 'COUNTRYTO' )
                                   ( fieldname = 'CITYTO' )
                                   ( fieldname = 'FLTIME' )
                                   ( fieldname = 'DEPTIME' )
                                   ( fieldname = 'FLTYPE' )
                                 ).

  ENDMETHOD.



  METHOD init_grid.

    grid = NEW cl_gui_alv_grid(
                    i_parent = NEW cl_gui_custom_container( container_name = 'CC' )
                                   ).

  ENDMETHOD.



  METHOD prepare_display.
    grid->set_table_for_first_display(
      EXPORTING
          is_layout = VALUE #( col_opt = abap_true )
      CHANGING
        it_fieldcatalog               = fcat
        it_outtab                     = output_table
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4
    ).
  ENDMETHOD.


  METHOD set_handlers.
    SET HANDLER double_click FOR grid.
  ENDMETHOD.


  METHOD double_click.
    DATA: rri_command TYPE sy-ucomm VALUE '&EB9'.
    grid->set_function_code(
      CHANGING
        c_ucomm = rri_command ).
  ENDMETHOD.

ENDCLASS.

FORM callback_for_selection TABLES selection_data STRUCTURE rstisel
                                   field_information STRUCTURE rstifields
                            USING
                              communication  TYPE kkblo_reprep_communication.


ENDFORM.

START-OF-SELECTION.

  SELECT * UP TO 50 ROWS FROM spfli
    INTO TABLE @DATA(flights).
  NEW lcl_alv(  )->prepare_display(  CHANGING output_table = flights  ).
  IF sy-subrc EQ 0.
    CALL SCREEN 0100.
  ENDIF.
