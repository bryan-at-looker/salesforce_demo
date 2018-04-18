view: quota {
  sql_table_name: public.quota ;;

  dimension: person_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.person_id ;;
  }

  dimension: quota {
    type: number
    sql: ${TABLE}.quota ;;
  }

  dimension_group: quota_quarter {
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
    sql: ${TABLE}.quota_quarter ;;
  }

  measure: count {
    type: count
    drill_fields: [person.id, person.first_name, person.last_name]
  }
}
