*&---------------------------------------------------------------------*
*& Include          ZCREATE_RESERVATION_TOP
*&---------------------------------------------------------------------*
data: go_reservation   type ref to zcl_reservation,
      go_reserved_room type ref to zcl_reserved_room,
      go_occ_room      type ref to zcl_occupied_room,
      go_hosted_at     type ref to zcl_hosted_at,
      go_guest         type ref to zcl_guest,
      go_room          type ref to zcl_room.
