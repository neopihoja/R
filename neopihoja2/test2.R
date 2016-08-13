rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL = 'https://buy.housefun.com.tw/%E8%B2%B7%E5%B1%8B/%E5%8F%B0%E5%8C%97%E5%B8%82?'
#orgURL = 'https://www.ptt.cc/bbs/StupidClown/index.html'

startPage = 1
endPage = 3
alldata = data.frame()
for( i in startPage:endPage)
{
  HOUSEPRICEURL <- paste(orgURL, '&hd_PM=', i, sep='')
  urlExists = url.exists(HOUSEPRICEURL)
  
  if(urlExists)
  {
    html = getURL(HOUSEPRICEURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    title = xpathSApply(xml, "//h1[@class='casename']", xmlValue)
    address = xpathSApply(xml, "//address[@class='address']", xmlValue)
    tempdata = data.frame(title, address)
    alldata = rbind(alldata, tempdata)
  }
}

allDate = levels(alldata$date)
#res = hist(as.numeric(alldata$date), nclass=length(allDate), axes=F) 
#axis(1, at=1:length(allDate), labels=allDate)
#axis(2, at=1:max(res$counts), labels=1:max(res$counts))

write.csv(alldata,"alldata.csv")