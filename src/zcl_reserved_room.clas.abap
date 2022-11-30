class ZCL_RESERVED_ROOM definition
  public
  final
  create public .

public section.

  methods:
  CONSTRUCTOR           IMPORTING iv_number_of_rooms TYPE integer
                                  iv_room_type_id TYPE REF TO zcl_room_type
                                  iv_reservation_id TYPE REF TO zcl_reservation
                                  iv_status TYPE string128,
  set_NUMBER_OF_ROOMS   IMPORTING iv_NUMBER_OF_ROOMS TYPE INTEGER,
  get_NUMBER_OF_ROOMS   RETURNING VALUE(return) TYPE INTEGER,
  set_ROOM_TYPE_ID      IMPORTING iv_ROOM_TYPE_ID TYPE REF TO ZCL_ROOM_TYPE,
  get_ROOM_TYPE_ID      RETURNING VALUE(return) TYPE REF TO ZCL_ROOM_TYPE,
  set_RESERVATION_ID    IMPORTING iv_RESERVATION_ID TYPE REF TO ZCL_RESERVATION,
  get_RESERVATION_ID    RETURNING VALUE(return) TYPE REF TO ZCL_RESERVATION,
  set_STATUS            IMPORTING iv_STATUS TYPE STRING128,
  get_STATUS            RETURNING VALUE(return) TYPE STRING128.


protected section.
private section.

  data NUMBER_OF_ROOMS type INTEGER .
  data ROOM_TYPE_ID type REF TO zcl_room_type.
  data RESERVATION_ID type REF TO zcl_reservation .
  data STATUS type STRING128 .
ENDCLASS.



CLASS ZCL_RESERVED_ROOM IMPLEMENTATION.


  method CONSTRUCTOR.
    me->NUMBER_OF_ROOMS = iv_number_of_rooms.
    me->ROOM_TYPE_ID = iv_room_type_id.
    me->RESERVATION_ID = iv_RESERVATION_ID.
    me->status = iv_status.
  endmethod.


  METHOD get_NUMBER_OF_ROOMS.
      return = me->NUMBER_OF_ROOMS.
  ENDMETHOD.


  METHOD get_RESERVATION_ID.
      return = me->RESERVATION_ID.
  ENDMETHOD.


  METHOD get_ROOM_TYPE_ID.
      return = me->ROOM_TYPE_ID.
  ENDMETHOD.


  METHOD get_STATUS.
      return = me->STATUS.
  ENDMETHOD.


    METHOD set_NUMBER_OF_ROOMS.
      me->NUMBER_OF_ROOMS = iv_NUMBER_OF_ROOMS.
  ENDMETHOD.


    METHOD set_RESERVATION_ID.
      me->RESERVATION_ID = iv_RESERVATION_ID.
  ENDMETHOD.


    METHOD set_ROOM_TYPE_ID.
      me->ROOM_TYPE_ID = iv_ROOM_TYPE_ID.
  ENDMETHOD.


    METHOD set_STATUS.
      me->STATUS = iv_STATUS.
  ENDMETHOD.
ENDCLASS.
