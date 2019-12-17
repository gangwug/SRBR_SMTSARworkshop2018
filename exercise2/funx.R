QvGene <- function(x) {
  
  cuts <- c(0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.005, 0.0005, 0.00005)
  QvG <- NULL
  
  for (i in 1:length(cuts)) {
    
    tp <- x %>% 
      group_by(dataset) %>% 
      summarise(genes = sum(JTK_BH.Q < cuts[i]))
    tp2 <- x %>% 
      filter(JTK_BH.Q < cuts[i]) %>%
      summarise(genes = sum(duplicated(CycID))) %>%
      mutate(dataset = "overlap") %>% select(dataset, genes)
    tp3 <- bind_rows(tp, tp2) %>%
      mutate(fdr = as.numeric(cuts[i]))
    QvG <- bind_rows(QvG, tp3)
    
    }
  QvG$dataset <- factor(QvG$dataset, levels = c("gold_std", "subset", "overlap"))
  
  return(QvG)
}
