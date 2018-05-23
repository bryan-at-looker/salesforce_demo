view: contact {
  sql_table_name: public.contact ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: contact_type {
    type: string
    sql: ${TABLE}.contact_type_c ;;
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

  dimension: current_customer {
    type: yesno
    sql: ${TABLE}.current_customer_c ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: department_picklist {
    type: string
    sql: ${TABLE}.department_picklist_c ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: grouping {
    type: string
    sql: ${TABLE}.grouping_c ;;
  }

  dimension: inbound_form_fillout {
    type: string
    sql: ${TABLE}.inbound_form_fillout_c ;;
  }

  dimension: intro_meeting {
    type: yesno
    sql: ${TABLE}.intro_meeting_c ;;
  }

  dimension: job_function {
    type: string
    sql: ${TABLE}.job_function_c ;;
  }

  dimension: lead_source {
    type: string
    sql: ${TABLE}.lead_source ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: primary_contact {
    type: yesno
    sql: ${TABLE}.primary_contact_c ;;
  }

  dimension: qual_form_fillout {
    type: yesno
    sql: ${TABLE}.qual_form_fillout_c ;;
  }

  dimension: territory {
    type: string
    sql: ${TABLE}.territory_c ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: zendesk_organization {
    type: string
    sql: ${TABLE}.zendesk_organization ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: intro_meeting_count {
    type: count
    drill_fields: [detail*]
    filters: { field: intro_meeting value: "Yes" }
  }

  measure: lead_conversion {}

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      account.id,
      account.name,
      account_contact_role.count,
      campaign_member.count,
      opportunity_contact_role.count
    ]
  }
}
