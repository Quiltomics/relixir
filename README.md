# relixir
R/Elixir bindings for a more scalable, concurrent, fault-tolerant, distributed web tech world intimately connected to the R data science ecosystem.

## Why?
Because Shiny (shinyapps.io and Shiny Server Pro) and RStudio Connect are often [prohibitively expensive](https://www.rstudio.com/pricing/) (e.g., $74,995 per year for 1000 named users, with each additional named user packs of 250 for $14,995) and are often too slow to [load](https://community.rstudio.com/t/improving-shiny-app-loading-speed/5126) and/or [run](https://support.rstudio.com/hc/en-us/articles/115000171848-Why-are-my-Shiny-apps-are-running-slowly-).  Alternatives like [openCPU](https://github.com/opencpu/opencpu) and [fiery](https://github.com/thomasp85/fiery) are needed and very welcome, but can they support [2 million concurrent connections](http://phoenixframework.org/blog/the-road-to-2-million-websocket-connections) on a single server like Elixir can?  And that was from 2015!  By contrast, Shiny _just_ recently announced the ability to handle 10000 active users at rstudio::conf 2018 ([skip to 17:16 in this video for live demo and applause](https://www.rstudio.com/resources/videos/scaling-shiny/)).         

## Rage against the machine
Paywalling web applications is good business but bad for the open-source community and can often be a slippery slope -- if one had a dollar to give every time they heard "use Python for building serious large-scale web apps", (s)he would be bankrupt.  For the Djangonauts out there, [the following](https://cheesecakelabs.com/blog/phoenix-framework-guide-django-programmers/) can be a sobering read from a fellow Djangonaut.

## Goal
Position R firmly in the high-traffic web application world, where stability and performance under massive concurrency and load are a right, not a pay-walled privilege.  

## Open-source community outreach
At Bioquilt, we use Elixir to power our web stack while using R and Python to power our data science and machine learning.  Other companies using Elixir and open-sourcing tools for the community include [Pinterest](https://venturebeat.com/2015/12/18/pinterest-elixir/) and [WhatsApp](https://www.wired.com/2015/09/whatsapp-serves-900-million-users-50-engineers/), recently sold to Facebook for $16 billion.  Here's a list of [10 companies that use Elixir in production](https://www.netguru.co/blog/10-companies-use-elixir).  

## Roadmap
- [ ] Extend [erserve](https://github.com/del/erserve) from Erlang to Elixir for the purposes of making calls to R from Elixir (where Elixir is effectively "Erlang++")
- [ ] Trailblaze new code for calling Elixir from R
- [ ] Once `R <--> Elixir` bridge is complete, wrap up the methods into a package like [reticulate](https://github.com/rstudio/reticulate) 

## Authors
[Trang Tran](https://github.com/ttdtrang) and [Bohdan Khomtchouk, Ph.D.](https://github.com/Bohdan-Khomtchouk)
