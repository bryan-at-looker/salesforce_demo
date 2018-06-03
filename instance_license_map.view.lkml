view: instance_license_map {
  sql_table_name: public.instance_license_map ;;

  dimension: instance_slug {
    type: string
    sql: ${TABLE}.instance_slug ;;
  }

  dimension: license_slug {
    type: string
    sql: ${TABLE}.license_slug ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
