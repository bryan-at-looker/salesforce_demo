view: license {
  sql_table_name: public.license ;;

  dimension: license_slug {
    type: string
    sql: ${TABLE}.license_slug ;;
  }

  dimension: salesforce_account_id {
    type: string
    sql: ${TABLE}.salesforce_account_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
