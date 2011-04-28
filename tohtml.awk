# make a href
function href(link, text) {
    return sprintf("<a href=\"%s\">%s</a>", link, text)
}

# truncate text
function trunc(text) {
    gsub("^[ ]*", "", text)
    gsub("[. ]*$", "", text)
    return text
}

# normalize to use in href
function norm(text) {
    text = trunc(text)
    gsub("[ &]", "+", text)
    return text
}


BEGIN {
    FS="]" 
    if (!notitle) {
	print "<html>"
	printf("<title>%s</title>\n", title)
    }
    printf("<H1>%s</H1>\n", title)
}
 
{
    print "<p>"
    split($1, ldata, "[")
    doi=$2
    aff=ldata[1]
    auth=ldata[2]
    doilink=sprintf("http://dx.doi.org/%s", norm(doi))
    afflink=sprintf("http://www.google.com/search?ie=UTF-8&oe=UTF-8&sourceid=navclient&gfns=1&q=%s", norm(aff))
    print href(afflink, trunc(aff)), auth,  href(doilink, "doi")
    print "</p>"
}

END {
    if (!notitle) print "</html>"
}