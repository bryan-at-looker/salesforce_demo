view: dynamic_calendar {
  derived_table: {
    sql: WITH numbers as (
      SELECT ROW_NUMBER() OVER () as number
      FROM opportunity_history
      LIMIT 5000
      )

      SELECT DISTINCT
        DATE_TRUNC('{% parameter dynamic_calendar.date_granularity %}', dateadd({% parameter dynamic_calendar.date_granularity %}, numbers.number -1 , {% date_start dynamic_calendar.date_filter %}))
        as series_date
      FROM numbers
        WHERE numbers.number <= DATEDIFF({% parameter dynamic_calendar.date_granularity %}, COALESCE( {% date_start dynamic_calendar.date_filter %},CAST('2000-01-01' as TIMESTAMP )), COALESCE({% date_end dynamic_calendar.date_filter %},current_date))
       ;;
  }

  filter: date_filter {
    type: date
    convert_tz: no
  }

  parameter: date_granularity {
    type: unquoted
    allowed_value: { label: "Day" value: "day" }
    allowed_value: { label: "Week" value: "week" }
    allowed_value: { label: "Month" value: "month" }
    allowed_value: { label: "Quarter" value: "quarter" }
  }

  parameter: changing_value {
    type: unquoted
    allowed_value: { label: "Probability" value: "probability" }
    allowed_value: { label: "Stage" value: "stage_name" }
    allowed_value: { label: "Amount" value: "expected_revenue" }
    allowed_value: { label: "Close Date" value: "close_date" }
  }

  dimension: calendar_string {
    type: string
    sql: ${TABLE}.series_date ;;
#     convert_tz: no
  }

  dimension: calendar_date {
    type: date
    sql: ${calendar_string} ;;
    convert_tz: no
  }

  dimension: calendar_month {
    type: date_month
    sql: ${calendar_string} ;;
    convert_tz: no
  }
}
