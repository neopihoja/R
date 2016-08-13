rm(list=ls(all=TRUE))
# get html data
library(XML)
library(httr)
library(xml2)
library(stringr)

testMoney2 <- function(starpage,endpage){
Sys.setlocale("LC_ALL", "cht")

part1_url <-"http://www.moneydj.com/KMDJ/Common/ListNewArticles.aspx?index1=" 
part3_url <- "&svc=NW&a=X0100001"
for(i in starpage:endpage){
  testurl <- paste(part1_url,i,part3_url,sep="")
 
  url <- testurl
  doc <- read_html(url)

  
  timexpath <- "//*[@id='ctl00_ctl00_MainContent_Contents_ArticleGridList1_gvList']//td[1]"
 #  [1] "\r\n            08/12 17:46\r\n        "
  time <- xml_text(xml_find_all(doc,timexpath))
 #  [1] "08/1217:46" "08/1216:16" "08/1210:19" "08/1208:44" "08/1208:44" "08/1116:18"
  time <- gsub(pattern="[[:space:]]",replacement="",x= time)   #time
#  [1] "08/12_17:46" "08/12_16:16" "08/12_10:19" "08/12_08:44" "08/12_08:44"
  time <- paste(substr(time,1,5),substr(time,6,nchar(time)),sep="_")
  
  titlexpath <- "//*[@id='ctl00_ctl00_MainContent_Contents_ArticleGridList1_gvList']//td/a"
  title <- xml_text(xml_find_all(doc, titlexpath))              #title
  title <- as.data.frame(title)
  time <- as.data.frame(time)
  MoneyDJForum <- cbind(title,time )
  file_name <- paste("./temp/",paste("newsPage_",i,sep=""),".txt",sep="")
  write.csv(MoneyDJForum,file=file_name)
}
}
