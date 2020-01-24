require(html)
setwd('~/tmp')
webSkeleton()

options(knitr.kable.NA = '')
print(htmlTable(head(airquality), class="sortable ctable"), file='web/index.html', append=TRUE)
