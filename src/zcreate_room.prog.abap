*&---------------------------------------------------------------------*
*& Report ZCREATE_ROOM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_room.



selection-screen begin of block b1 with frame title text-001.
parameters: p_name   type string128 OBLIGATORY,
            p_number type integer OBLIGATORY,
            p_status type string128 OBLIGATORY,
            p_smoke  type boolean OBLIGATORY,
            p_rtype  type integer matchcode object zrtype OBLIGATORY.

selection-screen end of block b1.

data: lo_room  type ref to zcl_room,
      lo_rtype type ref to zcl_room_type.

initialization.

at selection-screen output.
  perform clean_screen.

at selection-screen.
  perform get_room_type.
  perform create_room.

form get_room_type.

  call method zcl_room_type=>get_room_type_by_id
    exporting
      iv_id  = p_rtype
    receiving
      return = lo_rtype.

  if lo_rtype is initial.
    message e208(00) with text-002 .
  endif.


endform.

form create_room.
  lo_room = new #(
      iv_number       = p_number
     iv_name         = p_name
     iv_status       = p_status
     iv_smoke        = p_smoke
     iv_room_type_id = lo_rtype
  ).
  lo_room->save( lo_room ).
  message text-003 type 'S'  .
endform.

form clean_screen.
  clear    p_name  .
  clear    p_number.
  clear    p_status.
  clear    p_smoke .
  clear    p_rtype  .

  modify screen.

endform.
