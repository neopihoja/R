rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL = 'http://tradeinfo.sinyi.com.tw/itemList.html?a1=106&s2=10503_10508'
#orgURL = 'https://www.ptt.cc/bbs/StupidClown/index.html'

startPage = 1
endPage = 2
alldata = data.frame()
for( i in startPage:endPage)
{
  HOUSEPRICEURL <- paste(orgURL, '&p=', i, sep='')
  urlExists = url.exists(HOUSEPRICEURL)
  
  if(urlExists)
  {
    html = getURL(HOUSEPRICEURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    address = xpathSApply(xml, "//td[2]/a", xmlValue)
    housetype = xpathSApply(xml, "//*[@id="newTable"]//td[3]", xmlValue)
    totalprice = xpathSApply(xml, "//td[4]/span", xmlValue)
    averageprice = xpathSApply(xml, "//td[5]/span", xmlValue)
    tempdata = data.frame(address,housetype,totalprice,averageprice)
    alldata = rbind(alldata, tempdata)
  }
}

allDate = levels(alldata$date)
#res = hist(as.numeric(alldata$date), nclass=length(allDate), axes=F) 
#axis(1, at=1:length(allDate), labels=allDate)
#axis(2, at=1:max(res$counts), labels=1:max(res$counts))
