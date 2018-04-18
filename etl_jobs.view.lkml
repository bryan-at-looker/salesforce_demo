view: etl_jobs {
  sql_table_name: public.etl_jobs ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: job_finished {
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
    sql: ${TABLE}.job_finished_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
