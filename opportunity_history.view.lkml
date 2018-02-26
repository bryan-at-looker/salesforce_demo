view: opportunity_history {
  sql_table_name: public.opportunity_history ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: SPLIT_PART(${TABLE}.id,'-',1) ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension_group: close {
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
    sql: ${TABLE}.close_date ;;
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.expected_revenue ;;
  }

  dimension: opportunity_id {
    type: string
    # hidden: yes
    sql: SPLIT_PART(${TABLE}.opportunity_id,'-',1) ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stage_name ;;
  }

  dimension: is_negotiate {
    type: yesno
    sql: ${stage_name} IN ('Negotiate', 'I' ;;
  }

  measure: count {
    type: count
    drill_fields: [id, stage_name, opportunity.stage_name, opportunity.renewal_opportunity_id]
  }

  ## hidden measures
  measure: max_negotiate {}


}
