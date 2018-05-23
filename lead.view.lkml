view: lead {
  sql_table_name: public.lead ;;

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

  dimension: previous_period {
    view_label: "Period Analysis"
    label: "Previous Period  (Lead Created Date)"
    type: string
    description: "The reporting period as selected by the Previous Period Filter"
    sql:
        CASE
          WHEN {% date_start campaign_member.previous_period_filter %} is not null AND {% date_end campaign_member.previous_period_filter %} is not null /* date ranges or in the past x days */
            THEN
              CASE
                WHEN ${created_raw} >=  {% date_start campaign_member.previous_period_filter %}
                  AND ${created_raw} <= {% date_end campaign_member.previous_period_filter %}
                  THEN 'This Period'
                WHEN ${created_raw} >= DATEADD(day,-1*DATEDIFF(day,{% date_start campaign_member.previous_period_filter %}, {% date_end campaign_member.previous_period_filter %} ) + 1, DATEADD(day,-1,{% date_start campaign_member.previous_period_filter %} ) )
                  AND ${created_raw} < DATEADD(day,-1,{% date_start campaign_member.previous_period_filter %} ) + 1
                  THEN 'Previous Period'
              END
          WHEN {% date_start campaign_member.previous_period_filter %} is null AND {% date_end campaign_member.previous_period_filter %} is null /* has any value or is not null */
            THEN CASE WHEN ${created_raw} is not null THEN 'Has Value' ELSE 'Is Null' END
          WHEN {% date_start campaign_member.previous_period_filter %} is null AND {% date_end campaign_member.previous_period_filter %} is not null /* on or before */
            THEN
              CASE
                WHEN  ${created_raw} <=  {% date_end campaign_member.previous_period_filter %} THEN 'In Period'
                WHEN  ${created_raw} >   {% date_end campaign_member.previous_period_filter %} THEN 'Not In Period'
              END
         WHEN {% date_start campaign_member.previous_period_filter %} is not null AND {% date_end campaign_member.previous_period_filter %} is null /* on or after */
           THEN
             CASE
               WHEN  ${created_raw} >= {% date_start campaign_member.previous_period_filter %} THEN 'In Period'
               WHEN  ${created_raw} < {% date_start campaign_member.previous_period_filter %} THEN 'Not In Period'
            END
        END ;;
  }

  dimension: analyst_name {
    type: string
    sql: ${TABLE}.analyst_name_c ;;
  }

  dimension: annual_revenue {
    type: number
    sql: ${TABLE}.annual_revenue ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension: converted_contact_id {
    type: string
    sql: ${TABLE}.converted_contact_id ;;
  }

  dimension: converted_opportunity_id {
    type: string
    sql: ${TABLE}.converted_opportunity_id ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: campaign_created_lead {
    type: yesno
    sql: ${campaign_member.created_date} = ${created_date} ;;
  }

  dimension: current_customer {
    type: yesno
    sql: ${TABLE}.current_customer_c ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department_c ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: grouping {
    type: string
    sql: ${TABLE}.grouping_c ;;
  }

  dimension: intro_meeting {
    type: yesno
    sql: ${TABLE}.intro_meeting_c ;;
  }

  dimension: is_converted {
    type: yesno
    sql: ${TABLE}.is_converted ;;
  }

  dimension: job_function {
    type: string
    sql: ${TABLE}.job_function_c ;;
  }

  dimension: lead_processing_status {
    type: string
    sql: ${TABLE}.lead_processing_status_c ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: number_of_employees {
    type: number
    sql: ${TABLE}.number_of_employees ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: marketing_qualified_lead {
    type: yesno
    sql: ${status} IN ('Working', 'Nurture', 'SDR Rejected', 'Sales Qualified', 'Sales Unqualified', 'Validate', 'Holdout', 'Marketing Qualified', 'SDR Accepted', 'Prospecting', 'Processing', 'No Show', 'Attended Session', 'Sales Accepted', 'Sales Rejected', 'Responded') ;;
  }

  dimension: territory {
    type: string
    sql: ${TABLE}.territory_c ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: year_founded {
    type: string
    sql: ${TABLE}.year_founded_c ;;
  }

  dimension: zendesk_organization {
    type: string
    sql: ${TABLE}.zendesk_organization ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, account.id, account.name, campaign_member.count]
  }

  measure: marketing_qualified_count {
    type: count
    drill_fields: [id, name, city, campaign.group, opportunity.mrr, account.name]
    filters: { field: marketing_qualified_lead value: "Yes" }
  }

  measure: mql_rate {
    label: "MQL Rate"
    type: number
    sql: 1.0*${marketing_qualified_count} / NULLIF(${count},0) ;;
    value_format_name: percent_1
  }

  measure: first_touch_count {
    type: count
    drill_fields: [id, name, account.id, account.name, campaign_member.count]
    filters: { field: campaign_created_lead value: "Yes" }
  }
}
