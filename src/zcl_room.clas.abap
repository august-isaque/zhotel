class zcl_room definition
  public
  create public .

  public section.
    class-methods:
      get_room_by_id importing iv_id         type i
                     returning value(return) type ref to zcl_room.
    methods:

      constructor       importing iv_number       type integer
                                  iv_name         type string128
                                  iv_status       type string128
                                  iv_smoke        type boolean
                                  iv_room_type_id type ref to zcl_room_type
                                  iv_id           type integer optional,

      set_number        importing iv_number type integer,
      get_number        returning value(return) type integer,
      set_status        importing iv_status type string128,
      get_status        returning value(return) type string128,
      set_smoke         importing iv_smoke type boolean,
      get_smoke         returning value(return) type boolean,
      set_room_type_id  importing iv_room_type_id type ref to zcl_room_type,
      get_room_type_id  returning value(return) type ref to zcl_room_type,
      set_name importing iv_name type string128,
      get_name returning value(return) type string128,
      save importing io_room type ref to zcl_room,
      get_next_id returning value(return) type integer,
      set_id importing iv_id type i,
      get_id returning value(return) type i,
      update_room importing io_room type ref to zcl_room.







  protected section.
  private section.

    data number type integer .
    data id type i.
    data name type string128 .
    data status type string128 .
    data smoke type boolean .
    data room_type_id type ref to zcl_room_type.

ENDCLASS.



CLASS ZCL_ROOM IMPLEMENTATION.


  method constructor.
    me->number        = iv_number.
    me->name          = iv_name.
    me->status        = iv_status.
    me->smoke         = iv_smoke.
    me->room_type_id  = iv_room_type_id.
    me->id            = iv_id.
  endmethod.


  method get_id.
    return = me->id.
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


  method get_room_by_id.
    select  zroom~id,
            zroom~room_number,
            zroom~name,
            zroom~status,
            zroom~smoke,
            zroom~room_type_id
      from zroom
      into table
        @data(lt_room)
      where
        zroom~id = @iv_id.

    data: ls_room like line of lt_room.
    read table lt_room into ls_room index 1.

    if sy-subrc = 0.
      data: lo_room  type ref to zcl_room,
            lo_rtype type ref to zcl_room_type.

      call method zcl_room_type=>get_room_type_by_id
        exporting
          iv_id  = ls_room-id
        receiving
          return = lo_rtype.

      create object lo_room
        exporting
          iv_number       = ls_room-room_number
          iv_name         = ls_room-name
          iv_status       = ls_room-status
          iv_smoke        = ls_room-smoke
          iv_room_type_id = lo_rtype
          iv_id           = ls_room-id.

      return = lo_room.

    endif.


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


  method set_id.
    me->id = iv_id.
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


  method update_room.
    update zroom
    set name = @io_room->name, room_number = @io_room->number, smoke = @io_room->smoke, status = @io_room->status
    where id = @io_room->id.
  endmethod.
ENDCLASS.
