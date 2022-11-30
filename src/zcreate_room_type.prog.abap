*&---------------------------------------------------------------------*
*& Report ZCREATE_ROOM_TYPE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_room_type.

start-of-selection.

  selection-screen begin of block b1 with frame title text-001.
  parameters: p_desc   type string128,
              p_maxcap type integer.

  selection-screen end of block b1.

  data: lo_rtype type ref to zcl_room_type.

  create object lo_rtype
    exporting
      iv_description  = p_desc
      iv_max_capacity = p_maxcap.

 lo_rtype->save( lo_rtype ).
