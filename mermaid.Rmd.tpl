---
title: "mermaidjs test"
author: "Hiroaki Yutani"
date: "`r Sys.Date()`"
output:
  OUTPUT_FORMAT
---

## test

```{r echo=FALSE}
library(DiagrammeR)

DiagrammeR("
  graph LR
    A-->B
    A-->C
    C-->E
    B-->D
    C-->D
    D-->F
    E-->F
")
```