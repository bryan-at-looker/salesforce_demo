view: opportunity {
  sql_table_name: public.opportunity ;;

  dimension: renewal_opportunity_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.renewal_opportunity_id ;;
  }

  dimension: account_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: acv {
    type: number
    sql: ${TABLE}.acv ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: churn_status_c {
    type: string
    sql: ${TABLE}.churn_status_c ;;
  }

  dimension_group: closed {
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
    sql: ${TABLE}.closed_date ;;
  }

  dimension: contract_length_c {
    type: number
    sql: ${TABLE}.contract_length_c ;;
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

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: is_cancelled_c {
    type: yesno
    sql: ${TABLE}.is_cancelled_c ;;
  }

  dimension: is_closed {
    type: yesno
    sql: ${TABLE}.is_closed ;;
  }

  dimension: is_won {
    type: yesno
    sql: ${TABLE}.is_won ;;
  }

  dimension: lead_source {
    type: string
    sql: ${TABLE}.lead_source ;;
  }

  dimension: mrr {
    type: number
    sql: ${TABLE}.mrr ;;
  }

  dimension: nrr {
    type: number
    sql: ${TABLE}.nrr ;;
  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.owner_id ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
  }

  dimension: renewal_number_c {
    type: number
    sql: ${TABLE}.renewal_number_c ;;
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stage_name ;;
  }

  dimension: total_contract_value_c {
    type: number
    sql: ${TABLE}.total_contract_value_c ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      renewal_opportunity_id,
      stage_name,
      account.id,
      account.name,
      campaign.id,
      opportunity_contact_role.count,
      opportunity_history.count
    ]
  }
}
