# cmv-fund-explorer-stack

## Planning

### Data cleaning and transforming

- More data
    - nr_cotst in investment_return
    - vl_patrim_liq in investment_return
    - moviment in investment_return (captc_dia+rest_dia)
    - for Performance, Risk, Consistency, Sharpe
        - YTD
        - MTD
        - 1M
        - 3M
        - 6M
- Cleaning
    - Strange data for CNPJ 20815620000196 after 2018-05-15 (should it filter by nr_cotst? or should it filter buggy CNPJs?)
    - What's the deal with Infinity and NaN fields

### Pages

- Main
    - Overall indicators
        - Individual
        - History
    - Top Changes
        - Great Looser
        - Great Winners
        - Largest
        - Top Performers
        - Top Performer/Risk Ratio
        - Top Consistency
- Fund List
    - Column Selector
    - Filter
        - Risk Range
        - Consistency Range
        - Sharpe Range
        - Performance Range
        - Class
        - Benchmark
        - Avaliable at (Corretora)
        - Quote Fund
        - Exclusive Fund
        - Qualified Investor
        - Long Tax
    - Searcher
    - Table
        - Headers
            - Name
            - Net Worth
            - Risk
                - YTD
                - MTD
                - 1M
                - 3M
                - 6M
                - 1Y
                - 2Y
                - 3Y
            - Consistency
                - YTD
                - MTD
                - 1M
                - 3M
                - 6M
                - 1Y
                - 2Y
                - 3Y
            - Sharpe
                - YTD
                - MTD
                - 1M
                - 3M
                - 6M
                - 1Y
                - 2Y
                - 3Y
            - Performance                
                - YTD
                - MTD
                - 1M
                - 3M
                - 6M
                - 1Y
                - 2Y
                - 3Y
        - Row Content
            - Closed
                - Column selection
            - Open
                - Relative Period Selector
                - Series
                    - Risk
                    - Consistency
                    - Sharpe
                    - Performance
    - Navigator
- Fund Comparison
    - Fund Selector
        - Individual
        - Reference List
            - Broker
            - Class
            - Benchmark
    - Field Selector
        - X
        - Y
        - Size
        - Transparency
    - Bubble Chart
        - X
        - Y
        - Size
        - Transparency

### TODO

- [ ] Front-end
    - [ ] Main page
        - [X] v1 - Add github link
        - [ ] v2 - Add about
        - [X] v1 - Remove inexistent links
    - [ ] v3 - Indicators page
        - [ ] Chart feature
            - [ ] Indicators (CDI, Ibovesp, IPCA, IGM*)
            - [ ] Time range
            - [ ] Add Great Looser (Day, Month, Year)
            - [ ] Great Winners (Day, Month, Year)
            - [ ] Largest (Day, Month, Year)
            - [ ] Top Performers (Day, Month, Year)
            - [ ] Top Performer/Risk Ratio (Day, Month, Year)
            - [ ] Top Consistency (Day, Month, Year)
    - [ ] Fund list page
        - [ ] Changes to the fund list feature
            - [X] v2 - Remove search button from search panel
            - [X] v2 - Add net worth to the fund item
            - [X] v2 - Add number of quoteholders
            - [X] v2 - Add benchmark
        - [ ] Changes to the fund item feature
            - [X] v2 - Add time range buttons to choose which column will be used
            - [X] v2 - Add benchmark data
            - [X] v2 - Add benchmark button to choose the benchmark
        - [ ] Changes to the search feature
            - [X] v1 - Remove accents from the search term and results
            - [X] v2 - Move search button to the fund list header
        - [ ] Changes to the filter feature
            - [X] v1 - Add missing fields to filter
            - [X] v2 - Add filter suggestions
            - [X] v2 - Filter options must be dinamically determined
            - [X] v2 - Add net worth
            - [X] v2 - Add number of quoteholders
            - [X] v2 - Add benchmark
        - [ ] Changes to the order feature
            - [X] v1 - Add missing fields to order
            - [X] v1 - Replace (ASC) and (DESC) by icons
        - [ ] v3 - Add column selector
        - [ ] Changes to the code
            - [X] v1 - Componentize to an API lib
            - [X] v1 - Reorganize state
            - [ ] v2 - Componentize fund listing
            - [X] v1 - Componentize ui parts in separate components
            - [X] v1 - Add loading state
            - [X] v1 - Add error handling
    - [ ] v4 - Fund Comparison page 
        - [ ] Reuse fund list page
        - [ ] Add fund selector
        - [ ] Add bubble chart
    - [ ] v5 - Miscellaneous
        - [ ] Improve UI for mobile 
- [ ] Back-end
    - [ ] Worker
        - [X] v2 - Get Ibovespa Index
        - [X] v2 - Get IPCA index
        - [X] v2 - Get IGP* index
        - [X] v2 - Get SELIC index
        - [X] v2 - Add Ibovespa Index quote to investment return table
        - [X] v2 - Add CDI quote to investment return table
        - [X] v2 - Add IPCA quote to investment return table
        - [X] v2 - Add IGP* quote to investment return table
        - [X] v1 - Add an unaccented fund name to inf_cadastral    
        - [X] v2 - Add YTD, MTD, 1M, 3M, 6M performance, risk, sharpe and consistency to investment return table
        - [X] v2 - Add YTD, MTD, 1M, 3M, 6M quote performance, risk, sharpe and consistency to investment return table
        - [X] v2 - Add 1Y, 2Y, 3Y quote performance to investment return table
        - [X] v2 - Add nr_cotst to investment_return
        - [X] v2 - Add vl_patrim_liq to investment_return
        - [X] v2 - Add moviment to investment_return (captc_dia+rest_dia)
- [ ] Deployment
    - [X] v1 - Worker container
    - [X] v1 - Front-end deploy
    - [X] v1 - Scheduler container
    - [X] v1 - Expose only-specific end-points
    - [X] v1 - Create and use read-only user in the front-end
    - [ ] v2 - Add ratelimit to the proxy
    - [X] v1 - Monitor resource usage
    - [X] v2 - Improve ENV variable for worker
    - [X] v2 - Improve worker container for development
    - [X] v2 - Migrations
    - [X] v2 - Improve bundle size
- [ ] v5 - UX
    - [ ] Optimizations
        - [ ] Check response times


## Troubleshooting
Fix 15 minutes connection broken:

```
# docker run --net=host --ipc=host --uts=host --pid=host -it --security-opt=seccomp=unconfined --privileged --rm -v /:/host alpine /bin/sh

# chroot /host

# echo "net.ipv4.tcp_keepalive_time = 600" >> /etc/sysctl.d/00-alpine.conf
# echo "net.ipv4.tcp_keepalive_intvl = 30" >> /etc/sysctl.d/00-alpine.conf
# echo "net.ipv4.tcp_keepalive_probes = 10" >> /etc/sysctl.d/00-alpine.conf

# sysctl -p /etc/sysctl.d/00-alpine.conf

or

# docker run --net=host --ipc=host --uts=host --pid=host -it --security-opt=seccomp=unconfined --privileged --rm -v /:/host alpine /bin/sh -c "chroot /host && echo \"net.ipv4.tcp_keepalive_time = 600\" >> /etc/sysctl.d/00-alpine.conf && echo \"net.ipv4.tcp_keepalive_intvl = 30\" >> /etc/sysctl.d/00-alpine.conf && echo "net.ipv4.tcp_keepalive_probes = 10" >> /etc/sysctl.d/00-alpine.conf && sysctl -p /etc/sysctl.d/00-alpine.conf"
```