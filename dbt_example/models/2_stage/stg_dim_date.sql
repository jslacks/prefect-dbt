{{ config(
    tags=["dimension","dim_date"]
) }}

/* 
SPIFF Finalize occurs 6th business day every other month (Jan,Mar,May,July,Sep,Nov)
Below case statement defines what spiff_period_key to use 
and updates spiff_currentperiod to 'Current_Period' when applicable
*/
{% set get_spiff_period_key %} 
    select top 1
        case 
        when current_date between '2020-11-10' and '2021-01-11' then '342' -- Nov/Dec 2020
        when current_date between '2021-01-12' and '2021-03-08' then '343' -- Jan/Feb 2021
        when current_date between '2021-03-09' and '2021-05-10' then '344' -- Mar/Apr 2021
        when current_date between '2021-03-09' and '2021-05-10' then '345' -- May/Jun 2021
        when current_date between '2021-03-09' and '2021-05-10' then '346' -- Jul/Aug 2021
        when current_date between '2021-03-09' and '2021-05-10' then '347' -- Sep/Oct 2021
        when current_date between '2021-03-09' and '2021-05-10' then '348' -- Nov/Dec 2021
        end as get_spiff_period_key
    from raw.source_internal.date
    where get_spiff_period_key is not null
    order by date asc
{% endset %}

{% set results = run_query(get_spiff_period_key) %}

{% if execute %}
    {# Return the first column #}
    {% set results_list = results.columns[0].values() %}
{% else %}
    {% set results_list = [] %}
{% endif %}

{% set is_current_period = results_list[0] %}


with source_data as (

     SELECT 

    -- static from date table
        date, --2020-07-31
        datename, --Friday, July 31 2020
        year,--2020-01-01
        yearname,--2020
        month,--2020-07-01
        monthname,--July 2020
        week,--2020-07-26
        weekname,--Week 31, 2020
        dayofyear,--213
        dayofyearname,--Day 213
        dayofmonth,--31
        dayofmonthname,--Day 31
        dayofweek,--6
        dayofweekname,--Day 6
        weekofyear,--31
        weekofyearname,--Week 31
        monthofyear,--7
        monthofyearname,--Month 7 
        businessdaycount,--0 or 1				
        dealerbusinessdaycount,--0 or 1				
        businessdayofmonth,-- [1-31]				
        businessdaysinmonth,-- [1-31]					
        businessdaysremaining,-- [1-31]					
        spiff_period,--SPIFF_Start or SPIFF_End
        spiff_periodrange,--Jan 1982 - Feb 1982
        monthofyeartext,-- January
        spiff_period_key,--[1-522]	

    -- calculated
        case when date = current_date() then 1 else 0 end as currentday,
        case when date = current_date()-1 then 1 else 0 end as yesterday,
        case when weekname = ('Week ' || week(current_date()) || ', ' || yearofweek(current_date())) then 1 else 0 end as currentweek,
        case when weekname = ('Week ' || week(current_date()-7) || ', ' || yearofweek(current_date())) then 1 else 0 end as previousweek,
        case when date >= current_date()-6 and date <= current_date() then 1 else 0 end as last7days,
        case when date >= current_date()-31 and date < current_date() then 1 else 0 end as previous30days,
        case when monthofyear = month(current_date()) and yearname = year(current_date()) and date < current_date() then 1 else 0 end as monthtodate,
        case when monthofyear = month(current_date()) and yearname = year(current_date()) then 1 else 0 end as currentmonth,
        case 
        when day(current_date()) = 1 and monthofyear = month( ADD_MONTHS(current_date(), -1) ) and yearname = year( ADD_MONTHS(current_date(), -1)) then 1 --TagPreviousMonth on First Day of Current Month
        when day(current_date()) > 1 then ( case when monthofyear = month(current_date()) and yearname = year(current_date()) then 1 else 0 end ) --TagCurrentMonth
        else 0 end as currentmonthlag,
        case when monthofyear = month( ADD_MONTHS(current_date(), -1) ) and yearname = year( ADD_MONTHS(current_date(), -1) ) then 1 else 0 end as previousmonth,
        previousmonthmonthtodate,
        monthovermonth,
        last3months,
        case when yearname = date_part(year,current_date()) and date < current_date() then 1 else 0 end as yeartodate,
        yeartodatemonthovermonth,
        monthtodateyearoveryear,
        yeartodateyearoveryear,
        last6months,
        case when yearname = date_part(year,current_date()) then 1 else 0 end as currentyear,
        case when yearname = (date_part(year,current_date()))-1 then 1 else 0 end as previousyear,
        last12months,
        case when month(date) <= month(dateadd(mm,-1,current_date)) and date <= last_day(dateadd(mm,-1,current_date)) then 1 else 0 end as yeartodateyearoveryearpm,
        yeartodatepm,
        case when spiff_period_key = {{ is_current_period }} then 'Current_Period' else spiff_currentperiod end as spiff_currentperiod

        
    FROM {{ source('internal','date') }}
    -- This refers to the table created from data/date.csv
    from {{ ref('date') }}
)

select *
from source_data`