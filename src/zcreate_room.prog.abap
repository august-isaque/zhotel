*&---------------------------------------------------------------------*
*& Report ZCREATE_ROOM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_room.

selection-screen begin of block b1 with frame title text-001.
parameters: p_name   type string128,
            p_number type integer,
            p_status type string128,
            p_smoke  type boolean,
            p_rtype  type integer matchcode object zrtype.



selection-screen end of block b1.

data: lo_room  type ref to zcl_room,
      lo_rtype type ref to zcl_room_type.

call method zcl_room_type=>get_room_type_by_id
  exporting
    iv_id  = p_rtype
  receiving
    return = lo_rtype.
.


create object lo_room
  exporting
*   iv_id           =
    iv_number       = p_number
    iv_name         = p_name
    iv_status       = p_status
    iv_smoke        = p_smoke
    iv_room_type_id = lo_rtype.


lo_room->save( lo_room ).
