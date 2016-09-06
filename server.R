library("shiny")
library("datasets")
library("ggplot2")
library("ggplot2movies")
library("gridExtra")
library("cowplot")

mm <- movies

mm$Genre <- ifelse(mm$Action == 1,"Action",
                        ifelse(mm$Animation == 1,"Animation",
                               ifelse(mm$Comedy == 1,"Comedy",
                                      ifelse(mm$Drama == 1,"Drama",
                                             ifelse(mm$Documentary == 1,"Documentary",
                                                    ifelse(mm$Romance == 1,"Romance",
                                                           ifelse(mm$Short == 1,"Short","none")))))))

mm <- subset(mm, select=-c(Action,Animation,Comedy,Drama,Documentary,Romance,Short))

mm$length.bin <- cut(mm$length, c(0,100,200,300,400,500,600,6000))

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  

  # Genre
  output$plot0 <- renderPlot({
    g <- c()
    
    if(input$action) { g <- c(g,"Action") }
    if(input$animation) { g <- c(g,"Animation") }
    if(input$comedy) { g <- c(g,"Comedy") }
    if(input$drama) { g <- c(g,"Drama") }
    if(input$documentary) { g <- c(g,"Documentary") }
    if(input$romance) { g <- c(g,"Romance") }
    if(input$short) { g <- c(g,"Short") }
    if(input$none) { g <- c(g,"none") }
    
    mm <- mm[mm$Genre %in% g,]

    mm <- subset(mm, year > input$year[1] & year < input$year[2])
    mm <- subset(mm, length > input$length[1] & length < input$length[2])
    mm <- subset(mm, budget > input$budget[1] & budget < input$budget[2])
    mm <- subset(mm, rating > input$rating[1] & rating < input$rating[2])
    mm <- subset(mm, votes > input$votes[1] & votes < input$votes[2])
    
    
    p0 <- ggplot(mm,aes(x=Genre,y=rating)) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
    p0 <- p0 + geom_boxplot(aes(fill=Genre)) + ggtitle("Rating per Genre") + xlab("Genre") + ylab("IMDB Rating")
    
    p1 <- ggplot(mm, aes(x=year, y=rating))
    p1 <- p1 + geom_point(aes(color=Genre,size=budget)) + ggtitle("Rating per Genre") + xlab("Year") + ylab("IMDB Rating")

    
    grid.arrange(p0, p1,ncol=2)
    
    
  })
  #MPAA
  output$plot1 <- renderPlot({
    g <- c()
    
    if(input$action) { g <- c(g,"Action") }
    if(input$animation) { g <- c(g,"Animation") }
    if(input$comedy) { g <- c(g,"Comedy") }
    if(input$drama) { g <- c(g,"Drama") }
    if(input$documentary) { g <- c(g,"Documentary") }
    if(input$romance) { g <- c(g,"Romance") }
    if(input$short) { g <- c(g,"Short") }
    if(input$none) { g <- c(g,"None") }
    
    mm <- mm[mm$Genre %in% g,]
    
    mm <- subset(mm, year > input$year[1] & year < input$year[2])
    mm <- subset(mm, length > input$length[1] & length < input$length[2])
    mm <- subset(mm, budget > input$budget[1] & budget < input$budget[2])
    mm <- subset(mm, rating > input$rating[1] & rating < input$rating[2])
    mm <- subset(mm, votes > input$votes[1] & votes < input$votes[2])
    
    m <- mm
    m <- m[which(m$mpaa != ""),]
  
    p2 <- ggplot(m, aes(x=mpaa, y=rating))
    p2 <- p2 + geom_boxplot(aes(fill=mpaa)) + ggtitle("Rating per MPAA") + xlab("MPAA") + ylab("IMDB Rating")
    
    p3 <- ggplot(m, aes(x=year, y=rating))
    p3 <- p3 + geom_point(aes(color=mpaa,size=budget)) + ggtitle("Rating per MPAA") + xlab("Year") + ylab("IMDB Rating")
    
    grid.arrange(p2, p3,ncol=2)

  })
  #Length
  output$plot2 <- renderPlot({
    g <- c()
    
    if(input$action) { g <- c(g,"Action") }
    if(input$animation) { g <- c(g,"Animation") }
    if(input$comedy) { g <- c(g,"Comedy") }
    if(input$drama) { g <- c(g,"Drama") }
    if(input$documentary) { g <- c(g,"Documentary") }
    if(input$romance) { g <- c(g,"Romance") }
    if(input$short) { g <- c(g,"Short") }
    if(input$none) { g <- c(g,"None") }
    
    mm <- mm[mm$Genre %in% g,]
    
    mm <- subset(mm, year > input$year[1] & year < input$year[2])
    mm <- subset(mm, length > input$length[1] & length < input$length[2])
    mm <- subset(mm, budget > input$budget[1] & budget < input$budget[2])
    mm <- subset(mm, rating > input$rating[1] & rating < input$rating[2])
    mm <- subset(mm, votes > input$votes[1] & votes < input$votes[2])
    
    p4 <- ggplot(mm,aes(x=length.bin, y=rating))  + ggtitle("Rating per Length") + xlab("Length") + ylab("IMDB Rating")
    p4 <- p4 + geom_boxplot(aes(fill=length.bin))+ theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    p5 <- ggplot(mm,aes(x=year, y=rating))  + ggtitle("Rating per Length") + xlab("Length") + ylab("IMDB Rating")
    p5 <- p5 + geom_point(aes(color = length.bin,size=budget)) 
    
    grid.arrange(p4, p5,ncol=2)
    
  })
  
})