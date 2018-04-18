view: zendesk_ticket {
  sql_table_name: public.zendesk_ticket ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.created_by_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_date ;;
  }

  dimension: is_deleted {
    type: yesno
    sql: ${TABLE}.is_deleted ;;
  }

  dimension_group: last_activity {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_activity_date ;;
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.last_modified_by_id ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: last_referenced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_referenced_date ;;
  }

  dimension_group: last_viewed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_viewed_date ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.owner_id ;;
  }

  dimension: request_type___c {
    type: string
    sql: ${TABLE}.request_type___c ;;
  }

  dimension_group: system_modstamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.system_modstamp ;;
  }

  dimension: zendesk___agent__wait__time__business___c {
    type: number
    sql: ${TABLE}.zendesk___agent__wait__time__business___c ;;
  }

  dimension: zendesk___agent__wait__time__calendar___c {
    type: number
    sql: ${TABLE}.zendesk___agent__wait__time__calendar___c ;;
  }

  dimension_group: zendesk___date__time__created___c {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.zendesk___date__time__created___c ;;
  }

  dimension_group: zendesk___date__time__initially__assigned___c {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.zendesk___date__time__initially__assigned___c ;;
  }

  dimension_group: zendesk___date__time__solved___c {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.zendesk___date__time__solved___c ;;
  }

  dimension_group: zendesk___date__time__updated___c {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.zendesk___date__time__updated___c ;;
  }

  dimension: zendesk___hold__time__business___c {
    type: number
    sql: ${TABLE}.zendesk___hold__time__business___c ;;
  }

  dimension: zendesk___hold__time__calendar___c {
    type: number
    sql: ${TABLE}.zendesk___hold__time__calendar___c ;;
  }

  dimension: zendesk___opportunity___c {
    type: string
    sql: ${TABLE}.zendesk___opportunity___c ;;
  }

  dimension: zendesk___organization___c {
    type: string
    sql: ${TABLE}.zendesk___organization___c ;;
  }

  dimension: zendesk___priority___c {
    type: string
    sql: ${TABLE}.zendesk___priority___c ;;
  }

  dimension: zendesk___reply__time__business___c {
    type: number
    sql: ${TABLE}.zendesk___reply__time__business___c ;;
  }

  dimension: zendesk___reply__time__calendar___c {
    type: number
    sql: ${TABLE}.zendesk___reply__time__calendar___c ;;
  }

  dimension: zendesk___requester___c {
    type: string
    sql: ${TABLE}.zendesk___requester___c ;;
  }

  dimension: zendesk___requester__wait__time__business___c {
    type: number
    sql: ${TABLE}.zendesk___requester__wait__time__business___c ;;
  }

  dimension: zendesk___requester__wait__time__calendar___c {
    type: number
    sql: ${TABLE}.zendesk___requester__wait__time__calendar___c ;;
  }

  dimension: zendesk___resolution__time__business___c {
    type: number
    sql: ${TABLE}.zendesk___resolution__time__business___c ;;
  }

  dimension: zendesk___resolution__time__calendar___c {
    type: number
    sql: ${TABLE}.zendesk___resolution__time__calendar___c ;;
  }

  dimension: zendesk___ticket__id___c {
    type: string
    sql: ${TABLE}.zendesk___ticket__id___c ;;
  }

  dimension: zendesk___type___c {
    type: string
    sql: ${TABLE}.zendesk___type___c ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
