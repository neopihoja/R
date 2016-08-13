rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL = 'https://evertrust.yungching.com.tw/region/%E5%8F%B0%E5%8C%97%E5%B8%82/%E4%B8%8D%E9%99%90/'

startPage = 1
endPage = 10
alldata = data.frame()
for(i in startPage:endPage)
{
  URL = paste(orgURL, i, sep='')
  urlExists = url.exists(URL)
  if(urlExists)
  {
    html = getURL(HOUSEPRICEURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    address = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[3]", xmlValue)
    housetype = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[2]", xmlValue)
    totalprice = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[4]",xmlValue)
    averageprice = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[6]",xmlValue)
    floorspace = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[5]",xmlValue)
    floor = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[8]",xmlValue)
    age = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[9]",xmlValue)
    parkingspace = xpathSApply(xml, "//*[@id=\"dealtable\"]//td[10]",xmlValue)

    tempdata = data.frame(address,housetype,totalprice,averageprice,floorspace,floor,age,parkingspace)
    alldata = rbind(alldata, tempdata)
  }
}

write.csv(alldata,"alldata.csv")