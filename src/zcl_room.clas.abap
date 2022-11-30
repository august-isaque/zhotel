class zcl_room definition
  public
  create public .

  public section.

    methods:
      constructor       importing iv_number       type integer
                                  iv_name         type string128
                                  iv_status       type string128
                                  iv_smoke        type boolean
                                  iv_room_type_id type ref to zcl_room_type
                                  iv_id           TYPE integer OPTIONAL,

      set_number        importing iv_number type integer,
      get_number        returning value(return) type integer,
      set_status        importing iv_status type string128,
      get_status        returning value(return) type string128,
      set_smoke         importing iv_smoke type boolean,
      get_smoke         returning value(return) type boolean,
      set_room_type_id  importing iv_room_type_id type REF TO zcl_room_type,
      get_room_type_id  returning value(return) type REF TO zcl_room_type,
      set_name importing iv_name type string128,
      get_name returning value(return) type string128,
      save importing io_room type ref to zcl_room,
      get_next_id returning value(return) type integer.





  protected section.
  private section.

    data number type integer .
    data name type string128 .
    data status type string128 .
    data smoke type boolean .
    data room_type_id type REF TO zcl_room_type.

ENDCLASS.



CLASS ZCL_ROOM IMPLEMENTATION.


  method constructor.
    me->number        = iv_number.
    me->name          = iv_name.
    me->status        = iv_status.
    me->smoke         = iv_smoke.
    me->room_type_id  = iv_room_type_id.
  endmethod.


  method get_name.
    return = me->name.
  endmethod.


  method get_next_id.
    select max( id ) from zroom into @data(i).
    if sy-subrc <> 0.
      return = '00001'.
    else.
      return = i + 1.
    endif.
  endmethod.


  method get_number.
    return = me->number.
  endmethod.


  method get_room_type_id.
    return = me->room_type_id.
  endmethod.


  method get_smoke.
    return = me->smoke.
  endmethod.


  method get_status.
    return = me->status.
  endmethod.


  method save.
    data: wa_room type zroom.


    wa_room-id = get_next_id( ).
    wa_room-name = io_room->get_name( ).
    wa_room-smoke = io_room->get_smoke( ).
    wa_room-status = io_room->get_status( ).
    wa_room-room_type_id = io_room->get_room_type_id( )->get_id( ).
    wa_room-room_number = io_room->get_number( ).

    insert zroom from wa_room.

  endmethod.


  method set_name.
    me->name = iv_name.
  endmethod.


  method set_number.
    me->number = iv_number.
  endmethod.


  method set_room_type_id.
    me->room_type_id = iv_room_type_id.
  endmethod.


  method set_smoke.
    me->smoke = iv_smoke.
  endmethod.


  method set_status.
    me->status = iv_status.
  endmethod.
ENDCLASS.
