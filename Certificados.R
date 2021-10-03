library(vroom)
library(tidyverse)
library(lubridate)
aver <- vroom("dato/certificados-personas-por-fecha-ingreso-provincia-localidad.csv")
glimpse(aver)
aver <- aver %>% 
  mutate(mes = month(fecha_ingreso, label = T, abbr = F))

cities <- aver %>% 
  group_by(provincia)

messi <- aver %>% 
  group_by(destino_provincia, mes) %>% 
  summarise(total = sum(cantidad_certificados))

ggplot()+
  geom_line(data=messi, aes(x=mes, y=total, group = 1))+
  facet_wrap(~destino_provincia)
  
glimpse(messi)

messi <- messi %>% 
  mutate(total = as.numeric(total),
         mes = as.factor(mes),
         destino_provincia = as.factor(destino_provincia))
