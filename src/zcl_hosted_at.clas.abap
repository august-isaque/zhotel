class zcl_hosted_at definition
  public
  final
  create public .

  public section.

    methods:
      constructor           importing iv_guest_id         type ref to zcl_guest
                                      iv_occupied_room_id type ref to zcl_occupied_room,
      set_guest_id          importing iv_guest_id type ref to zcl_guest,
      get_guest_id          returning value(return) type ref to zcl_guest,
      set_occupied_room_id  importing iv_occupied_room_id type ref to zcl_occupied_room,
      get_occupied_room_id  returning value(return) type ref to zcl_occupied_room.

  protected section.
  private section.

    data guest_id type ref to zcl_guest .
    data occupied_room_id type ref to zcl_occupied_room.
ENDCLASS.



CLASS ZCL_HOSTED_AT IMPLEMENTATION.


  method constructor.
    me->guest_id = iv_guest_id.
    me->occupied_room_id = iv_occupied_room_id.
  endmethod.


  method get_guest_id.
    return = me->guest_id.
  endmethod.


  method get_occupied_room_id.
    return = me->occupied_room_id.
  endmethod.


  method set_guest_id.
    me->guest_id = iv_guest_id.
  endmethod.


  method set_occupied_room_id.
    me->occupied_room_id = iv_occupied_room_id.
  endmethod.
ENDCLASS.
