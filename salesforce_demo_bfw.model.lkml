connection: "salesforce_demo"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: salesforce_demo_bfw_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: salesforce_demo_bfw_default_datagroup


explore: dynamic_calendar {
  from: dynamic_calendar
  always_filter: {
    filters: { field: dynamic_calendar.date_granularity value: "Second" }
#     filters: { field: dynamic_calendar.date_filter value: "14 days" }
  }
  join: dynamic_history {
    type: inner
    relationship: many_to_one
    sql_on: ${dynamic_calendar.calendar_string} BETWEEN ${dynamic_history.window_start} AND ${dynamic_history.window_end} ;;
  }
  join: opportunity {
    fields: [id, closed_date, owner_id, type, opportunity.stage_name, total_acv]
    type: inner
    relationship: many_to_one
    sql_on: ${dynamic_history.opportunity_id}  = ${opportunity.id};;
  }
}


# explore: account {}
#
# explore: account_contact_role {
#   join: contact {
#     type: left_outer
#     sql_on: ${account_contact_role.contact_id} = ${contact.id} ;;
#     relationship: many_to_one
#   }
#
#   join: account {
#     type: left_outer
#     sql_on: ${account_contact_role.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: campaign {}
#
# explore: campaign_member {
#   join: campaign {
#     type: left_outer
#     sql_on: ${campaign_member.campaign_id} = ${campaign.id} ;;
#     relationship: many_to_one
#   }
#
#   join: lead {
#     type: left_outer
#     sql_on: ${campaign_member.lead_id} = ${lead.id} ;;
#     relationship: many_to_one
#   }
#
#   join: contact {
#     type: left_outer
#     sql_on: ${campaign_member.contact_id} = ${contact.id} ;;
#     relationship: many_to_one
#   }
#
#   join: account {
#     type: left_outer
#     sql_on: ${lead.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: contact {
#   join: account {
#     type: left_outer
#     sql_on: ${contact.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: etl_jobs {}
#
# explore: events {}
#
# explore: instance_license_map {}
#
# explore: instance_user {}
#
# explore: lead {
#   join: account {
#     type: left_outer
#     sql_on: ${lead.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: license {}
#
# explore: opportunity {
#   join: account {
#     type: left_outer
#     sql_on: ${opportunity.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
#
#   join: campaign {
#     type: left_outer
#     sql_on: ${opportunity.campaign_id} = ${campaign.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: opportunity_contact_role {
#   join: contact {
#     type: left_outer
#     sql_on: ${opportunity_contact_role.contact_id} = ${contact.id} ;;
#     relationship: many_to_one
#   }
#
#   join: opportunity {
#     type: left_outer
#     sql_on: ${opportunity_contact_role.opportunity_id} = ${opportunity.renewal_opportunity_id} ;;
#     relationship: many_to_one
#   }
#
#   join: account {
#     type: left_outer
#     sql_on: ${contact.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
#
#   join: campaign {
#     type: left_outer
#     sql_on: ${opportunity.campaign_id} = ${campaign.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: opportunity_history {
#   join: opportunity {
#     type: left_outer
#     sql_on: ${opportunity_history.opportunity_id} = ${opportunity.renewal_opportunity_id} ;;
#     relationship: many_to_one
#   }
#
#   join: account {
#     type: left_outer
#     sql_on: ${opportunity.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
#
#   join: campaign {
#     type: left_outer
#     sql_on: ${opportunity.campaign_id} = ${campaign.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: person {}
#
# explore: quota {
#   join: person {
#     type: left_outer
#     sql_on: ${quota.person_id} = ${person.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: task {
#   join: account {
#     type: left_outer
#     sql_on: ${task.account_id} = ${account.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: zendesk_ticket {}
