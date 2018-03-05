view: dynamic_history {
  derived_table: {
    sql: WITH history_opportunity_stage as (
        SELECT DISTINCT
          opportunity_id as opportunity_id
          , LAST_VALUE({% parameter dynamic_calendar.changing_value %}) OVER (PARTITION BY opportunity_id, DATE_TRUNC('{% parameter dynamic_calendar.date_granularity %}', created_at) ORDER BY created_at rows between unbounded preceding and unbounded following) as selected_field
          , LAST_VALUE(created_at) OVER (PARTITION BY opportunity_id, DATE_TRUNC('{% parameter dynamic_calendar.date_granularity %}', created_at) ORDER BY created_at rows between unbounded preceding and unbounded following) as created_at
        FROM opportunity_history
        WHERE {% parameter dynamic_calendar.changing_value %} is not null
        AND {% condition dynamic_history.opportunity_id %} opportunity_id {% endcondition %}
        -- limit 10000
      ),
      history_opportunity_next_value as (
       SELECT *, LAG(selected_field) OVER (PARTITION BY opportunity_id ORDER BY created_at) as last_selected_field
       FROM history_opportunity_stage
      )
      SELECT DISTINCT opportunity_id, selected_field
        , created_at as window_start
        , lead(created_at) OVER (PARTITION BY opportunity_id ORDER BY created_at) as window_end
        , lead(selected_field) OVER (PARTITION BY opportunity_id ORDER BY created_at) as next_selected_field
        FROM history_opportunity_next_value
        WHERE selected_field != last_selected_field
       ;;
  }

  dimension: hidden_key {
    type: string
    sql: ${opportunity_id} || '-' || ${window_start} ;;
    primary_key: yes
    hidden: yes
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: selected_field {
    label_from_parameter: dynamic_calendar.changing_value
    type: string
    sql: ${TABLE}.selected_field ;;
  }

  dimension: stage {
    type: string
    sql: CASE
        WHEN ${selected_field} ~ 'Active Lead|Validate'         THEN '1 Validate'
        WHEN ${selected_field} ~ 'Qualif'                       THEN '2 Qualify'
        WHEN ${selected_field} ~ 'Develop Positive|positive'    THEN '4 Develop Positive'
        WHEN ${selected_field} ~ 'Negotiat|Proposal'            THEN '5 Negotiate'
        WHEN ${selected_field} ~ 'Trial|Develop'                THEN '3 Develop'
        WHEN ${selected_field} ~ 'Sales Submitted|Commit'       THEN '6 Sales Submitted'
        WHEN ${selected_field} ~ 'Closed Lost'                  THEN 'Closed Lost'
        WHEN ${selected_field} ~ 'Closed Won'                   THEN 'Closed Won'
        ELSE 'Unknown' END  ;;
  }

  dimension: stage_orderby {
    type: string
    hidden: yes
    sql: LEFT(${stage},1) ;;
  }

  dimension: last_selected_field {
    type: string
    sql: ${TABLE}.last_selected_field ;;
  }

  dimension: next_selected_field {
    type: string
    sql: ${TABLE}.next_selected_field ;;
  }

  dimension: is_last_value {
    type: yesno
    sql: ${TABLE}.window_end IS NULL ;;
  }
  dimension: window_start {
    type: date
    sql: ${TABLE}.window_start ;;
    convert_tz: no
  }

  dimension: window_end {
    type: date
    sql: COALESCE(${TABLE}.window_end, {% date_end dynamic_calendar.date_filter %}) ;;
    convert_tz: no
  }

  dimension: days_in_stage {
    type: number
    sql: DATEDIFF(day, ${window_start}, ${window_end}) ;;
  }

  measure: average_days_in_stage {
    type: average
    sql: ${days_in_stage} ;;
    value_format_name: decimal_1
  }

  measure: count {
    type: count
  }

  set: detail {
    fields: [opportunity_id, selected_field, last_selected_field, window_start, window_end]
  }
}
