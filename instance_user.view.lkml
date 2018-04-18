view: instance_user {
  sql_table_name: public.instance_user ;;

  dimension: instance_slug {
    type: string
    sql: ${TABLE}.instance_slug ;;
  }

  dimension: is_admin {
    type: yesno
    sql: ${TABLE}.is_admin ;;
  }

  dimension: is_disabled {
    type: yesno
    sql: ${TABLE}.is_disabled ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
