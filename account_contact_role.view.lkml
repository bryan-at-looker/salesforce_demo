view: account_contact_role {
  sql_table_name: public.account_contact_role ;;

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

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  measure: count {
    type: count
    drill_fields: [id, contact.id, contact.name, account.id, account.name]
  }
}
