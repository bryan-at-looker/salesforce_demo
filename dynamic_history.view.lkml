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
        , DATE_TRUNC('{% parameter dynamic_calendar.date_granularity %}',created_at) as window_start
        , COALESCE(DATE_TRUNC('{% parameter dynamic_calendar.date_granularity %}',lead(created_at) OVER (PARTITION BY opportunity_id ORDER BY created_at)), {% date_end dynamic_calendar.date_filter %}) as window_end
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

  dimension: last_selected_field {
    type: string
    sql: ${TABLE}.last_selected_field ;;
  }

  dimension: window_start {
    type: date
    sql: ${TABLE}.window_start ;;
  }

  dimension: window_end {
    type: date
    sql: ${TABLE}.window_end ;;
  }

  measure: days_in_stage {
    type: max
    sql: DATEDIFF(day, ${window_start}, ${window_end}) ;;
  }

  measure: count {
    type: count
  }

  set: detail {
    fields: [opportunity_id, selected_field, last_selected_field, window_start, window_end]
  }
}
