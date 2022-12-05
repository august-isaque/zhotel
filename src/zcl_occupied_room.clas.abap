class zcl_occupied_room definition
  public
  final
  create public .

  public section.

    methods:
      constructor importing iv_check_in type datum iv_check_out type datum iv_room_id type ref to zcl_room iv_reservation_id type ref to zcl_reservation,
      set_check_in importing iv_check_in type datum,
      get_check_in returning value(return) type datum,
      set_check_out importing iv_check_out type datum,
      get_check_out returning value(return) type datum,
      set_room_id importing iv_room_id type ref to zcl_room,
      get_room_id returning value(return) type ref to zcl_room,
      set_reservation_id importing iv_reservation_id type ref to zcl_reservation,
      get_reservation_id returning value(return) type ref to zcl_reservation,
      get_last_id returning value(return) type integer,
      set_id importing iv_id type i,
      get_id returning value(return) type i,
      save importing io_occupied_room type ref to zcl_occupied_room,
      get_next_id RETURNING VALUE(return) TYPE i.



  protected section.
  private section.

    data check_in type datum .
    data check_out type datum .
    data room_id type ref to  zcl_room.
    data reservation_id type ref to zcl_reservation .
    data id type i.
ENDCLASS.



CLASS ZCL_OCCUPIED_ROOM IMPLEMENTATION.


  method constructor.
    me->check_in = iv_check_in.
    me->check_out  = iv_check_out.
    me->room_id = iv_room_id.
    me->reservation_id = iv_reservation_id.
  endmethod.


  method get_check_in.
    return = me->check_in.
  endmethod.


  method get_check_out.
    return = me->check_out.
  endmethod.


  method get_id.
    return = me->id.
  endmethod.


  method get_last_id.
    select max( id ) from zoccupied_room into @data(i).
    return = i.
  endmethod.


  method get_next_id.


    select max( id ) from zoccupied_room into @data(i).
    if sy-subrc <> 0.
      return = '00001'.
    else.
      return = i + 1.
    endif.


  endmethod.


  method get_reservation_id.
    return = me->reservation_id.
  endmethod.


  method get_room_id.
    return = me->room_id.
  endmethod.


  method save.

    data: wa_occupied_room type zoccupied_room.

    wa_occupied_room-check_in = io_occupied_room->get_check_in( ).
    wa_occupied_room-check_out = io_occupied_room->get_check_out( ).
    wa_occupied_room-reservation_id = io_occupied_room->get_reservation_id( )->get_id( ).
    wa_occupied_room-room_id = io_occupied_room->get_room_id( )->get_id( ).
    wa_occupied_room-id = get_next_id( ).
    insert zoccupied_room from wa_occupied_room.

  endmethod.


  method set_check_in.
    me->check_in = iv_check_in.
  endmethod.


  method set_check_out.
    me->check_out = iv_check_out.
  endmethod.


  method set_id.
    me->id = iv_id.
  endmethod.


  method set_reservation_id.
    me->reservation_id = iv_reservation_id.
  endmethod.


  method set_room_id.
    me->room_id = iv_room_id.
  endmethod.
ENDCLASS.
