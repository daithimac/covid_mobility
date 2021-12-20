connection: "bigquery_personal_instance"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore: mobility_report {}

explore: irish_covid_mobility {
  from: mobility_report
  sql_always_where: ${country_region_code} = 'IE' ;;
}

explore: mobility {
  from: mobility_data
  group_label: "Community Mobility Reports"
  description: "This Explore uses data from Google's COVID-19 Community Mobility Reports. Full information about these are available at: https://www.google.com/covid19/mobility/"
  sql_always_where: ${geo_level_output} = ${geo_level};;
  # always_filter: {
  #   filters: [geography_level: "country"]
  # }

  join: max_date_mobility {
    sql_on: ${mobility.country_region_code} = ${max_date_mobility.country_region_code}
            AND IFNULL(${mobility.sub_region_1}, '') = ${max_date_mobility.province_state}
            AND IFNULL(${mobility.sub_region_2}, '') = ${max_date_mobility.county};;
    relationship: many_to_one
  }
}



persist_with: mobility_data

### PDT Timeframes

datagroup: mobility_data {
  max_cache_age: "12 hours"
  sql_trigger:
    SELECT min(max_date) as max_date
    FROM
    (
      SELECT max(cast(date as date)) as max_date FROM `bigquery-public-data.covid19_google_mobility.mobility_report`
    ) a
  ;;
}
