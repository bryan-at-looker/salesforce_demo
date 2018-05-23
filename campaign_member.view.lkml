view: campaign_member {
  sql_table_name: public.campaign_member ;;

  filter: previous_period_filter {
    view_label: "Period Analysis"
    type: date
    description: "Use this filter for period analysis"
    sql: {% if previous_period._in_query %} ${previous_period} IS NOT NULL {% endif %}
         {% if lead.previous_period._in_query %} ${lead.previous_period} IS NOT NULL {% endif %}
    ;;
  }

  dimension: previous_period {
    view_label: "Period Analysis"
    label: "Previous Period  (Campaign Member Date)"
    type: string
    description: "The reporting period as selected by the Previous Period Filter"
    sql:
        CASE
          WHEN {% date_start previous_period_filter %} is not null AND {% date_end previous_period_filter %} is not null /* date ranges or in the past x days */
            THEN
              CASE
                WHEN ${created_raw} >=  {% date_start previous_period_filter %}
                  AND ${created_raw} <= {% date_end previous_period_filter %}
                  THEN 'This Period'
                WHEN ${created_raw} >= DATEADD(day,-1*DATEDIFF(day,{% date_start previous_period_filter %}, {% date_end previous_period_filter %} ) + 1, DATEADD(day,-1,{% date_start previous_period_filter %} ) )
                  AND ${created_raw} < DATEADD(day,-1,{% date_start previous_period_filter %} ) + 1
                  THEN 'Previous Period'
              END
          WHEN {% date_start previous_period_filter %} is null AND {% date_end previous_period_filter %} is null /* has any value or is not null */
            THEN CASE WHEN ${created_raw} is not null THEN 'Has Value' ELSE 'Is Null' END
          WHEN {% date_start previous_period_filter %} is null AND {% date_end previous_period_filter %} is not null /* on or before */
            THEN
              CASE
                WHEN  ${created_raw} <=  {% date_end previous_period_filter %} THEN 'In Period'
                WHEN  ${created_raw} >   {% date_end previous_period_filter %} THEN 'Not In Period'
              END
         WHEN {% date_start previous_period_filter %} is not null AND {% date_end previous_period_filter %} is null /* on or after */
           THEN
             CASE
               WHEN  ${created_raw} >= {% date_start previous_period_filter %} THEN 'In Period'
               WHEN  ${created_raw} < {% date_start previous_period_filter %} THEN 'Not In Period'
            END
        END ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: lead_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.lead_id ;;
  }

  dimension: lead_or_contact_id {
    type: string
    # hidden: yes
    sql: COALESCE(${lead_id},${contact_id}) ;;
  }

  measure: count {
    type: count
#     sql: ${id} ;;
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      campaign.id,
      lead.id,
      lead.name,
      contact.id,
      contact.name
    ]
  }
}
