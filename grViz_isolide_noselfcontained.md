# grViz test
Hiroaki Yutani  
`r Sys.Date()`  

## test

<!--html_preserve--><div id="htmlwidget-7357" style="width:720px;height:432px;" class="grViz"></div>
<script type="application/json" data-for="htmlwidget-7357">{"x":{"diagram":"\ndigraph G {\n      size = \"4,4\";\n      main [shape = box]; /* this is a comment */\n      main -> parse [weight = 8];\n      parse -> execute;\n      main -> init [style = dotted];\n      # main -> cleanup;\n      execute -> { make_string; printf}\n      init -> make_string;\n      edge [color = red]; // so is this\n      main -> printf;\n      node [shape = box, style = filled, color = \".7 .3 1.0\"];\n      execute -> compare;\n}","config":{"engine":"dot","options":null}},"evals":[]}</script><!--/html_preserve-->
