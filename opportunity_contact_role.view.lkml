view: opportunity_contact_role {
  sql_table_name: public.opportunity_contact_role ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: contact_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.contact_id ;;
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

  dimension: opportunity_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  measure: count {
    type: count
    drill_fields: [id, contact.id, contact.name, opportunity.stage_name, opportunity.renewal_opportunity_id]
  }
}
