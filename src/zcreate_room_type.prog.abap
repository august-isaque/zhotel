*&---------------------------------------------------------------------*
*& Report ZCREATE_ROOM_TYPE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_room_type.

start-of-selection.

  selection-screen begin of block b1 with frame title text-001.
  parameters: p_desc   type string128 OBLIGATORY,
              p_maxcap type integer OBLIGATORY.

  selection-screen end of block b1.

  data: lo_rtype type ref to zcl_room_type.

at SELECTION-SCREEN OUTPUT.
  PERFORM clean_screen.

AT SELECTION-SCREEN.
  PERFORM create_room_type.

form create_room_type.

  create object lo_rtype
    exporting
      iv_description  = p_desc
      iv_max_capacity = p_maxcap.

 lo_rtype->save( lo_rtype ).
  message text-002 type 'S'  .
 ENDFORM.

 form clean_screen.
   clear p_desc  .
   clear p_maxcap.
   MODIFY SCREEN.
 ENDFORM.
