# The name of this view in Looker is "Mobility Report"
view: mobility_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `daveward-ps-dev.daveward_demodataset_dev.mobility_report`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Census Fips Code" in Explore.

  dimension: census_fips_code {
    hidden: yes
    type: string
    description: "Unique identifier for each US county as defined by the US Census Bureau. Maps to county_fips_code in other tables"
    sql: ${TABLE}.census_fips_code ;;
  }

  dimension: country_region {
    type: string
    description: "The country/region in which changes are measured relative to the baseline"
    sql: ${TABLE}.country_region ;;
  }

  dimension: country_region_code {
    hidden: yes
    type: string
    description: "2 letter alpha code for the country/region in which changes are measured relative to the baseline. These values correspond with the ISO 3166-1 alpha-2 codes"
    sql: ${TABLE}.country_region_code ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    description: "Changes for a given date as compared to baseline. Baseline is the median value, for the corresponding day of the week, during the 5-week period Jan 3–Feb 6, 2020."
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: grocery_and_pharmacy_percent_change_from_baseline {
    hidden: yes
    type: number
    description: "Mobility trends for places like grocery markets, food warehouses, farmers markets, specialty food shops, drug stores, and pharmacies."
    sql: ${TABLE}.grocery_and_pharmacy_percent_change_from_baseline ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: iso_3166_2_code {
    type: string
    description: "Unique identifier for the geographic region as defined by ISO Standard 3166-2."
    sql: ${TABLE}.iso_3166_2_code ;;
  }

  dimension: metro_area {
    type: string
    description: "A specific metro area to measure mobility within a given city/metro area. This varies by country/region to ensure privacy and public health value in consultation with local public health authorities"
    sql: ${TABLE}.metro_area ;;
  }

  dimension: parks_percent_change_from_baseline {
    hidden: yes
    type: number
    description: "Mobility trends for places like local parks, national parks, public beaches, marinas, dog parks, plazas, and public gardens."
    sql: ${TABLE}.parks_percent_change_from_baseline ;;
  }

  dimension: place_id {
    hidden: yes
    type: string
    description: "A textual identifier that uniquely identifies a place in the Google Places database and on Google Maps (details). For example, ChIJd_Y0eVIvkIARuQyDN0F1LBA. For details, see the following link: https://developers.google.com/places/web-service/place-id"
    sql: ${TABLE}.place_id ;;
  }

  dimension: residential_percent_change_from_baseline {
    hidden: yes
    type: number
    description: "Mobility trends for places of residence."
    sql: ${TABLE}.residential_percent_change_from_baseline ;;
  }

  dimension: retail_and_recreation_percent_change_from_baseline {
    hidden: yes
    type: number
    description: "Mobility trends for places like restaurants, cafes, shopping centers, theme parks, museums, libraries, and movie theaters."
    sql: ${TABLE}.retail_and_recreation_percent_change_from_baseline ;;
  }

  dimension: sub_region_1 {
    type: string
    description: "First geographic sub-region in which the data is aggregated. This varies by country/region to ensure privacy and public health value in consultation with local public health authorities"
    sql: ${TABLE}.sub_region_1 ;;
  }

  dimension: sub_region_2 {
    hidden: yes
    type: string
    description: "Second geographic sub-region in which the data is aggregated. This varies by country/region to ensure privacy and public health value in consultation with local public health authorities"
    sql: ${TABLE}.sub_region_2 ;;
  }

  dimension: transit_stations_percent_change_from_baseline {
    hidden: yes
    type: number
    description: "Mobility trends for places like public transport hubs such as subway, bus, and train stations."
    sql: ${TABLE}.transit_stations_percent_change_from_baseline ;;
  }

  dimension: workplaces_percent_change_from_baseline {
    hidden: yes
    type: number
    description: "Mobility trends for places of work."
    sql: ${TABLE}.workplaces_percent_change_from_baseline ;;
  }

  measure: total_grocery_and_pharmacy_percent_change_from_baseline {
    type: sum
    sql: ${grocery_and_pharmacy_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: average_grocery_and_pharmacy_percent_change_from_baseline {
    type: average
    sql: ${grocery_and_pharmacy_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: total_parks_percent_change_from_baseline {
    type: sum
    sql: ${parks_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: average_parks_percent_change_from_baseline {
    type: average
    sql: ${parks_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: total_residential_percent_change_from_baseline {
    type: sum
    sql: ${residential_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: average_residential_percent_change_from_baseline {
    type: average
    sql: ${residential_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: total_residential_and_recreation_percent_change_from_baseline {
    type: sum
    sql: ${retail_and_recreation_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: average_residential_and_recreation_percent_change_from_baseline {
    type: average
    sql: ${retail_and_recreation_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: total_transit_station_percent_changes {
    type: sum
    sql: ${transit_stations_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: average_transit_station_percent_changes {
    type: average
    sql: ${transit_stations_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: total_workplaces_percent_change {
    type: sum
    sql: ${workplaces_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: average_workplaces_percent_change {
    type: average
    sql: ${workplaces_percent_change_from_baseline} ;;
    value_format_name: percent_2
  }

  measure: row_count {
    type: count
  }

}
