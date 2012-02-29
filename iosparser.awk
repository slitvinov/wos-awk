# regex filtering
# Usage:
# awk -v field=AU -v reg=Good -f iosparser.awk  nanopart/savedrecs.txt
# awk -v field=C1 -v reg=Lomonosov -f iosparser.awk  nanopart/savedrecs.txt
# 
# See two-character field tags
# http://images.webofknowledge.com/WOK45/help/WOS/h_fieldtags.html
# or tag.list

# parse affiliation record 
function parseC1() {
    ncf=split(record["C1"], ldata, "\n")
    for (i=1; i<ncf+1; i++) {
	nlf=split(ldata[i], lC1, "]")
	if (nlf>1) {
	    aff=lC1[2]
	    auth=lC1[1]"]"
	    if ( !(aff in aff_hash) ) {
		print aff, auth, record["DI"]
		aff_hash[aff]=1
	    }
	}
    }
}

!NF{
  # end of the record 
  if ( record[field] ~ reg ) {
    parseC1()
  }
    delete record
    tag=""
    next
}

$0!~/^ /  {
    # new tag
    record[tag]=data
    tag=$1; $1=""
    data=$0
    next
}

{
    data=data"\n"$0
}
