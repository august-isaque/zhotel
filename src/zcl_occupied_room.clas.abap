class zcl_occupied_room definition
  public
  final
  create public .

  public section.

    methods:
      constructor IMPORTING iv_check_in TYPE timestamp iv_check_out TYPE timestamp iv_room_id TYPE REF TO zcl_room iv_reservation_id TYPE REF TO zcl_reservation,
      set_check_in importing iv_check_in type timestamp,
      get_check_in returning value(return) type timestamp,
      set_check_out importing iv_check_out type timestamp,
      get_check_out returning value(return) type timestamp,
      set_room_id importing iv_room_id type ref to zcl_room,
      get_room_id returning value(return) type ref to zcl_room,
      set_reservation_id importing iv_reservation_id type ref to zcl_reservation,
      get_reservation_id returning value(return) type ref to zcl_reservation.

  protected section.
  private section.

    data check_in type timestamp .
    data check_out type timestamp .
    data room_id type ref to  zcl_room.
    data reservation_id type ref to zcl_reservation .
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


  method get_reservation_id.
    return = me->reservation_id.
  endmethod.


  method get_room_id.
    return = me->room_id.
  endmethod.


  method set_check_in.
    me->check_in = iv_check_in.
  endmethod.


  method set_check_out.
    me->check_out = iv_check_out.
  endmethod.


  method set_reservation_id.
    me->reservation_id = iv_reservation_id.
  endmethod.


  method set_room_id.
    me->room_id = iv_room_id.
  endmethod.
ENDCLASS.
