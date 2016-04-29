setClass("htmlText", representation(text="character",
                                   align="character",
                                   colspan="numeric"))
setClass("htmlTable", representation(table="data.frame",
                                     digits="numeric",
                                     htmlClass="character",
                                     colspan="numeric"))
setClass("htmlFig", representation(file="character",
                                  width="numeric",
                                  height="numeric"))
setClass("htmlCross", representation(X="matrix",
                                    digits="numeric",
                                    margins="logical"))
setClass("htmlList", representation(list="list",
                                   n="numeric"))

setMethod("print", "htmlText", function(x, ...) print.htmlText(x, ...))
setMethod("print", "htmlTable", function(x,...) print.htmlTable(x,...))
setMethod("print", "htmlList", function(x,...) print.htmlList(x,...))
setMethod("print", "htmlCross", function(x,...) print.htmlCross(x,...))
setMethod("print", "htmlFig", function(x,...) print.htmlFig(x,...))

## NEED SHOW FUNCTIONS
